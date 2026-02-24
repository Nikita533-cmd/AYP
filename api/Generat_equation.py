import json
from typing import Dict, List, Tuple
from dataclasses import dataclass
import numpy as np
from scipy.optimize import fsolve

@dataclass
class Branch:
    p1_fixed: float
    k_factor: float
    segments: List[Dict[str, float]]
    sprinklers: int
    rows: List[Dict]

@dataclass
class Connection:
    L: float
    Kt: float
    from_branch: str
    to_branch: str

class HydraulicParser:
    def __init__(self, data=None):
        self.data = data
        self.branches: Dict[str, Branch] = {}
        self.connections: Dict[str, Connection] = {}
        self.feed_pipe: Dict[str, float] = {}
        self._parse_branches()
        self._build_connections()
        self.var_count = 0
    
    def load(self, json_file: str) -> 'HydraulicParser':
        """Загрузка JSON (цепной вызов)"""
        try:
            with open(json_file, 'r', encoding='utf-8') as f:
                self.data = json.load(f)
            self._parse_branches()
            self._build_connections()
            print(f"Загружен {json_file}: {len(self.branches)} веток")
            print(f"Связи: {len(self.connections)} + feed_pipe")
            return self
        except Exception as e:
            print(f"Ошибка: {e}")
            return self
    
    def generate(self) -> List[str]:
        """ГЕНЕРИРУЕТ ВСЕ УРАВНЕНИЯ"""
        if not self.branches:
            print("Нет веток!")
            return []
        
        print("ГЕНЕРИРУЕМ УРАВНЕНИЯ")
        equations = []
        branch_list = sorted(self.branches.keys())
        
        # 1. ПАРАМЕТРЫ СОЕДИНЕНИЙ
        equations.extend(self._connection_params())
        print(f"Параметры соединений: OK")
        
        # 2. КОНСТАНТЫ ВЕТОК
        self.var_count = self._add_branch_constants(equations, branch_list)
        print(f"Переменных: {self.var_count}")
        
        # 3. ФУНКЦИЯ + УРАВНЕНИЯ ВЕТОК  
        equations.extend([
            "", f"self.var_count = {self.var_count}", "",
            "def hydraulic_network_equations(X):",
            "    F = np.zeros(self.var_count)",
            "    import math", ""
        ])
        
        # 4. ВСЕ УРАВНЕНИЯ ВЕТОК 
        eq_idx = self._branch_equations(equations, branch_list, 0)
        print(f"Уравнения веток: F[0:{eq_idx}]")
        
        # 5. УРАВНЕНИЯ СВЯЗЕЙ 
        eq_idx = self._connection_equations(equations, branch_list, eq_idx)
        print(f"Уравнения связей: F[{eq_idx-len(self.connections)*2}:{eq_idx}]")
        
        equations.append("    return F")
        print(f"ГОТОВО! {len(equations)} строк кода")
        self.equations = equations
        return equations

    # ==================== ПАРСИНГ ====================
    def _parse_branches(self):
        sprinkler_data = self.data.get("sprinkler", {})
        k_factor = float(sprinkler_data.get("k_factor", 0.0239))
        
        for key, branch_data in self.data.get("branchDetails", {}).items():
            branch_num = branch_data.get("branch_num", "")
            if not branch_num: continue
            
            p1_fixed = branch_data.get("p1_fixed", 18.50) if branch_num == "а" else 18.50
            self._fix_names(branch_data["rows"])
            segments, sprinklers = self._count_segments(branch_data)
            
            self.branches[branch_num] = Branch(
                p1_fixed=p1_fixed, k_factor=k_factor,
                segments=segments, sprinklers=sprinklers,
                rows=branch_data["rows"]
            )

    def _fix_names(self, rows):
        for row in rows:
            raw_name = row.get("name", "")
            if isinstance(raw_name, str) and ('"name":' in raw_name or raw_name.startswith('"name"')):
                clean_name = raw_name.split('"name": "')[1].rstrip('"') if '"name": "' in raw_name else raw_name[1:-1]
                row["name"] = clean_name

    def _count_segments(self, branch_data) -> Tuple[List, int]:
        segments, sprinklers = [], 0
        for row in branch_data["rows"]:
            if row.get("is_sprinkler", False):
                sprinklers += 1
            elif "Участок" in str(row.get("name", "")) and row.get("length", "-") != "-":
                segments.append({
                    "length": float(row["length"]),
                    "kt": float(branch_data.get("kt", 110.0))
                })
        return segments, sprinklers

    # ==================== СВЯЗИ ====================
    def _build_connections(self):
        branch_list = sorted(self.branches.keys())
        for i in range(1, len(branch_list)):
            prev, curr = branch_list[i-1], branch_list[i]
            last_row = self.branches[curr].rows[-1]
            L = float(last_row.get("length", 1.0))
            Kt = float(self.branches[curr].segments[0]["kt"] if self.branches[curr].segments else 110.0)
            
            self.connections[f"{prev}-{curr}"] = Connection(L, Kt, prev, curr)
        
        feed = self.data.get("feedPipe", {})
        self.feed_pipe = {"L": float(feed.get("length", 62)), "Kt": float(feed.get("kt", 36920))}

    # ==================== ГЕНЕРАЦИЯ ====================
    def _connection_params(self) -> List[str]:
        eqs = ["#" + "="*80, "# СОЕДИНЕНИЯ (Lаб, Ktаб...)", "#"]
        for conn in self.connections.values():
            eqs.extend([
                f"# 🔗 {conn.from_branch}-{conn.to_branch}: L={conn.L}m, Kt={conn.Kt}",
                f"L{conn.from_branch}{conn.to_branch} = {conn.L}",
                f"Kt{conn.from_branch}{conn.to_branch} = {conn.Kt}", ""
            ])
        eqs.extend([
            f"# 📡 FEED PIPE: L={self.feed_pipe['L']}m, Kt={self.feed_pipe['Kt']}",
            f"L_feed_pipe = {self.feed_pipe['L']}",
            f"Kt_feed_pipe = {self.feed_pipe['Kt']}", ""
        ])
        return eqs

    def _add_branch_constants(self, equations: List[str], branch_list: List[str]) -> int:
        self.var_count = 0
        for branch_num in branch_list:
            branch = self.branches[branch_num]
            l_segments = [f"{s['length']:.1f}" for s in branch.segments]
            kt_segments = [f"{s['kt']:.0f}" for s in branch.segments]

            equations.extend([
                f"# Ветка {branch_num}: {branch.sprinklers} спринкл., {len(branch.segments)} сегм., K={branch.k_factor}",
                f"L_SEGMENTS_{branch_num.upper()} = [{', '.join(l_segments)}]",
                f"Kt_{branch_num.upper()} = [{', '.join(kt_segments)}]"
            ])
            if branch_num == "а":
                equations.append(f"P1_A_FIXED = {branch.p1_fixed}")
            self.var_count += branch.sprinklers * 2 + len(branch.segments)  
            if branch_num == "а": self.var_count += 1  
        return self.var_count

    def _branch_equations(self, equations: List[str], branch_list: List[str], eq_idx: int) -> int:
        """ПОЛНЫЕ уравнения веток (как БЫЛО)"""
        for branch_num in branch_list:
            branch = self.branches[branch_num]
            equations.append(f"    # ВЕТКА {branch_num.upper()} (K={branch.k_factor})")
            
            n_spr = branch.sprinklers
            n_seg = len(branch.segments)
            
            # Оросители: Q = K√P
            for i in range(n_spr):
                equations.append(f"    F[{eq_idx}] = Q{branch_num}{i+1} - {branch.k_factor} * math.sqrt(max(0.01, P{branch_num}{i+1}))")
                eq_idx += 1
            
            # Баланс расходов по оросителям 
            for i in range(n_spr):
                if i == 0:
                    equations.append(f"    F[{eq_idx}] = Q{branch_num}12 - Q{branch_num}1")
                else:
                    prev_seg = f"Q{branch_num}{i}{i+1}"
                    next_seg = f"Q{branch_num}{i+1}{i+2}"
                    equations.append(f"    F[{eq_idx}] = Q{branch_num}{i+1} - ({next_seg} - {prev_seg})")
                eq_idx += 1
            
            # Напоры по трубам: ΔP = Q²×L/Kt
            for i in range(n_seg):
                p_curr = f"P{branch_num}{i+2}"
                p_prev = f"P{branch_num}{i+1}"
                q_seg = f"Q{branch_num}{i+1}{i+2}"
                equations.append(f"    F[{eq_idx}] = {p_curr} - ({p_prev} - ({q_seg}**2 * L_SEGMENTS_{branch_num.upper()}[{i}]) / Kt_{branch_num.upper()}[{i}])")
                eq_idx += 1
            
            # Фиксированное давление для ветки "а"
            if branch_num == "а":
                equations.append(f"    F[{eq_idx}] = Pa1 - P1_A_FIXED")
                eq_idx += 1
        
        return eq_idx

    def _connection_equations(self, equations: List[str], branch_list: List[str], eq_idx: int) -> int:
        """ПОЛНЫЕ УРАВНЕНИЯ СВЯЗЕЙ"""
        equations.append("")
        equations.append("    # УРАВНЕНИЯ СВЯЗИ")
        
        # 1️⃣ Поток последнего участка = поток в соединение
        for i, branch_num in enumerate(branch_list):
            n_sprinklers = self.branches[branch_num].sprinklers
            last_Q = f"Q{branch_num}{n_sprinklers}{n_sprinklers+1}"
            
            if i < len(branch_list) - 1:
                next_branch = branch_list[i+1]
                equations.append(f"    F[{eq_idx}] = {last_Q} - Q{branch_num}{next_branch}")
            else:
                equations.append(f"    F[{eq_idx}] = {last_Q} - Qfeed_pipe12")
            eq_idx += 1
        
        # 2️⃣ Давление последнего узла = давление узла ветки
        for branch_num in branch_list:
            n_sprinklers = self.branches[branch_num].sprinklers
            last_P = f"P{branch_num}{n_sprinklers}"
            equations.append(f"    F[{eq_idx}] = {last_P} - P{branch_num}")
            eq_idx += 1
        
        # 3️⃣ Балансы расходов на узлах
        for i in range(1, len(branch_list)):
            curr_branch = branch_list[i]
            prev_branch = branch_list[i-1]
            
            own_flow = f"Q{curr_branch}45"  # Пример для 4 спринклеров
            incoming_conn = f"Q{prev_branch}{curr_branch}"
            
            if i < len(branch_list) - 1:
                next_branch = branch_list[i+1]
                outgoing_flow = f"Q{curr_branch}{next_branch}"
            else:
                outgoing_flow = "Qfeed_pipe12"
            
            equations.append(f"    F[{eq_idx}] = {own_flow} + {incoming_conn} - {outgoing_flow}")
            eq_idx += 1
        
        # 4️⃣ Потери напора на соединениях ΔP = Q²×L/Kt
        for i in range(1, len(branch_list)):
            prev_branch = branch_list[i-1]
            curr_branch = branch_list[i]
            
            Q_conn = f"Q{prev_branch}{curr_branch}"
            deltaP = f"deltaP{prev_branch}{curr_branch}"
            L_name = f"L{prev_branch}{curr_branch}"
            Kt_name = f"Kt{prev_branch}{curr_branch}"
            
            equations.append(f"    F[{eq_idx}] = {deltaP} - ({Q_conn}**2 * {L_name}/{Kt_name})")
            eq_idx += 1
            equations.append(f"    F[{eq_idx}] = P{curr_branch} - (P{prev_branch} + {deltaP})")
            eq_idx += 1
        
        # 5️⃣ Feed Pipe
        last_branch = branch_list[-1]
        equations.extend([
            f"    F[{eq_idx}] = P1feed_pipe - P{last_branch}",
            f"    F[{eq_idx+1}] = P2feed_pipe - (P{last_branch} + Qfeed_pipe12**2*L_feed_pipe/Kt_feed_pipe)"
        ])
        
        return eq_idx + 2
    def run_fsolve(self):
        """⚡ РЕШАЕМ"""
        self.generate()
        x0 = np.ones(self.var_count) * 0.01
        for i in range(self.var_count):
            x0[i] = 5.0
        
        solution = fsolve(self.equations, x0, full_output=True)
        # X = solution[0]
        # F_final = self.equations_func(X)
        return solution
        # self.solution = {
        #     'X': dict(zip(self.var_names, X)),
        #     'F': F_final,
        #     'max_residual': float(np.max(np.abs(F_final))),
        #     'iterations': solution[1].get('nfev', 0)
        # }
if __name__ == "__main__":
    import sys
    if len(sys.argv) > 1:
        parser = HydraulicParser().load(sys.argv[1]).generate()
        print("\n" + "="*100)
        print("ВЫВОД В ТЕРМИНАЛ:")
        print("="*100)
        print("\n".join(parser))
        
        out_file = sys.argv[1].replace('.json', '_equations.py')
        with open(out_file, 'w', encoding='utf-8') as f:
            f.write('\n'.join(parser))
        print(f"\nСохранено: {out_file}")
