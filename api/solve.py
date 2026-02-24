# import tkinter as tk
# from tkinter import ttk, messagebox, filedialog
import json
import numpy as np
from scipy.optimize import fsolve
import math


class JsonBranchesViewer:
    """
    ГЕНЕРАТОР УРАВНЕНИЙ ГИДРАВЛИЧЕСКИХ СЕТЕЙ ИЗ JSON
    
    ФУНКЦИОНАЛ:
    Загрузка JSON с ветками (branchDetails)
    Парсинг: извлечение L, Kt, оросителей из "rows" 
    Визуализация: все ветки + черные соединения (L=1m, Kt=110)
    Уравнения: P1_A фиксирован, остальные P1 рассчитываются
    Синий текст на белом фоне + панорамирование/зум
    """
    #===============================================================================
    # ГЛАВНЫЙ КОНСТРУКТОР КЛАССА
    #===============================================================================   
    def __init__(self, data):
        """Инициализация главного окна и переменных"""

        
        # 📊 ДАННЫЕ ИЗ JSON (после парсинга)
        self.data = data                    # Исходный JSON
        self.branches = {}                  # dict{ 'а': {...}, 'б': {...} }
        self.branch_end_positions = {}      # dict{ 'а': (x1,y1), 'б': (x2,y2) }
              
        
        # 🔥 СОЛВЕР - НОВЫЕ ПЕРЕМЕННЫЕ
        self.var_count = 0
        self.var_names = []
        self.constants = {}
        self.connection_params = {}
        self.solution = None
        self.results_text = None
        self.equations_func = None
        self.parse_branches()       # ← Парсинг в self.branches
        # self.update_equations(f"✅ JSON загружен\n📊 Найдено веток: {len(self.branches)}")
        

              
    #===============================================================================
    # ГЛАВНЫЙ ПАРСЕР JSON
    #===============================================================================           
    def parse_branches(self):
        """ПАРСИНГ JSON → self.branches + ✅ k_factor ИЗ sprinkler!"""
        print("=" * 100)
        print("НАЧАНАЕМ parse_branches()")
        print("=" * 100)
        
        self.branches = {}
        
        # k_factor ИЗ "sprinkler" в КОРНЕ JSON!
        sprinkler_data = self.data.get("sprinkler", {})
        k_factor_global = float(sprinkler_data.get("k_factor", 0.0239))
        print(f"sprinkler.k_factor = {k_factor_global} (из КОРНЯ JSON)")
        
        if "branchDetails" in self.data:
            print(f"branchDetails: {len(self.data['branchDetails'])} веток")
            
            for key, branch_data in self.data["branchDetails"].items():
                print(f"\n ВЕТКА (key='{key}'):")
                branch_num = branch_data.get("branch_num", "")
                print(f"  branch_num = '{branch_num}'")
                
                if branch_num:
                    print(f"   '{branch_num}' — {len(branch_data.get('rows', []))} строк")
                    
                    #  1. p1_fixed
                    p1_fixed = 18.50
                    if branch_num == "а":
                        p1_fixed = branch_data.get("p1_fixed", 18.50)
                    branch_data["p1_fixed"] = p1_fixed
                    print(f"  p1_fixed = {p1_fixed}")
                    
                    # 2. k_factor ИЗ sprinkler ГЛОБАЛЬНО!
                    branch_data["k_factor"] = k_factor_global
                    print(f"  K[{branch_num}] = {k_factor_global}")
                    
                    # 3. ФИКС name (укороченный)
                    print(f"  🔧 Фиксим name...")
                    fixed_count = 0
                    for row in branch_data["rows"]:
                        raw_name = row.get("name", "")
                        if isinstance(raw_name, str) and ('"name":' in raw_name or raw_name.startswith('"name"')):
                            clean_name = raw_name.split('"name": "')[1].rstrip('"') if '"name": "' in raw_name else raw_name[1:-1]
                            row["name"] = clean_name
                            fixed_count += 1
                    print(f"  Фикс name: {fixed_count} строк")
                    
                    # 4. СЧЁТЧИКИ
                    segments = []
                    sprinkler_count = 0
                    for row in branch_data["rows"]:
                        if row.get("is_sprinkler", False):
                            sprinkler_count += 1
                        elif "Участок" in str(row.get("name", "")) and row.get("length", "-") != "-":
                            segments.append({
                                "length": float(row["length"]),
                                "kt": float(branch_data.get("kt", 110.0)),
                                "name": row["name"]
                            })
                    
                    branch_data["sprinkler_count"] = sprinkler_count
                    branch_data["segments"] = segments
                    self.branches[branch_num] = branch_data
                    
                    print(f" '{branch_num}': K={k_factor_global}, {sprinkler_count} оросителей, {len(segments)} участков")
            
            print(f"\n ГОТОВО! Ветки: {list(self.branches.keys())}")
            for bn in self.branches:
                print(f"  '{bn}': K={self.branches[bn]['k_factor']}")
        else:
            print(" 'branchDetails' НЕ НАЙДЕН!")
        
        print("=" * 100)
        # self.update_equations(f" K={k_factor_global} для {len(self.branches)} веток")

    #===============================================================================
    # СОБИРАЕМ УРАВНЕНИЯ ДЛЯ СВЯЗИ ВЕТОК И ДЛЯ ПОДАЮЩЕГО ТРУБОПРОВОДА
    #===============================================================================
    def generate_connection_equations(self):
        """🔗 Qa45=Qаб + ✅ КИРИЛЛИЧЕСКИЕ Lаб, Ktаб В НАЧАЛЕ"""
        if not self.branches:
            return []
        
        branch_list = sorted(self.branches.keys())
        connection_eqs = []
        
        #######################################################
        # 🔥 0. ✅ ПАРАМЕТРЫ СОЕДИНЕНИЙ С КИРИЛЛИЧЕСКИМИ ИМЁНАМИ
        #######################################################
        connection_eqs.append("#" + "="*60)
        connection_eqs.append("# 📏 ПАРАМЕТРЫ СОЕДИНЕНИЙ (Lаб, Ktаб, Lбв...)")
        connection_eqs.append("#" + "="*60)
        
        connection_params = {}
        for i in range(1, len(branch_list)):
            prev_branch = branch_list[i-1]
            curr_branch = branch_list[i]
            
            # ✅ КИРИЛЛИЧЕСКИЕ ИМЁНА: Lаб, Ktаб, Lбв, Ktбв...
            L_name = f"L{prev_branch}{curr_branch}"
            Kt_name = f"Kt{prev_branch}{curr_branch}"
            
            # Параметры из узла curr_branch (последняя строка)
            branch_rows = self.branches[curr_branch]["rows"]
            last_row = branch_rows[-1]
            L_conn = last_row.get("length", "1.0")
            Kt_conn = self.branches[curr_branch].get("kt", "110.0")
            
            connection_params[f"{prev_branch}{curr_branch}"] = {"L": L_conn, "Kt": Kt_conn}
            
            # 🔥 ✅ ФОРМАТ: комментарий + объявление констант
            connection_eqs.append(f"# 🔗 {prev_branch}-{curr_branch}: {L_name}={L_conn}m, {Kt_name}={Kt_conn}")
            connection_eqs.append(f"{L_name} = {L_conn}")
            connection_eqs.append(f"{Kt_name} = {Kt_conn}")
            connection_eqs.append("")
        
        #######################################################
        # 🔥 1. FEED PIPE ПАРАМЕТРЫ
        #######################################################
        feed_pipe = self.data.get("feedPipe", {})
        feed_L = feed_pipe.get("length", 62)
        feed_Kt = feed_pipe.get("kt", 36920)
        connection_eqs.extend([
            f"# 📡 FEED PIPE: L_feed_pipe={feed_L}m, Kt_feed_pipe={feed_Kt}",
            f"L_feed_pipe = {feed_L}",
            f"Kt_feed_pipe = {feed_Kt}",
            ""
        ])
        
        #######################################################
        # 🔥 2. ПОТОКИ ПОСЛЕДНИХ УЗЛОВ = ПОТОКИ СОЕДИНЕНИЙ
        #######################################################
        for i, branch_num in enumerate(branch_list):
            n_sprinklers = self.branches[branch_num]["sprinkler_count"]
            last_Q = f"Q{branch_num}{n_sprinklers}{n_sprinklers+1}"
            
            if i < len(branch_list) - 1:
                next_branch = branch_list[i+1]
                connection_eqs.append(f"{last_Q}=Q{branch_num}{next_branch}")  # Qа45=Qаб
            else:
                connection_eqs.append(f"{last_Q}=Qfeed_pipe12")               # Qг56=Qfeed_pipe12
        
        #######################################################
        # 🔥 3. НАПОРЫ ПОСЛЕДНИХ УЗЛОВ = НАПОРЫ УЗЛОВ ВЕТОК
        #######################################################
        for branch_num in branch_list:
            n_sprinklers = self.branches[branch_num]["sprinkler_count"]
            last_P = f"P{branch_num}{n_sprinklers}"
            connection_eqs.append(f"{last_P}=P{branch_num}")                 # Pа4=Pа
        
        #######################################################
        # 🔥 4. БАЛАНСЫ РАСХОДОВ НА СОЕДИНЕНИЯХ (узловые балансы)
        #######################################################
        for i in range(1, len(branch_list)):
            prev_branch = branch_list[i-1]
            curr_branch = branch_list[i]
            
            Q_in = f"Q{prev_branch}{curr_branch}"                            # Входящий поток
            n_sprinklers_curr = self.branches[curr_branch]["sprinkler_count"]
            Q_branch = f"Q{curr_branch}{n_sprinklers_curr}{n_sprinklers_curr+1}"  # Поток ветки
            
            if i == len(branch_list) - 1:
                Q_out = "Qfeed_pipe12"                                       # Последняя → feed
            else:
                next_branch = branch_list[i+1]
                Q_out = f"Q{curr_branch}{next_branch}"                       # → следующая ветка
            
            connection_eqs.append(f"{Q_branch}+{Q_in}={Q_out}")              # Баланс узла
        
        #######################################################
        # 🔥 5. ПОТЕРИ НАПОРА НА СОЕДИНЕНИЯХ ΔP = Q²×L/Kt
        #######################################################
        for i in range(1, len(branch_list)):
            prev_branch = branch_list[i-1]
            curr_branch = branch_list[i]
            conn_key = f"{prev_branch}{curr_branch}"
            
            L_conn = connection_params[conn_key]["L"]
            Kt_conn = connection_params[conn_key]["Kt"]
            
            Q_conn = f"Q{prev_branch}{curr_branch}"
            deltaP = f"deltaP{prev_branch}{curr_branch}"
            
            connection_eqs.append(f"{deltaP} = {Q_conn}**2*{L_conn}/{Kt_conn}")  # Потери напора
            connection_eqs.append(f"P{curr_branch} = P{prev_branch} + {deltaP}") # Связь напоров
        
        #######################################################
        # 🔥 6. FEED PIPE УРАВНЕНИЯ
        #######################################################
        last_branch = branch_list[-1]
        Q_feed = "Qfeed_pipe12"
        connection_eqs.extend([
            f"P{last_branch} = P1feed_pipe",                                 # Напор на входе
            f"P2feed_pipe = P1feed_pipe + {Q_feed}**2*L_feed_pipe/Kt_feed_pipe"  # Потери в feed
        ])
        
        #######################################################
        # 💾 СОХРАНЕНИЕ И ВОЗВРАТ
        #######################################################
        self.connection_params = connection_params
        return connection_eqs
        
    #===============================================================================
    # ПОЛНЫЙ ВЫВОД УРАВНЕНИЙ С ПОДСТАВЛЕННЫМИ ПАРАМЕТРАМИ
    #===============================================================================
    def display_full_equations(self):
        """📊 ПРАВИЛЬНЫЙ ВЫВОД С FIKSIROVANNYM Pa1=18.5"""
        if not self.solution:
            return
        
        self.results_text.config(state="normal")
        self.results_text.delete(1.0, tk.END)
        
        results = []
        X_dict = self.solution['X']
        p1_fixed = self.branches['а']['p1_fixed']  # 🔥 18.5 БАР!
        
        # 📈 СВОДКА
        results.append("="*80)
        results.append("✅ ГИДРАВЛИЧЕСКИЙ РАСЧЕТ")
        results.append(f"Переменных: {self.var_count}")
        results.append(f"Max|F|: {self.solution['max_residual']:.2e}")
        results.append("")
        
        # 🔥 ФИКСИРОВАННЫЕ ЗНАЧЕНИЯ
        results.append("🔥 ФИКСИРОВАННЫЕ ПАРАМЕТРЫ:")
        results.append(f"  Pa1 = P1_A_FIXED = {p1_fixed} бар")
        results.append("")
        
        # 💧 УРАВНЕНИЯ ОРОСИТЕЛЕЙ - ПРАВИЛЬНЫЙ РАСЧЕТ!
        results.append("💧 ПРОВЕРКА УРАВНЕНИЙ Q = K × √P:")
        results.append("-" * 60)
        
        for branch_num in sorted(self.branches.keys()):
            n_spr = self.branches[branch_num]["sprinkler_count"]
            K = self.constants[f'K_{branch_num}']
            
            results.append(f"  # Ветка {branch_num} (K={K:.4f})")
            
            for i in range(n_spr):
                q_var = f"Q{branch_num}{i+1}"
                p_var = f"P{branch_num}{i+1}"
                
                if q_var in X_dict:
                    # 🔥 ПРАВИЛЬНО: для первого оросителя ветки 'а' используем 18.5!
                    if branch_num == 'а' and i == 0:
                        P_used = p1_fixed  # 18.5 бар!
                        results.append(f"  🔸 {q_var}({X_dict[q_var]:6.4f}) =? {K:.4f}×√{p1_fixed:5.1f} = {K*math.sqrt(p1_fixed):6.4f} | ΔF={X_dict[q_var]-(K*math.sqrt(p1_fixed)):.2e}")
                    else:
                        if p_var in X_dict:
                            P_used = X_dict[p_var]
                            Q_calc = K * math.sqrt(max(0.01, P_used))
                            results.append(f"  {q_var}({X_dict[q_var]:6.4f}) =? {K:.4f}×√{p_var}({P_used:6.3f}) = {Q_calc:6.4f} | ΔF={X_dict[q_var]-Q_calc:.2e}")
                        else:
                            results.append(f"  ⚠️ {q_var}({X_dict[q_var]:6.4f}) | P{i+1} отсутствует")
            results.append("")
        
        # 📊 РЕЗУЛЬТАТЫ
        results.append("📊 ИТОГОВЫЕ РАСХОДЫ:")
        results.append("-" * 40)
        total_flow = 0
        
        for branch_num in sorted(self.branches.keys()):
            branch_flow = sum(X_dict.get(f"Q{branch_num}{i+1}", 0) for i in range(self.branches[branch_num]["sprinkler_count"]))
            total_flow += branch_flow
            results.append(f"🔸 ВЕТКА {branch_num}: {branch_flow:7.4f} м³/с")
        
        results.append(f"🌊 ОБЩИЙ РАСХОД: {total_flow:7.4f} м³/с")
        results.append(f"✅ ТОЧНОСТЬ: Max|F| = {self.solution['max_residual']:.2e}")
        
        # self.results_text.insert(tk.END, "\n".join(results))
        self.results_text.config(state="disabled")
    
    #===============================================================================
    # ИЗВЛЕЧЕНИЕ КОНСТАНТ ИЗ JSON
    #===============================================================================    
    def extract_abd_constants_from_json(self):
        """🔧 Извлекает константы A+B+D из JSON для передчи в решатель"""
        if len(self.branches) < 2:
            return None
        
        branchlist = sorted(self.branches.keys())
        branchA = self.branches[branchlist[0]]  # Ветка A
        branchB = self.branches[branchlist[1]]  # Ветка B
        
        # Из JSON:
        sprinkler = self.data.get('sprinkler', {})
        K = float(sprinkler.get('kfactor', 0.47))
        P1_A_FIXED = branchA.get('p1fixed', 19.17)
        
        # Segments → L и Kt (как в parse_branches)
        L_A, Kt_A = [], []
        for row in branchA.get('rows', []):
            if row.get('length', '-') != '-' and not row.get('issprinkler', False):
                L_A.append(float(row.get('length', 2.0)))
                Kt_A.append(float(branchA.get('kt', 28.7)))
        
        L_B, Kt_B = [], []
        for row in branchB.get('rows', []):
            if row.get('length', '-') != '-' and not row.get('issprinkler', False):
                L_B.append(float(row.get('length', 2.0)))
                Kt_B.append(float(branchB.get('kt', 28.7)))
        
        # D параметры (пока дефолт, потом из JSON)
        L_D = 2.0
        Kt_D = 28.7
        
        return {
            'P1_A_FIXED': P1_A_FIXED, 'K': K,
            'L_SEGMENTS_A': L_A[:5], 'Kt_A': Kt_A[:5],  # 5 сегментов
            'L_SEGMENTS_B': L_B[:5], 'Kt_B': Kt_B[:5],
            'L_D': L_D, 'Kt_D': Kt_D
        } 
        
    #===============================================================================
    # ГЛАВНЫЙ СОЛВЕР
    #===============================================================================
    def solve_network(self):
        """🔗 GUI → JSON → SOLVER → JSON → ТАБЛИЦА"""
        try:
            # 1. Генерируем уравнения и данные
            self.collect_solver_data()
            self.generate_equations_display()
            
            # 2. Создаем JSON для солвера
            solver_data = {
                'equations_code': self.equations_code,
                'var_names': self.var_names,
                'constants': self.constants,
                'connection_params_display': self.connection_params_display,
                'branches': self.branches,
                'var_count': self.var_count,
                'feed_pipe': self.data.get('feedPipe', {})
            }
            
            # 3. Сохраняем input JSON
            input_json = "solver_input.json"
            with open(input_json, 'w', encoding='utf-8') as f:
                json.dump(solver_data, f, ensure_ascii=False, indent=2)
            
            # 4. Запускаем солвер
            import subprocess
            result = subprocess.run([
                sys.executable, "SOLVER_EQUATION_BY_JSON.py", input_json
            ], capture_output=True, text=True, timeout=30)
            
            if result.returncode != 0:
                self.show_solver_error(f"SOLVER ОШИБКА:\n{result.stderr}")
                return
            
            # 5. Загружаем результаты из results JSON
            with open("solver_results.json", 'r', encoding='utf-8') as f:
                results = json.load(f)
            
            # 6. Показываем таблицу!
            self.display_results_table(results)
            
        except Exception as e:
            self.show_solver_error(f"❌ {str(e)}")
    

    # ПОДГОТОВКА ДАННЫХ ДЛЯ Fsolve
    #===============================================================================
    def collect_solver_data(self):
        """🔍 СОБИРАЕМ ВСЕ ПЕРЕМЕННЫЕ + ✅ Pa1 ДОБАВЛЕН!"""
        self.var_names = []
        self.constants = {}
        branch_list = sorted(self.branches.keys())
        
        print(f"🔍 Собираем данные для {len(branch_list)} веток: {branch_list}")
        
        # 📊 КОНСТАНТЫ ВЕТОК
        for branch_num in branch_list:
            branch_data = self.branches[branch_num]
            L_SEGMENTS = [s["length"] for s in branch_data["segments"]]
            Kt_SEGMENTS = [s["kt"] for s in branch_data["segments"]]
            n_sprinklers = branch_data["sprinkler_count"]
            
            # Константы
            self.constants[f'L_SEGMENTS_{branch_num.upper()}'] = L_SEGMENTS
            self.constants[f'Kt_{branch_num.upper()}'] = Kt_SEGMENTS
            self.constants[f'K_{branch_num}'] = branch_data["k_factor"]
            self.constants[f'P1_FIXED_{branch_num}'] = branch_data["p1_fixed"]
            
            print(f"  📊 {branch_num}: {n_sprinklers} оросителей, {len(L_SEGMENTS)} участков")
            
            # 🔥 ✅ ПЕРЕМЕННЫЕ ВЕТКИ (Q и P для КАЖДОГО оросителя)
            for i in range(n_sprinklers):
                self.var_names.extend([f"Q{branch_num}{i+1}", f"P{branch_num}{i+1}"])  # ✅ Pa1 здесь!
            
            # Q участков
            for i in range(len(L_SEGMENTS)):
                self.var_names.append(f"Q{branch_num}{i+1}{i+2}")
            
            # Узел ветки: P{branch_num}, Q{branch_num}45
            self.var_names.extend([f"P{branch_num}", f"Q{branch_num}45"])
        
        # 🔗 СОЕДИНЕНИЯ
        for i in range(1, len(branch_list)):
            prev = branch_list[i-1]
            curr = branch_list[i]
            self.var_names.extend([f"Q{prev}{curr}", f"deltaP{prev}{curr}"])
            self.connection_params[f"{prev}{curr}"] = {
                "L": float(self.branches[curr]["rows"][-1].get("length", 1.0)),
                "Kt": float(self.branches[curr].get("kt", 110.0))
            }
        
        # Feed pipe
        feed_pipe = self.data.get("feedPipe", {})
        self.constants['L_feed_pipe'] = float(feed_pipe.get("length", 62))
        self.constants['Kt_feed_pipe'] = float(feed_pipe.get("kt", 36920))
        self.var_names.extend(["Qfeed_pipe12", "P1feed_pipe", "P2feed_pipe"])
        
        self.var_count = len(self.var_names)
        print(f"✅ ГОТОВО: {self.var_count} переменных")
        print(f"✅ Первые 10: {self.var_names[:10]}")
        
    def parse_constants_from_text(self):
        """🔍 ИЗВЛЕКАЕТ Lаб=3.0, Ktаб=110 ИЗ ВАШЕГО ТЕКСТА"""
        constants = {}
        
        lines = self.equations_code.split('\n')
        for line in lines:
            line = line.strip()
            
            # Lаб = 3.0 → {'Lаб': 3.0}
            if '=' in line and not line.startswith('#'):
                var_name, value_str = line.split('=', 1)
                var_name = var_name.strip()
                value_str = value_str.strip()
                
                try:
                    # ЧИСЛА, СПИСКИ
                    if '[' in value_str:
                        value = eval(value_str)  # [2.8, 2.8, ...]
                    else:
                        value = float(value_str)  # 3.0, 110.0
                    
                    constants[var_name] = value
                    print(f"✅ Константа: {var_name} = {value}")
                    
                except:
                    continue  # Пропускаем ошибки
        
        return constants
    
    def create_equations_function_from_parsed(self):
        """🎯 EXEC ИЗ ПАРСЕД ТЕКСТА"""
        # 🔥 ВСЕ КОНСТАНТЫ ИЗ ТЕКСТА + self.constants
        all_constants = {**self.parse_constants_from_text(), **self.constants}
        
        global_ns = {
            'np': np, 'math': math, 
            'VAR_NAMES': self.var_names,
            **all_constants  # Lаб, Ktаб, L_feed_pipe...
        }
        
        # 🔥 EXEC ПОЛНОГО КОДА ИЗ ОКНА!
        exec(self.equations_code, global_ns)
        self.equations_func = global_ns['hydraulic_network_equations']
        
        # 🔥 ТЕСТ
        test_X = np.ones(self.var_count) * 0.01
        F_test = self.equations_func(test_X)
        print(f"✅ ТЕСТ: Max|F| = {np.max(np.abs(F_test)):.2e}")


        
    #===============================================================================
    # СОЗДАЁТ Fsolve ФУНКЦИЮ ИЗ УРАВНЕНИЙ
    #===============================================================================
    def create_equations_function(self):
        """🔧 ПАРСИТ ВАШИ УРАВНЕНИЯ ИЗ ТЕКСТА → fsolve()"""
        
        if not hasattr(self, 'equations_code') or not self.equations_code:
            raise ValueError("❌ Сначала соберите уравнения!")
        
        # 🔥 1. ПАРСИМ ВСЕ КОНСТАНТЫ ИЗ ТЕКСТА
        constants = self.parse_constants_from_text()
        
        # 🔥 2. ГЛАВНЫЙ NAMESPACE
        global_ns = {
            'np': np, 
            'math': math, 
            'VAR_NAMES': self.var_names,
            **constants,  # Lаб=3.0, Ktаб=110.0, L_feed_pipe=62...
            **self.connection_params
        }
        
        # 🔥 3. EXEC ПОЛНОГО КОДА ИЗ ОКНА
        exec(self.equations_code, global_ns)
        self.equations_func = global_ns['hydraulic_network_equations']
        
        print("✅ Функция создана из текста! Переменных:", self.var_count)
        print("🔍 Пример X_dict:", dict(list(global_ns.get('VAR_NAMES', []))[:5]))

    
    #===============================================================================
    # ГЛАВНЫЙ РЕШАТЕЛЬ СИСТЕМЫ УРАВНЕНИЙ
    #===============================================================================
    def run_fsolve(self):
        """⚡ РЕШАЕМ"""
        x0 = np.ones(self.var_count) * 0.01
        for i, name in enumerate(self.var_names):
            if name.startswith('P'): x0[i] = 5.0
        
        solution = fsolve(self.equations_func, x0, full_output=True)
        X = solution[0]
        F_final = self.equations_func(X)
        
        self.solution = {
            'X': dict(zip(self.var_names, X)),
            'F': F_final,
            'max_residual': float(np.max(np.abs(F_final))),
            'iterations': solution[1].get('nfev', 0)
        }
        
    #===============================================================================
    # ПОКАЗЫВАЕТ РЕЗУЛЬТАТЫ Fsolve В UI
    #===============================================================================

    def show_solver_error(self, error):
        """❌ Ошибка"""
        self.results_text.config(state="normal")
        self.results_text.delete(1.0, tk.END)
        self.results_text.insert(tk.END, f"❌ ОШИБКА: {error}")
        self.results_text.config(state="disabled")
            
    def build_all_branches(self):
        """🎨 ВСЕ ВЕТКИ + FEED-PIPE + ДЛИНЫ СОЕДИНЕНИЙ НА УЗЛАХ!"""
        if not self.branches:
            return
        
        self.canvas.delete("all")
        self.branch_end_positions = {}
        px_per_m = 80 * self.scale
        
        start_x = 100 * self.scale + self.offset_x
        y_offset = 160 * self.scale
        
        branch_list = sorted(self.branches.keys())
        
        # 1️⃣ РИСОВАНИЕ ВСЕХ ВЕТОК
        for i, branch_num in enumerate(branch_list):
            y_start = 40 * self.scale + self.offset_y + i * y_offset
            self.draw_branch(branch_num, start_x, y_start, px_per_m)
        
        # 2️⃣ ✅ СОЕДИНЕНИЯ + ДЛИНЫ ПО ЦЕНТРУ ЛИНИИ!
        for i in range(len(branch_list)-1):
            branch1 = branch_list[i]
            branch2 = branch_list[i+1]
            
            if branch1 in self.branch_end_positions and branch2 in self.branch_end_positions:
                center1_x, center1_y = self.branch_end_positions[branch1]
                center2_x, center2_y = self.branch_end_positions[branch2]
                
                # 📏 РАСЧЕТ ДЛИНЫ
                distance_px = ((center2_x - center1_x)**2 + (center2_y - center1_y)**2)**0.5
                distance_m = distance_px / px_per_m
                
                # ─── ЛИНИЯ ───
                line_id = self.canvas.create_line(center1_x, center1_y, center2_x, center2_y, 
                                                width=6*self.scale, fill="darkgreen", 
                                                capstyle=tk.ROUND, tags="pipes")
                self.canvas.lower(line_id)
                
                # 📋 ✅ ПОДПИСЬ ПО ЦЕНТРУ ЛИНИИ СОЕДИНЕНИЯ
                mid_x = (center1_x + center2_x) / 2      # ← ПО ЦЕНТРУ ПО X
                mid_y = (center1_y + center2_y) / 2      # ← ПО ЦЕНТРУ ПО Y
                self.canvas.create_text(
                    mid_x + 15*self.scale, mid_y,           # ← ЧУТЬ СПРАВА ОТ ЦЕНТРА
                    text=f"L={distance_m:.1f}m",
                    font=("Arial", int(10*self.scale), "bold"),
                    fill="darkblue", anchor="w", tags="labels"
                )
                
        # 3️⃣ ✅ VERTICAL FEED-PIPE С КОРРЕКТНЫМИ ПОДПИСЯМИ!
        last_branch = branch_list[-1]
        if last_branch in self.branch_end_positions:
            last_node_x, last_node_y = self.branch_end_positions[last_branch]
            
            feed_data = self.get_feed_pipe_data(last_branch)
            feed_length = feed_data["length"]
            feed_kt = feed_data["kt"]
            
            segment_height = 100 * self.scale
            segments = 3
            current_y = last_node_y
            
            # 🟤 НАЧАЛЬНЫЙ УЗЕЛ
            r_start = 16 * self.scale
            self.canvas.create_oval(
                last_node_x-r_start, current_y-r_start,
                last_node_x+r_start, current_y+r_start,
                fill="black", outline="white", width=3*self.scale
            )
            
            for seg_idx in range(segments):
                seg_start_y = current_y
                seg_end_y = current_y + segment_height
                
                # ─── ЛИНИЯ УЧАСТКА ───
                self.canvas.create_line(
                    last_node_x, seg_start_y, last_node_x, seg_end_y,
                    width=10*self.scale, fill="black", capstyle=tk.ROUND, tags="feed_pipe"
                )
                
                # 📏 ✅ ПОДПИСЬ ПО ЦЕНТРУ УЧАСТКА (вертикальная линия)
                seg_length = float(feed_length) / segments
                text_y = (seg_start_y + seg_end_y) / 2
                self.canvas.create_text(
                    last_node_x + 80*self.scale,  # ← СПРАВА ОТ ЛИНИИ
                    text_y,                        # ← ПО ЦЕНТРУ ПО ВЫСОТЕ
                    text=f"L={seg_length:.1f}m\nKt={feed_kt}",
                    font=("Arial", int(10*self.scale), "bold"),
                    fill="black", anchor="w", tags="labels"
                )
                current_y = seg_end_y
            
            # 🟤 КОНЕЧНЫЙ УЗЕЛ
            r_end = 18 * self.scale
            self.canvas.create_oval(
                last_node_x-r_end, current_y-r_end,
                last_node_x+r_end, current_y+r_end,
                fill="black", outline="white", width=3*self.scale
            )
            
            self.canvas.create_text(
                last_node_x + 80*self.scale, last_node_y - 40*self.scale,
                text=f"FEED-PIPE\nL_total={feed_length}m\nKt={feed_kt}",
                font=("Arial", int(12*self.scale), "bold"),
                fill="darkred", anchor="w", tags="labels"
            )
        
        self.canvas.tag_raise("labels")
        self.canvas.lower("feed_pipe")
        self.canvas.lower("pipes")
        self.canvas.configure(scrollregion=self.canvas.bbox("all"))


    def get_feed_pipe_data(self, last_branch_num):
        """🔍 ИЗВЛЕЧЕНИЕ FEED-PIPE ИЗ JSON 'feedPipe'"""
        if "feedPipe" in self.data:
            feed_pipe = self.data["feedPipe"]
            return {
                "length": feed_pipe.get("length", 62),
                "kt": feed_pipe.get("kt", "36920.0000")
            }
        
        return {"length": 62, "kt": "36920.0000"}


    def get_connection_length(self, branch_num):
        """🔍 ИЗВЛЕЧЕНИЕ ДЛИНЫ СОЕДИНЕНИЯ ИЗ ПОСЛЕДНЕЙ СТРОКИ ВЕТКИ"""
        branch_data = self.branches[branch_num]
        rows = branch_data["rows"]
        
        # 🔍 Ищем последнюю строку с length (Узел или Участок)
        for row in reversed(rows):  # Идем с конца
            length = row.get("length", "-")
            if length != "-" and length != "":
                return length  # ✅ Возвращаем length узла/последнего участка
        
        return "1.0"  # Дефолт если не найдено
    
    def draw_branch(self, branch_num, start_x, y_start, px_per_m):
        branch_data = self.branches[branch_num]
        rows = branch_data["rows"]
        
        x = start_x
        pipe_y = y_start + 30 * self.scale
        
        # P1 лейбл
        p1_text = "Pa1" if branch_num == "а" else ""
         
        
        FIXED_SEGMENT_LENGTH = 100 * self.scale
        
        for row_idx, row in enumerate(rows):
            print(f"🔍 ROW[{row_idx}]: name='{row.get('name')}', length={row.get('length')}")
            
            if row.get("is_sprinkler", False):
                # 💧 ОРОСИТЕЛЬ (НЕ сдвигает x)
                r = 8 * self.scale
                self.canvas.create_oval(x-r, pipe_y-r, x+r, pipe_y+r, fill="black")
                self.canvas.create_line(x, pipe_y+r, x, pipe_y+25*self.scale, 
                                    width=3*self.scale, fill="black", arrow=tk.LAST)
                print(f"  → Ороситель на x={x}")
                
            elif "Узел" in str(row.get("name", "")):
                # 🟠 УЗЕЛ (НЕ сдвигает x - рисуется НА участке!)
                r = 14 * self.scale
                self.canvas.create_oval(x-r, pipe_y-r, x+r, pipe_y+r, 
                                    fill="orange", outline="black", width=2*self.scale)
                
                node_name = row.get("name", f"Узел{row_idx}")
                print(f"🎯 УЗЕЛ: '{node_name}' на x={x}")
                
                self.canvas.create_text(x+45*self.scale, pipe_y-15*self.scale, 
                                    text=node_name,
                                    font=("Arial", int(10*self.scale), "bold"), 
                                    fill="darkblue", anchor="w",
                                    width=160*self.scale)
                # ❌ НЕТ x = next_x ! Узел НЕ сдвигает позицию!
                
            else:
                # 📏 УЧАСТОК (Только участки сдвигают x!)
                length = row.get("length", "0")
                if length != "-" and length != "":
                    next_x = x + FIXED_SEGMENT_LENGTH
                    self.canvas.create_line(x, pipe_y, next_x, pipe_y, 
                                        width=6*self.scale, fill="black", capstyle=tk.ROUND)
                    self.canvas.create_text((x+next_x)/2, pipe_y+25*self.scale, 
                                        text=f"L={length}m", 
                                        font=("Arial", int(10*self.scale), "bold"), anchor="center")
                    x = next_x  # ✅ ТОЛЬКО участки сдвигают x!
                    print(f"  → Участок L={length}, x={x}")
        
        # 🟤 КОНЕЦ ВЕТКИ (всегда черный круг)
        end_x, end_y = x, pipe_y
        r = 12 * self.scale
        self.canvas.create_oval(end_x-r, end_y-r, end_x+r, end_y+r, fill="black")
        
        # Название конца ветки
        end_node_name = f"Узел {branch_num}"
        self.canvas.create_text(end_x+45*self.scale, end_y-15*self.scale, 
                            text=end_node_name,
                            font=("Arial", int(10*self.scale), "bold"), 
                            fill="darkred", anchor="w", width=160*self.scale)
        
        self.branch_end_positions[branch_num] = (end_x, end_y)
        print(f"✅ Ветка {branch_num} конец на x={end_x}")
        
        
# if __name__ == "__main__":
#     app = JsonBranchesViewer()
#     t = app.run()
#     print(t)