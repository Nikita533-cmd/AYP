
from sre_constants import RANGE
from wsgiref import validate
import mysql.connector
import numpy as np
from collections import OrderedDict
import math
DICT_Z = {} 
DICT_V = {}
DICT_Nasos = {} 
DICT_price ={}
DICT_f01 ={}
DICT_f11 ={}
DICT_Global = {}
DICT_MPNY= {}
DICT_Scveller= {}
Price_pump= {}
currency = {}
mass_pump= {}
pump_gabarit= {}
shvel={}
class ELEMENT:
    def __init__(self, A, B, mass, DN, Price, Name, Armatura, Metr, LLL,K):
        self.A = A
        self.B = B
        self.mass = mass
        self.DN = DN
        self.Price = Price
        self.Name = Name
        self.Armatura = Armatura
        self.Metr = Metr
        self.K = K
        self.LLL = LLL
class truba10704(ELEMENT):
    def __init__(self, r):
        self.D1=r["D1"]
        self.S=r["S"]
        self.D=r["D"]
        self.isp=r["isp"]
        
        # Преобразуем данные из словаря в параметры
        super().__init__(
            A=None,
            B=None,
            K=None,
            mass=r["massa"],
            DN=r["DN"],
            Price=0,
            Name=r["name"],
            Armatura=False,    # Фиксированное значение
            Metr=True,       # Фиксированное значение
            LLL=0         # Фиксированное значение
        )
class truba10704_L(ELEMENT):
    def __init__(self, tr,L):
        self.D1=tr.D1
        self.S=tr.S
        self.D=tr.D
        self.isp=tr.isp
        self.L=L
        
        # Преобразуем данные из словаря в параметры
        super().__init__(
            A=None,
            B=None,
            K=None,
            mass=tr.mass,
            DN=tr.DN,
            Price=0,
            Name=tr.Name,
            Armatura=False,    # Фиксированное значение
            Metr=True,       # Фиксированное значение
            LLL=L         # Фиксированное значение
        )
class Schveller(ELEMENT):
    def __init__(self, r):
        self.h=r["h"]
        self.s=r["s"]
        self.b=r["b"]
        self.nameP=r["nameP"]
        
        # Преобразуем данные из словаря в параметры
        super().__init__(
            A=None,
            B=None,
            K=None,
            mass=r["massa"],
            DN=None,
            Price=0,
            Name=r["name"],
            Armatura=False,    # Фиксированное значение
            Metr=True,       # Фиксированное значение
            LLL=0         # Фиксированное значение
        )
class Schveller_L(ELEMENT):
    def __init__(self, tr,L):
        self.h=tr.h
        self.s=tr.s
        self.b=tr.b
        self.nameP=tr.nameP
        # Преобразуем данные из словаря в параметры
        super().__init__(
            A=None,
            B=None,
            K=None,
            mass=tr.mass,
            DN=tr.DN,
            Price=0,
            Name=tr.Name,
            Armatura=False,    # Фиксированное значение
            Metr=True,       # Фиксированное значение
            LLL=L         # Фиксированное значение
        )
class Otvod(ELEMENT):
    def __init__(self, r):
        self.D1=r["D1"]
        self.isp=r["isp"]
        self.R_F=r["R_F"]
        self.T=r["T"]
        # Преобразуем данные из словаря в параметры
        super().__init__(
            A=r["A"],
            B=r["B"],
            K=None,
            mass=r["Mass"],
            DN=r["DN"],
            Price=0,
            Name=r["Name"],
            Armatura=True,    # Фиксированное значение
            Metr=False,       # Фиксированное значение
            LLL=0         # Фиксированное значение
        ) 
class Tee(ELEMENT):
    def __init__(self, r):
        self.D1=r["D1"]
        self.isp=r["isp"]
        self.f=r["f"]
        self.h=r["h"]
        self.PN=r["PN"]
        
        # Преобразуем данные из словаря в параметры
        super().__init__(
            A=r["A"],
            B=r["B"],
            K=None,
            mass=r["Mass"],
            DN=r["DN"],
            Price=0,
            Name=r["Name"],
            Armatura=True,    # Фиксированное значение
            Metr=False,       # Фиксированное значение
            LLL=0         # Фиксированное значение
        )     
class NASOS(ELEMENT):

    def __init__(self,r):
        self.h1=0
        self.h=0
        self.a=0
        self.F=0
        self.Wide=0
        self.Schvel_Numb=""
        self.L_ram=0
        self.L3=0
        self.Ws=0
        self.AB_NMM=0
        self.n1_NMM=0
        self.h1_dvig=0
        self.B=0
        self.m1=0
        self.B_otv=0
        self.m_H=0
        self.He=0
        self.Name=r["model"]
        self.Power=r["Power"] 
        self.Price=r["Price"] 
        self.DN_in=r["DN_in"]
        self.DN_out=r["DN_out"]
        self.D_in_pump=r["DN_in"]
        self.D_out_pump=r["DN_out"]
        self.MARKA = ""
        self.Producer = ""
        self.MARKA_TFlex = ""
        self.H = [0]*10
        self.Q = [0]*10
        self.NPSH = [0]*10
        self.img="static/app/img/MHC3_1_0_1_1_4.png"
        self.img2="app/img/Hydroo3_1_1_1_1_4.png" 
        if "MHC" in self.Name:
            
            self.img="static/app/img/MHC3_1_0_1_1_4.png"
        elif "NMM" in self.Name:
            
            self.img="static/app/img/NMM2_1_0_1_1_4.png"
        elif "NM " in self.Name:
           
            self.img="static/app/img/NM2_1_1_1_1_4.png"
        else:
           
            self.img="static/app/img/Hydroo3_1_1_1_1_4.png"
        self.img2=""
        if "MHC" in self.Name:
           
            self.img2="app/img/MHC3_1_0_1_1_4.png"
        elif "NMM" in self.Name:
           
            self.img2="app/img/NMM2_1_0_1_1_4.png"
        elif "NM " in self.Name:
            
            self.img2="app/img/NM2_1_1_1_1_4.png"
        else:
           
            self.img2="app/img/Hydroo3_1_1_1_1_4.png"  
        for i in range(10):
            self.H[i]=r["P"+str(i+1)]
            self.Q[i]=r["Q"+str(i+1)]
            self.NPSH[i]=r["NPSH"+str(i+1)]
        super().__init__(
            A=0,
            K=0,
            B=0,
            mass=0,
            DN=None,
            Price=r["Price"],
            Name=r["model"],
            Armatura=False,    # Фиксированное значение
            Metr=False,       # Фиксированное значение
            LLL=0        # Фиксированное значение
        )
    def gabarit(self,t):
                self.h1 = float(t["h1"])
                self.h = float(t["h"])
                self.a = float(t["a"])           
                self.F = float(t["F"])
                self.Wide = float(t["Wide"])
                self.Schvel_Numb = t["Schvel_Numb"]
                self.L_ram = float(t["L_ram"])
                self.L3 = float(t["L3"])
                self.Ws = float(t["Ws"])
                self.AB_NMM = float(t["AB_NMM"])
                self.n1_NMM= float(t["n1_NMM"])
                self.h1_dvig = float(t["h1_dvig"])
                self.B= float(t["B"])
                self.m1 = float(t["m1"])
                self.B_otv = float(t["B_otv"])
                self.m_H = float(t["m_H"])
                self.He=float(t["He"])   
    def Get(self,Q):

        x = np.array(self.Q)
        y = np.array(self.H)

        # Построение матрицы Вандермонда
        X = np.vander(x, 6)  # 6 колонок для степени 5

        # Решение методом МНК
        c = np.linalg.lstsq(X, y, rcond=None)[0]
        return c[5]+c[4]*Q+c[3]*Q**2+c[2]*Q**3+c[1]*Q**4+c[0]*Q**5

            
    def Get_NPSH(self,Q):

        x = np.array(self.Q)
        y = np.array(self.NPSH)

        # Построение матрицы Вандермонда
        X = np.vander(x, 6)  # 6 колонок для степени 5

        # Решение методом МНК
        c = np.linalg.lstsq(X, y, rcond=None)[0]
        return c[5]+c[4]*Q+c[3]*Q**2+c[2]*Q**3+c[1]*Q**4+c[0]*Q**5
    def producer_t(self, name: str):
        if "NMM" in name:
            self.MARKA = "NMM"
            self.Producer = "Masdaf"
            self.MARKA_TFlex = "NMM"
        elif "NM" in name and "NMM" not in name:
            self.MARKA = "NM"
            self.Producer = "Masdaf"
            self.MARKA_TFlex = "NM"
        elif "NKW" in name:
            self.MARKA = "NKW"
            self.Producer = "Wellmix"
            self.MARKA_TFlex = "NM"
        elif "NBS" in name:
            self.MARKA = "NBS"
            self.Producer = "Wellmix"
            self.MARKA_TFlex = "MHC"
        elif "CV " in name:
            self.MARKA = "CV"
            self.Producer = "Wellmix"
            self.MARKA_TFlex = "Hydroo"
        elif "CVA" in name:
            self.MARKA = "CVA"
            self.Producer = "aquapolis"
            self.MARKA_TFlex = "Hydroo"
        elif "KM" in name:
            self.MARKA = "KM"
            self.Producer = "ООО «Элком»"
            self.MARKA_TFlex = "NMM"
        elif "K" in name:
            self.MARKA = "K"
            self.Producer = "ООО «Элком»"
            self.MARKA_TFlex = "NM"
        elif "GSM" in name:
            self.MARKA = "GSM"
            self.Producer = "GRANDFAR"
            self.MARKA_TFlex = "NM"
        elif "GSA" in name:
            self.MARKA = "GSA"
            self.Producer = "GRANDFAR"
            self.MARKA_TFlex = "MHC"
        elif "FSM" in name:
            self.MARKA = "FSM"
            self.Producer = "FANCY"
            self.MARKA_TFlex = "NM"
        elif "VF" in name:
            self.MARKA = "VF"
            self.Producer = "Hydroo"
            self.MARKA_TFlex = "Hydroo"
        elif "LBS" in name:
            self.MARKA = "LBS"
            self.Producer = "Lubi"
            self.MARKA_TFlex = "NM"
        elif "LES" in name:
            self.MARKA = "LES"
            self.Producer = "Lubi"
            self.MARKA_TFlex = "MHC"
        elif "FZ" in name:
            self.MARKA = "FZ"
            self.Producer = "Fancy"
            self.MARKA_TFlex = "MHC"
        elif "HMV" in name:
            self.MARKA = "HMV"
            self.Producer = "Heisskraft"
            self.MARKA_TFlex = "Hydroo"
        elif "LCR" in name:
            self.MARKA = "LCR"
            self.Producer = "Lubi"
            self.MARKA_TFlex = "Hydroo"
        elif "Hexa" in name:
            self.MARKA = "Hexa"
            self.Producer = "Masdaf"
            self.MARKA_TFlex = "Hydroo"
        elif "CR" in name and "LCR" not in name:
            self.MARKA = "CR"
            self.Producer = "ООО «Элком»"
            self.MARKA_TFlex = "Hydroo"
        elif "CDM" in name:
            self.MARKA = "CDM"
            self.Producer = "CNP"
            self.MARKA_TFlex = "Hydroo"
        elif "MHC" in name:
            self.MARKA = "MHC"
            self.Producer = "Центральный офис ООО «Торговый Дом АДЛ»"
            self.MARKA_TFlex = "MHC"
        else:
            self.MARKA = "Неопределена"
            self.Producer = "Неопределена"
            self.MARKA_TFlex = "Неопределена"

    def cva_name(self, name: str) -> str:
        if "CVA " in name:
            name = name.replace("CVA ", "CVA")
            name = name.replace(" ", "")
        return name

    def lcr_name(self, name: str) -> str:
        if "LCR" in name:
            t = name.split(' ')
            if len(t) >= 2:
                name = t[0] + " " + t[1] + " "
        elif "CR" in name:
            name = name + " "
        return name
class butterfly_valve(ELEMENT):
    def __init__(self, r):
        # Преобразуем данные из словаря в параметры
        super().__init__(
            A=r["A"],
            B=r["B"],
            K=r["K"],
            mass=r["mass"],
            DN=r["DN"],
            Price=r["Price"],
            Name=r["Name"],
            Armatura=True,    # Фиксированное значение
            Metr=False,       # Фиксированное значение
            LLL=0         # Фиксированное значение
        )
def power(power):
    isk_power=0
    list_power=[4, 5.5, 7.5, 11, 15, 18.5, 22, 30, 37, 45, 55, 75, 90, 110, 132, 160, 200, 250]
    for p in list_power:
        if(p-power>=0):
            isk_power=p
            break
    return isk_power


class SHYN(ELEMENT):
    
    def __init__(self, r):
        self.Power=r["power"] 
        self.Pysk=r["pysk"] 
        self.Jok=r["jok"] 
        self.Nasos=r["nasos"] 
        self.korpus=r["korpus"] 
        # self.Price_=0
        # if(r["price"]=='0'):
        #     self.Price_=0
        # else:
        #     self.Price_=r["price"]


        self.STROCA=f"SHYN_{self.Nasos}_{self.Power}_{self.Pysk}_{self.Jok}"
        # Преобразуем данные из словаря в параметры
        super().__init__(
            A=None,
            B=None,
            K=None,
            mass=None,
            DN=None,
            Price=float(r["price"].replace(" ","")),
            Name=r["model"],
            Armatura=False,    # Фиксированное значение
            Metr=False,       # Фиксированное значение
            LLL=0         # Фиксированное значение
        )
class SHYK(ELEMENT):
    
    def __init__(self, r):
        self.yma=r["yma"],
        # Преобразуем данные из словаря в параметры
        super().__init__(
            A=None,
            B=None,
            K=None,
            mass=None,
            DN=None,
            Price=r["prise"],
            Name=r["model"],
            Armatura=False,    # Фиксированное значение
            Metr=False,       # Фиксированное значение
            LLL=0           # Фиксированное значение
        )
class check_valve(ELEMENT):
    def __init__(self, r):
        # Преобразуем данные из словаря в параметры
        super().__init__(
            A=r["A"],
            B=r["B"],
            K=r["K"],
            mass=r["mass"],
            DN=r["DN"],
            Price=r["Price"],
            Name=r["Name"],
            Armatura=True,    # Фиксированное значение
            Metr=False,       # Фиксированное значение
            LLL=0         # Фиксированное значение
        ) 
class Eks_perexod(ELEMENT):
    def __init__(self, r):
        self.D_in=r["D_Max"]
        self.D_out=r["D_Min"]
        self.isp=r["isp"]
        self.Perepad =self.D_in / 2 - self.D_out / 2
        self.t_big=r["T_Max"]
        self.t_small=r["T_Min"]
        self.DN_out=r["DN2"]
        self.L=r["LL"]

        
        # Преобразуем данные из словаря в параметры
        super().__init__(
            A=None,
            B=None,
            K=r["K"],
            mass=r["massa"],
            DN=r["DN1"],
            Price=0,
            Name=r["Name"],
            Armatura=True,    # Фиксированное значение
            Metr=False,       # Фиксированное значение
            LLL=0         # Фиксированное значение
        ) 
class Konc_perexod(ELEMENT):
    def __init__(self, r):
        self.D_in=r["D_Max"]
        self.D_out=r["D_Min"]
        self.isp=r["isp"]
        self.Perepad =self.D_in / 2 - self.D_out / 2
        self.t_big=r["T_Max"]
        self.t_small=r["T_Min"]
        self.DN_out=r["DN2"]
        self.L=r["LL"]
        fi=0
        Xmin = 0
        Xmax = 0
        Ymin = 0
        Ymax = 0
        n1 = pow(self.D_in / 1000, 2) / pow(self.D_out / 1000, 2)
        f1f0 = self.L / self.D_out;
        X = [ 0, 0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4 ]
        Y1 =[ 1.02, 0.75, 0.62, 0.53, 0.47, 0.43, 0.4, 0.38, 0.37]
        i = 0
        
        for x in X:
                if x == f1f0:
                   ED = Y1[i] 
                   break
                if (x < f1f0):
                    Xmin = x
                    Ymin = Y1[i]
                if (x > f1f0):
                   Xmax = x
                   Ymax = Y1[i]
                   break
                i = i + 1;
        k = (Ymin - Ymax) / (Xmin - Xmax);
        b = Ymin - k * Xmin;
        if (fi == 0):
               fi = k * f1f0 + b
        ED = fi * (1.43 - 1.3 / n1) * pow((1 - 1 / n1), 2);
        
        # Преобразуем данные из словаря в параметры
        super().__init__(
            A=None,
            B=None,
            mass=r["massa"],
            DN=r["DN1"],
            Price=0,
            Name=r["Name"],
            Armatura=True,    # Фиксированное значение
            Metr=False,       # Фиксированное значение
            LLL=0,        # Фиксированное значение
            K=ED
        ) 
class flanc01(ELEMENT):
    def __init__(self, r):
        # Преобразуем данные из словаря в параметры
        self.PN=r["PN"]
        self.Ryad=r["Ryad"]
        super().__init__(
            A=r["A"],
            B=r["B"],
            K=None,
            mass=r["massa"],
            DN=r["DN"],
            Price=0,
            Name=r["name"],
            Armatura=True,    # Фиксированное значение
            Metr=False,       # Фиксированное значение
            LLL=0         # Фиксированное значение
        ) 
class flanc11(ELEMENT):
    def __init__(self, r):
        # Преобразуем данные из словаря в параметры
        self.PN=r["PN"]
        self.Ryad=r["Ryad"]
        super().__init__(
            A=r["A"],
            B=r["B"],
            K=None,
            mass=r["massa"],
            DN=r["DN"],
            Price=0,
            Name=r["name"],
            Armatura=True,    # Фиксированное значение
            Metr=False,       # Фиксированное значение
            LLL=0         # Фиксированное значение
        ) 
class ugolok(ELEMENT):
    def __init__(self, r):
        self.T=r["T"]
        # Преобразуем данные из словаря в параметры
        super().__init__(
            A=r["A"],
            B=r["B"],
            K=None,
            mass=r["massa"],
            DN=None,
            Price=0,
            Name=r["name"],
            Armatura=False,    # Фиксированное значение
            Metr=True,       # Фиксированное значение
            LLL=0         # Фиксированное значение
        )
class ugolok_L(ELEMENT):
    def __init__(self, ug,L):
        self.T=ug.T
        # Преобразуем данные из словаря в параметры
        super().__init__(
            A=ug.A,
            B=ug.B,
            K=None,
            mass=ug.mass,
            DN=None,
            Price=0,
            Name=ug.Name,
            Armatura=False,    # Фиксированное значение
            Metr=True,       # Фиксированное значение
            LLL=L        # Фиксированное значение
        )
def IMPORT():
             
            conn = mysql.connector.connect(
            host="itsabijt.beget.tech",
            user="itsabijt_station",
            password="48625Aa",
            database="itsabijt_station"
            # conn = mysql.connector.connect(
            # host="192.168.0.148",
            # user="admin",
            # password="admin",
            # database="mpny"
        )
            cursor = conn.cursor(dictionary=True)
            # #Импорт ШУН
            cursor.execute(f"SELECT * FROM shyn")
            for r in cursor:
                 shyn=SHYN(r)
                 DICT_Global[shyn.STROCA]=shyn
           
            # #Импорт ШУК
            cursor.execute(f"SELECT * FROM shyk")
            for r in cursor:
                 DICT_Global[r["model"]]=SHYK(r)

            # #Импорт масс насосов
            cursor.execute(f"SELECT * FROM mass_pump")
            for r in cursor:
                     # DICT_Global[f"mass_{r["model"]}"]=r["mass"]
                mass_pump[r["model"]]=r["mass"]

            # #Импорт габаритов насосов
            cursor.execute(f"SELECT * FROM nasos_gabarit")
            for r in cursor:
                     # DICT_Global[f"mass_{r["model"]}"]=r["mass"]
                pump_gabarit[r["model"]]=r
            #currency
            cursor.execute(f"SELECT * FROM currency")
            
            for r in cursor:
                 
                 
                 if r["Название валюты"]=="USD":
                     currency["usd"]=r["Курс"]
                 elif r["Название валюты"]=="EUR_EP":
                     currency["EUR_EP"]=r["Курс"]
                    
                 elif r["Название валюты"]=="EUR":
                     currency["eur"]=r["Курс"]
                 elif r["Название валюты"]=="CNY":
                     currency["cny"]=r["Курс"]
                 else:
                     currency[r["Название валюты"]]=r["Курс"]
            currency["rub"]=1         
            #Price_pump
            cursor.execute(f"SELECT * FROM price_pump")
            for r in cursor:
                if r["Валюта"]!="" and r["Валюта"]!="No" :
                    Price_pump[r["Модель"]]=r["Цена"]*float(currency[r["Валюта"]])*r["Коэфицент"]
            #Добавляем затворы
            cursor.execute(f"SELECT * FROM butterfly_valve")
            for r in cursor:
                 z=butterfly_valve(r) 
                 DICT_Global[f"zat_{z.DN}"]=z
            #Добавляем обратные клапана
            cursor.execute(f"SELECT * FROM check_valve")
            for r in cursor:
                  chec=check_valve(r)  
                  DICT_Global[f"check_{chec.DN}"]=chec
                  
            #Добавляем плоские фланцы              
            cursor.execute(f"SELECT * FROM flanc01")
            for r in cursor:
                 f01=flanc01(r)
                 DICT_Global[f"f01_{f01.DN}_{f01.Ryad}"]=f01
            #Добавляем воротниковые фланцы на напорном коллекторе !!!!!!!!!!!!!!!!!!!!!
            cursor.execute(f"SELECT * FROM flanc11")
            for r in cursor:
                 f11=flanc11(r)
                 DICT_Global[f"f11_{f11.DN}_{f11.Ryad}"]=f11
                 
            #Добавляем тройники
            cursor.execute(f"SELECT * FROM tee")
            for r in cursor:
                 tee=Tee(r)
                 DICT_Global[f"Tee_{tee.DN}_{tee.isp}"]=Tee(r)
            #Добавляем отвод
            cursor.execute(f"SELECT * FROM otvod")
            for r in cursor:
                 otvod=Otvod(r)
                 DICT_Global[f"Otvod_{otvod.DN}_{otvod.isp}"]=otvod
            #Добавляем трубы
            cursor.execute(f"SELECT * FROM truba10704")
            for r in cursor:
                 tr=truba10704(r)
                 DICT_Global[f"tr_{tr.DN}_{tr.isp}"]=tr
            #Добавляем швеллер
            cursor.execute(f"SELECT * FROM schvel")
            for r in cursor:
                 sh=Schveller(r)
                 DICT_Scveller[f"sh_{sh.nameP}"]=sh
                 shvel[f"sh_{sh.nameP}"]=sh
            #Добавляем Насос 
            cursor.execute(f"SELECT * FROM nasos")
            for r in cursor:
                pump=NASOS(r)
                
                pump.producer_t(pump.Name)
                pump.lcr_name(pump.Name)
                pump.cva_name(pump.Name)
                DICT_Nasos[pump.Name]=pump
                if pump_gabarit.get(pump.Name):
                    pump.gabarit(pump_gabarit.get(pump.Name))
                if Price_pump.get(pump.Name):
                    pump.Price=Price_pump[pump.Name]
                if mass_pump.get(pump.Name):
                    pump.mass= mass_pump[pump.Name]

            #Добавляем переход эксцентрический
            cursor.execute(f"SELECT * FROM per_ekc")
            for r in cursor:
                eks=Eks_perexod(r)
                DICT_Global[f"eks_{eks.DN}_{eks.DN_out}_{eks.isp}"]=Eks_perexod(r)
            cursor.execute(f"SELECT * FROM per_konc")
            for r in cursor:
                konc=Konc_perexod(r)
                DICT_Global[f"konc_{konc.DN}_{konc.DN_out}_{konc.isp}"]=Konc_perexod(r)
            cursor.execute(f"SELECT * FROM price_denis")
            for r in cursor:
                 DICT_Global[r["Name"]]=r["Price"]
            cursor.close()
            conn.close()

def Vel(DN,Q):
       Vel = Q / 3600 / (pow(DN / 1000, 2) / 4 * 3.14)
       return Vel
def Koeficent(DN1, DN2, nasos):
    S = 0
    Xi = 0.37
    Xi = pow(DN1, 2) / pow(DN2, 2);
    Xmin = 0;
    Xmax = 0;
    Ymin = 0;
    Ymax = 0;
    K_tr = 0;
    X = [ 0.1, 0.2, 0.3, 0.4, 0.6, 0.8, 1 ]
    Y1 = [101, 26, 11.9, 3.9875, 2.09, 1.4135, 1.1 ]
    Y2 = [ 25.5, 6.75, 3.23, 1.133, 0.66, 0.4895, 0.4235 ]
    Y = Y1
    Hp = 0
    Vel = 0
    if (nasos == 1):
       Y = Y1
    else:
       Y = Y2
    i = 0
    for x in X:
                if (x == Xi):
                    K_tr = Y[i]
                    break
                if (x < Xi):
                    Xmin = x
                    Ymin = Y[i]
                if (x > Xi):
                    Xmax = x
                    Ymax = Y[i]
                    break

                i = i + 1;

    k = (Ymin - Ymax) / (Xmin - Xmax);
    b = Ymin - k * Xmin;
    if (K_tr == 0):
       K_tr = k * Xi + b
    S = pow((DN2 / 1000), 2) / 4 * 3.14;
    return K_tr;


def h_pot(DN_in, DN_out,DN_kon, Pump,Kol_pump, Q ):
    Q=Q/Kol_pump
    EK=0
    ED=0
    k_in_tr=0
    if (Kol_pump == 1):
       k_in_tr = 2.3
    else:
       k_in_tr = 1.4
    if DN_in!=Pump.D_in_pump and (f"eks_{DN_in}_{Pump.D_in_pump}_{2}" in DICT_Global):
        EK=DICT_Global[f"eks_{DN_in}_{Pump.D_in_pump}_{2}"].K
    if DN_kon!=Pump.D_out_pump and (f"konc_{DN_kon}_{Pump.D_out_pump}_{2}" in DICT_Global):
        ED=DICT_Global[f"konc_{DN_kon}_{Pump.D_out_pump}_{2}"].K
    H_tr_in = k_in_tr * pow(Vel(DN_in, Q), 2) / (2 * 9.81)
    H_tr_out = Koeficent(DN_kon,DN_out,Kol_pump) * pow(Vel(DN_out, Q), 2) / (2 * 9.81)
    
    H_pot_k = pow(Vel(Pump.D_in_pump, Q), 2) * EK / (2 * 9.81)
    H_pot_d = pow(Vel(Pump.D_out_pump, Q), 2) * ED / (2 * 9.81)
    H_armatyra = (DICT_Global[f"zat_{DN_in}"].K+DICT_Global[f"check_{DN_kon}"].K+DICT_Global[f"zat_{DN_kon}"].K)*Q*Q*1000
    
    H_poteri=H_pot_k+H_pot_d+H_tr_in+H_tr_out+H_armatyra
    
    return H_poteri

def h_pot_in(DN_in, DN_out,D_kon, Pump,Kol_pump, Q ):
        Q=Q/Kol_pump    
        k_in_tr=0
        EK=0
        if DN_in!=Pump.D_in_pump and (f"eks_{DN_in}_{Pump.D_in_pump}_{2}" in DICT_Global):
            EK=DICT_Global[f"eks_{DN_in}_{Pump.D_in_pump}_{2}"].K
        if (Kol_pump == 1):
           k_in_tr = 2.3
        else:
            k_in_tr = 1.4  
        H_tr_in = k_in_tr * pow(Vel(DN_in, Q), 2) / (2 * 9.81)
        H_pot_k = pow(Vel(Pump.D_in_pump, Q), 2) * EK / (2 * 9.81)
        H_pot_zat=(DICT_Global[f"zat_{DN_in}"].K)*Q*Q*1000
        H_pot_in=H_tr_in+H_pot_k+H_pot_zat
        return H_pot_in
class H_pot():
    def __init__(self, DN_in, DN_out,D_kon, Pump,Kol_pump, Q ):
        self.DN_in=DN_in
        self.DN_out=DN_out
        self.D_kon=D_kon
        self.Pump=Pump
        self.Kol_pump=Kol_pump
        self.Q=Q
        self.Q_gl=[0]*10
        
        self.H_poteri=h_pot(DN_in, DN_out,D_kon, Pump,Kol_pump, Q )
        self.Poteri = [0]*10
        self.H = [0]*10
        for i in range(10):
            self.Q_gl[i]=Pump.Q[i]*Kol_pump
            self.Poteri[i]=h_pot(DN_in, DN_out,D_kon, Pump,Kol_pump, Pump.Q[i])
            self.H[i]=Pump.H[i]-self.Poteri[i]
    def Get(self,Q):
            Q=Q/self.Kol_pump
            x = np.array(self.Pump.Q)
            y = np.array(self.Poteri)

            # Построение матрицы Вандермонда
            X = np.vander(x, 6)  # 6 колонок для степени 5

            # Решение методом МНК
            c = np.linalg.lstsq(X, y, rcond=None)[0]
            return c[5]+c[4]*Q+c[3]*Q**2+c[2]*Q**3+c[1]*Q**4+c[0]*Q**5
            
  
class MPNY_new():
    def __init__(self,dict):
        self.Q=dict["Q"]
        self.H=dict["H"]
        self.NPSH=dict["NPSH"]
        self.Qgl=dict["Qgl"]
        self.Hgl=dict["Hgl"]
        self.H_f=dict["H_f"]
        self.Power_f=dict["Power_f"]
        self.Kol=dict["Kol"]
        self.DN_in=dict["DN_in"]
        self.DN_out=dict["DN_out"]
        self.Q_f=dict["Q_f"]
        self.NPSH_F=dict["NPSH_F"]
        self.NPSH_a=dict["NPSH_a"]
        self.jok_bool=dict["jok_bool"]
        self.Q_jok=dict["Q_jok"]
        self.H_jok=dict["H_jok"]
        self.H_jok_f=dict["H_jok_f"]
        self.mass=dict["mass"]
        self.A=dict["A"]
        self.B=dict["B"]
        self.C=dict["C"]
        self.D=dict["D"]
        self.F=dict["F"]
        self.Nasos_power=dict["Nasos_power"]
        self.Nasos_price=dict["Nasos_price"]
        self.Nasos_producer=dict["Nasos_producer"]
        self.Qt=dict["Qt"]
        self.Ht=dict["Ht"]
        self.img_MPNU=dict["img_MPNU"]
        self.img_MPNU_PDF=dict["img_MPNU_PDF"]
        self.istochik=dict["istochik"]
        self.nasos_name=dict["nasos_name"]

    def to_dict(self):
        return {
            "Q": self.Q,
            "H": self.H,
            "NPSH":self.NPSH,
            "Qgl": self.Qgl,
            "Hgl": self.Hgl,
            "H_f": self.H_f,
            "Power_f": self.Power_f,
            "Kol": self.Kol,
            "DN_in": self.DN_in,
            "DN_out": self.DN_out,
            "Q_f": self.Q_f,
            "NPSH_F": self.NPSH_F,
            "NPSH_a": self.NPSH_a,
            "jok_bool":self.jok_bool,
            "Q_jok": self.Q_jok,
            "H_jok": self.H_jok,
            "H_jok_f":self.H_jok_f,
            "mass": self.mass,
            "A": self.A,
            "B": self.B,
            "C": self.C,
            "D": self.D,
            "F": self.F,
            "Nasos_power": self.Nasos_power,
            "Nasos_price": self.Nasos_price,
            "Nasos_producer": self.Nasos_producer,
            "Qt": self.Qt,
            "Ht": self.Ht,
            "img_MPNU":self.img_MPNU,
            "img_MPNU_PDF":self.img_MPNU_PDF,
            "istochik": self.istochik,
            "nasos_name": self.nasos_name,
        }
    @classmethod
    def from_dict(cls, dict_):
        """
        Создаёт объект класса MPNY_new из словаря dict_.
        """
        return cls(dict_)
class MPNY1():
    def __init__(self,Pump,H_poteri,DN_in, DN_out,DN_kon,Q,H,Kol_pump,jok_bool,Q_jok,H_jok,ist_h,istochik):
        #Список объектов
        self.Elements=[]
        #Обьекты
        self.BAK = "24 х 2"
        self.Z1=None
        self.Z2=None
        self.CV=None
        self.f6_plosk=None
        self.f4=None
        self.Otvod=None
        self.f5=None 
        self.f7_plosk=None
        self.D_trub_no_perex =None
        self.f1=None 
        self.f2=None 
        self.Tee=None
        self.SHYN=None

        self.T_VSAS=None
        self.T_NAPOR=None
        self.hom_vsas=None
        self.hom_napor=None
        self.Ugolok=None
        self.LU_pods_=None
        self.Prof_pod_napor=None
        self.t_vsas1=None
        self.Perexod_eks=None
        self.Perexod_eks2=None
        self.t_perex=None
        self.NASOS=Pump
        self.Perexod_konc=None
       

        #Числовые значения
        self.Plosk_flan=None
        self.isp_koncentr=None
        self.flanc=None
        self.flanc1=None
        self.isp_ekscentr=None
        self.isp_koncentr=None
        self.isp_tee=None
        self.ISPOLNEN_LOGIKI=2
        self.isp_naporn_flan=None
        self.isp_napor_minflan=None
        self.ISP_OTVOD=None
        self.LU_podst=None
        self.LU_pods_napor=None
        self.L_pod_napor=None
        self.L_trub=None
        self.D_out_1=0
        #self.Sled_SCHvel_NMM=None
        #Габариты
        self.A=0
        self.B=0
        self.C=0
        self.D=0
        self.F=0

        self.Spisok=""
        #Стандартые свойства
        self.DN_in=DN_in
        self.DN_out=DN_out
        self.DN_kon=DN_kon
        self.Pump=Pump
        self.D_out_pump=Pump.DN_out
        self.D_in_pump=Pump.DN_in
        # self.SHram=DICT_Global[f"sh_10П"]
        # self.SHnasos=DICT_Global[f"sh_10П"]
        if "NM" in Pump.MARKA_TFlex and "NMM" not in Pump.MARKA_TFlex:
            self.SHram=f"sh_{Pump.Schvel_Numb}"
        else:
            self.SHram=f"sh_12П"
                    
        self.SHnasos=f"sh_12П"
        
        self.Schveller_Ram=DICT_Scveller.get(self.SHram)
        self.Schveller_Nasos=DICT_Scveller.get(self.SHnasos)
        self.Kol_pump=Kol_pump
        self.Sym_kol_pump=Kol_pump+1
        self.Q_MPNY=[0]*10
        self.H_MPNY=[0]*10
        self.H_MPNY_pot=[0]*10
        self.H_pot=[0]*10
        self.Power=Pump.Power*Kol_pump
        self.Price=0  
        self.Q=Q
        self.H=H
        self.ist_h=ist_h
        self.istochik=istochik
        self.Q_jok=Q_jok
        self.H_jok=H_jok
        self.jok_bool=jok_bool
        self.Jok_Pump=None
        self.H_poteri=H_poteri
        self.H_=H_poteri.H
        self.Q_=H_poteri.Q_gl
        self.NPSH=[0]*10
        self.mass=0
        self.Name =f"Кол-во основных насосов: {Kol_pump} Модель: {Pump.Name}"
        if jok_bool:
            nal_jok=1
        else:
            nal_jok=0
        self.img_MPNU=f"/static/app/img/MHC{self.Sym_kol_pump}_{nal_jok}.png"
        self.img_MPNU_PDF=f"app/img/MHC{self.Sym_kol_pump}_{nal_jok}.png"
        if "MHC" in self.Pump.MARKA_TFlex:
             self.img_MPNU=f"/static/app/img/MHC{self.Sym_kol_pump}_{nal_jok}.png"
             self.img_MPNU_PDF=f"app/img/MHC{self.Sym_kol_pump}_{nal_jok}.png"
        if "NM" in self.Pump.MARKA_TFlex:
             self.img_MPNU=f"/static/app/img/NM{self.Sym_kol_pump}_{nal_jok}.png"
             self.img_MPNU_PDF=f"app/img/NM{self.Sym_kol_pump}_{nal_jok}.png"
        if "NMM" in self.Pump.MARKA_TFlex:
             self.img_MPNU=f"/static/app/img/NMM{self.Sym_kol_pump}_{nal_jok}.png"
             self.img_MPNU_PDF=f"app/img/NMM{self.Sym_kol_pump}_{nal_jok}.png"
        if "Hydroo" in self.Pump.MARKA_TFlex:
             self.img_MPNU=f"/static/app/img/Hydroo{self.Sym_kol_pump}_{nal_jok}.png"
             self.img_MPNU_PDF=f"app/img/Hydroo{self.Sym_kol_pump}_{nal_jok}.png"


        for i in range(10):
            self.Q_MPNY[i]=Pump.Q[i]*Kol_pump
            self.H_MPNY_pot[i]=Pump.H[i]
            self.NPSH[i]=Pump.NPSH[i]+h_pot_in(DN_in, DN_out,DN_kon, Pump,Kol_pump, self.Q_MPNY[i])
            self.H_pot[i]=h_pot(DN_in, DN_out,DN_kon, Pump,Kol_pump, self.Q_MPNY[i])
            self.H_MPNY[i]=self.H_MPNY_pot[i]-self.H_pot[i]
        self.SP_EL = []
        self.Zatvor_in =DICT_Global[f"zat_{DN_in}"]
        self.Check =DICT_Global[f"check_{DN_kon}"]
        self.Zatvor_kon =DICT_Global[f"zat_{DN_kon}"]
        self.SP_EL.append(self.Zatvor_in)
        if Kol_pump>1:
            self.SP_EL.append(self.Zatvor_in)
        for e in range(Kol_pump+1):
            self.SP_EL.append(self.Zatvor_in)
            self.SP_EL.append(self.Zatvor_kon)
            self.SP_EL.append(self.Check)
            self.SP_EL.append(Pump)
            self.mass=self.mass+Pump.mass
        # for e in self.SP_EL:
        #     self.Price=self.Price+e.Price
    def Add(self,Jok_Pump):
        self.Jok_Pump=Jok_Pump
        # self.Price=self.Price+Jok_Pump.Price
        self.mass=self.mass+Jok_Pump.mass
        self.Elements.append(Jok_Pump)
    def Get_NPSH(self,Q):

        x = np.array(self.Q_MPNY)
        y = np.array(self.NPSH)

        # Построение матрицы Вандермонда
        X = np.vander(x, 6)  # 6 колонок для степени 5

        # Решение методом МНК
        c = np.linalg.lstsq(X, y, rcond=None)[0]
        return c[5]+c[4]*Q+c[3]*Q**2+c[2]*Q**3+c[1]*Q**4+c[0]*Q**5
    def Get(self,Q):

        x = np.array(self.Q_MPNY)
        y = np.array(self.H_MPNY)

        # Построение матрицы Вандермонда
        X = np.vander(x, 6)  # 6 колонок для степени 5

        # Решение методом МНК
        c = np.linalg.lstsq(X, y, rcond=None)[0]
        return c[5]+c[4]*Q+c[3]*Q**2+c[2]*Q**3+c[1]*Q**4+c[0]*Q**5
    def Get_pot(self,Q):

        x = np.array(self.Q_MPNY)
        y = np.array(self.H_pot)

        # Построение матрицы Вандермонда
        X = np.vander(x, 6)  # 6 колонок для степени 5

        # Решение методом МНК
        c = np.linalg.lstsq(X, y, rcond=None)[0]
        return c[5]+c[4]*Q+c[3]*Q**2+c[2]*Q**3+c[1]*Q**4+c[0]*Q**5
    

    def dict(self):
        d = {}
        d["Q"] = self.Q_MPNY
        d["H"] = self.H_MPNY
        d["NPSH"]=self.Pump.NPSH
        d["Qgl"] = self.Q
        d["Hgl"] = self.H
        d["H_f"] = round(self.Get(self.Q), 1)
        d["Power_f"] = self.Power
        d["Kol"] = self.Sym_kol_pump
        d["DN_in"] = self.DN_in
        d["DN_out"] = self.DN_out
        d["Q_f"] = self.Q
        d["NPSH_F"] = round(self.Get_NPSH(self.Q),1)
        d["NPSH_a"] = self.ist_h
        d["jok_bool"] = self.jok_bool
        d["Q_jok"] = self.Q_jok
        d["H_jok_f"] ="-"
        d["H_jok"] = self.H_jok
        if self.jok_bool:
            d["H_jok_f"] =round(self.Jok_Pump.Get(self.Q_jok),1)
        else:
            d["H_jok_f"] ="-"
        
        d["mass"] = self.mass
        d["A"] = self.A
        d["B"] = self.B
        d["C"] = self.C
        d["D"] = self.D
        d["F"] = self.F
        d["Nasos_power"] = self.Pump.Power
        d["Nasos_producer"] = self.Pump.Producer
        d["Nasos_price"]=self.Pump.Price
        d["Qt"]=[0, self.Q, self.Q]
        d["Ht"]=[self.Get(self.Q), self.Get(self.Q), 0]
        d["img_MPNU"]=self.img_MPNU
        d["img_MPNU_PDF"]=self.img_MPNU_PDF
        d["istochik"]=self.istochik
        d["nasos_name"]=self.Pump.Name
        
        return d
    def Element(self):
                
        self.Z1 = DICT_Global.get(f"zat_{self.DN_in}")  # #// объект затвор на всасе
        self.Z2 = DICT_Global.get(f"zat_{self.DN_kon}") # ##/ завтор на напорной ветке
        self.C_V = DICT_Global.get(f"check_{self.DN_kon}")# ## Обратный клапан
        if self.DN_in == 40 or self.DN_in == 50 or self.DN_in == 125 or self.DN_in == 450 or (self.DN_in == 150 and self.ISPOLNEN_LOGIKI == 1) or (self.DN_in == 100 and self.ISPOLNEN_LOGIKI == 1):
            self.isp_ekscentr = 1
        else:
            self.isp_ekscentr = 2
        
        if (self.DN_in == 100 and self.ISPOLNEN_LOGIKI == 1) or self.DN_in == 125 or (self.DN_in == 150 and self.ISPOLNEN_LOGIKI == 1) or self.DN_in == 300:
            self.flanc1 = 2
        else:
            self.flanc1 = 1  # #// ряд биг фланца 11 на переходе          

        if self.D_in_pump == 125 and self.isp_ekscentr == 2:
            self.flanc = 1
        elif (self.D_in_pump == 100 and self.ISPOLNEN_LOGIKI == 1) or self.D_in_pump == 125 or (self.D_in_pump == 150 and self.ISPOLNEN_LOGIKI == 1) or self.D_in_pump == 300:
            self.flanc = 2
        else:
            self.flanc = 1
         
        if self.DN_in == 32 or self.DN_in == 40 or self.DN_in == 50 or (self.DN_in == 100 and self.ISPOLNEN_LOGIKI == 1) or self.DN_in == 125 or (self.DN_in == 150 and self.ISPOLNEN_LOGIKI == 1):
            self.isp_tee = 1
        else:
            self.isp_tee = 2            

        if self.DN_kon == 40 or self.DN_kon == 50 or self.DN_kon == 125 or self.DN_kon == 450:
            self.isp_koncentr = 1
        else:
            self.isp_koncentr = 2            

        if self.D_out_pump == 40 or self.D_out_pump == 50 or self.D_out_pump == 125 or self.D_out_pump == 250 or self.D_out_pump == 300:
            self.Plosk_flan = 2
        else:
            self.Plosk_flan = 1  # ##/ исполнение всех плоских фланцев на напорных коллекторах
            
        self.f6_plosk = DICT_Global.get(f"f01_{self.D_out_pump}_{self.Plosk_flan}")
        self.isp_naporn_flan = 0
        
        if (self.DN_out == 100 and self.ISPOLNEN_LOGIKI == 1) or self.DN_out == 125 or (self.DN_out == 150 and self.ISPOLNEN_LOGIKI == 1) or self.DN_out == 300:
            self.isp_naporn_flan = 2
        else:
            self.isp_naporn_flan = 1         
        self.f4 = DICT_Global.get(f"f11_{self.DN_out}_{self.isp_naporn_flan}")  # // выходные фланцы напорного коллектора 2 шт.

        if self.D_out_pump == 40 or self.D_out_pump == 50 or self.D_out_pump == 125 or self.D_out_pump == 450:
            self.ISP_OTVOD = 1
        else:
            self.ISP_OTVOD = 2  # ######// пока блок до выяснения обстоятельств
            
        self.Otvod = DICT_Global.get(f"Otvod_{self.D_out_pump}_{self.ISP_OTVOD}")  # ###############// отвод на вертикалках...
        
        if self.DN_kon == self.D_out_pump:
            self.DN_kon_trub = self.D_out_pump
        else:
            self.DN_kon_trub = self.DN_kon  # #####// bитоговый DN на напорной ветке переход-труба

        if (self.DN_kon_trub == 100 and self.ISPOLNEN_LOGIKI == 1) or self.DN_kon_trub == 125 or (self.DN_kon_trub == 150 and self.ISPOLNEN_LOGIKI == 1) or self.DN_kon_trub == 300:
            self.isp_napor_minflan = 2
        else:
            self.isp_napor_minflan = 1        
        self.f5 = DICT_Global.get(f"f11_{self.DN_kon_trub}_{self.isp_napor_minflan}")  # //  фланцы на напорной ветке у затвора
        
        if self.DN_kon_trub == 40 or self.DN_kon_trub == 50 or self.DN_kon_trub == 125 or self.DN_kon_trub == 250 or self.DN_kon_trub == 300:
            self.Plosk_flan_max = 2
        else:
            self.Plosk_flan_max = 1  # ##/ исполнение всех плоских фланцев на напорных коллекторах
        self.f7_plosk = DICT_Global.get(f"f01_{self.DN_kon_trub}_{self.Plosk_flan_max}")
        
        self.D_trub_no_perex = DICT_Global.get(f"tr_{self.D_out_pump}_{self.ISPOLNEN_LOGIKI}")  # ## труба , когда нет концентрич перехода            
       
        self.f1 = DICT_Global.get(f"f11_{self.D_in_pump}_{self.flanc}")  # // фланец у насоса               
        self.f3 = DICT_Global.get(f"f11_{self.DN_in}_{self.flanc1}")  # // фланцы на преходе у затвора и на тройниках
        self.Tee_ = DICT_Global.get(f"Tee_{self.DN_in}_{self.isp_tee}")  # // тройник на всасе
                        
        # self.Schveller_Ram = DICT_Global.get(f"sh_{self.SHram}")  # // ШВеллер рамы"sh_{sh.nameP}""sh_{self.SHram}"
        # self.Schveller_Nasos = DICT_Global.get(f"sh_{self.SHnasos}")  # // ШВеллер насоса
        
        # #// Расчет уголка !!!!
        self.T_VSAS = DICT_Global.get(f"tr_{self.DN_in}_{self.ISPOLNEN_LOGIKI}")
        self.T_NAPOR = DICT_Global.get(f"tr_{self.DN_out}_{self.ISPOLNEN_LOGIKI}")

        # self.hom_vsas = next((kvp for k, v in DICT_Global.items() if isinstance(v, homut) and v.D >= T_VSAS.D1), None)  # ########/ хомут на всасе ##// прмиер обращения closestD = D_hom_vsas.Value.D;
        # self.hom_napor = next((kvp for k, v in DICT_Global.items() if isinstance(v, homut) and v.D >= T_NAPOR.D1), None)  # ########/ хомут на напоре
        # self.Ugolok = DICT_Global.get("ugolok_50_50")  # ######   используетсчя только 50 на 50 при необходимости прописать логику !!!!!!!!!!!!!!!!!!!!!!!!
        if self.T_VSAS:
            self.LU_podst = math.floor(self.T_VSAS.D1 / 5) * 5 + 120
        else:
            self.LU_podst = 0

        # угловой под всасывающим коллектором
        # self.LU_pods_napor = math.floor(hom_napor.D / 10) * 10 + 100 if hom_napor else 0  # ##########// e_1 в кофниге
        # self.L_pod_napor = LU_pods_napor - LU_pods_napor / 4 if DN_out < 80 else LU_pods_napor
        # Prof_pod_napor = DICT_Global.get("proftrub_40_40")  # ######// под напорным коллектором

        # if hom_napor:
        #     Elements.append(hom_napor)
        #     Elements.append(hom_napor)

        # SHYK = DICT_Global.get("SHYK")
        jok1=0
        if(self.jok_bool):
            jok1=1
        if(self.NASOS.Power<=45):
            self.SHYN = DICT_Global.get(f"SHYN_{self.Sym_kol_pump}_{self.NASOS.Power}_D_{jok1}")
        else:
            self.SHYN = DICT_Global.get(f"SHYN_{self.Sym_kol_pump}_{self.NASOS.Power}_S_{jok1}")

        #self.STROCA=f"SHYN_{self.Nasos}_{self.Power}_{self.Pysk}_{self.Jok}"

        # # # if SHYK:
        # # #     self.Elements.append(SHYK)
        if (self.SHYN!=None):
            self.Elements.append(self.SHYN)
        if self.Jok_Pump!=None:
            self.Elements.append(self.Jok_Pump)

        # if self.DN_out < 80:
        #     pass
        # else:
        #     if Ugolok:
        #         Elements.append(Ugolok)
        #         Elements.append(Ugolok)  # ######//  уголки под напорный коллектор (если меньше 80 ), то стоят хомуты и уголка нет
        # if Prof_pod_napor:
        #     Elements.append(Prof_pod_napor)
        #     Elements.append(Prof_pod_napor)

        if self.Sym_kol_pump == 2:
            self.Elements.append(self.NASOS)
            self.Elements.append(self.NASOS)
            # PD = DICT_Global.get("PD")
            # if PD:
            #     Elements.append(PD)
            if self.Tee_:
                self.Elements.append(self.Tee_)
                self.Elements.append(self.Tee_)
            if self.Z1:
                self.Elements.append(self.Z1)
                self.Elements.append(self.Z1)
                self.Elements.append(self.Z1)
            if self.Z2:
                self.Elements.append(self.Z2)
                self.Elements.append(self.Z2)
            if self.C_V:
                self.Elements.append(self.C_V)
                self.Elements.append(self.C_V)
            # if hom_vsas:
            #     Elements.append(hom_vsas)
            #     Elements.append(hom_vsas)
            #     Elements.append(hom_vsas)
            #     Elements.append(hom_vsas)
            if self.f1:
                self.Elements.append(self.f1)
                self.Elements.append(self.f1)
            if self.f4:
                self.Elements.append(self.f4)
                self.Elements.append(self.f4)
            if self.f5:
                self.Elements.append(self.f5)
                self.Elements.append(self.f5)
                self.Elements.append(self.f5)
                self.Elements.append(self.f5)
            if self.f6_plosk:
                self.Elements.append(self.f6_plosk)
                self.Elements.append(self.f6_plosk)
            if self.f7_plosk:
                self.Elements.append(self.f7_plosk)
                self.Elements.append(self.f7_plosk)
                self.Elements.append(self.f7_plosk)
                self.Elements.append(self.f7_plosk)
            for i in range(8):
                if self.f3:
                    self.Elements.append(self.f3)
            if self.Pump.MARKA_TFlex == "Hydroo" and self.Otvod:
                self.Elements.append(self.Otvod)
                self.Elements.append(self.Otvod)
            #  #/ патрубки на всас коллекторах по 200 мм.
            self.t_vsas1 = truba10704_L(DICT_Global.get(f"tr_{self.DN_in}_{self.ISPOLNEN_LOGIKI}"), 200)
            self.Elements.append(self.t_vsas1)
            self.Elements.append(self.t_vsas1)
        if self.Sym_kol_pump == 3:
            self.Elements.append(self.NASOS)
            self.Elements.append(self.NASOS)
            self.Elements.append(self.NASOS)
            # PD = DICT_Global.get("PD")
            # if PD:
            #     Elements.append(PD)
            #     Elements.append(PD)
            #     Elements.append(PD)
            if self.Tee_:
                self.Elements.append(self.Tee_)
                self.Elements.append(self.Tee_)
                self.Elements.append(self.Tee_)
            if self.Z1:
                for i in range(5):
                    self.Elements.append(self.Z1)
            if self.Z2:
                self.Elements.append(self.Z2)
                self.Elements.append(self.Z2)
                self.Elements.append(self.Z2)
            if self.C_V:
                self.Elements.append(self.C_V)
                self.Elements.append(self.C_V)
                self.Elements.append(self.C_V)
            # if self.hom_vsas:
            #     self.Elements.append(hom_vsas)
            #     Elements.append(hom_vsas)
            #     Elements.append(hom_vsas)
            #     Elements.append(hom_vsas)
            #     Elements.append(hom_vsas)
            #     Elements.append(hom_vsas)
            if self.f1:
                self.Elements.append(self.f1)
                self.Elements.append(self.f1)
                self.Elements.append(self.f1)
            if self.f4:
                self.Elements.append(self.f4)
                self.Elements.append(self.f4)
            if self.f5:
                self.Elements.append(self.f5)
                self.Elements.append(self.f5)
                self.Elements.append(self.f5)
                self.Elements.append(self.f5)
                self.Elements.append(self.f5)
                self.Elements.append(self.f5)
            if self.f6_plosk:
                self.Elements.append(self.f6_plosk)
                self.Elements.append(self.f6_plosk)
                self.Elements.append(self.f6_plosk)
            if self.f7_plosk:
                self.Elements.append(self.f7_plosk)
                self.Elements.append(self.f7_plosk)
                self.Elements.append(self.f7_plosk)
                self.Elements.append(self.f7_plosk)
                self.Elements.append(self.f7_plosk)
                self.Elements.append(self.f7_plosk)
            for i in range(12):
                if self.f3:
                    self.Elements.append(self.f3)
            # if NASOS.MARKA_TFlex == "Hydroo" and Otvod:
            #     Elements.append(Otvod)
            #     Elements.append(Otvod)
            #     Elements.append(Otvod)
            #  #/ патрубки на всас коллекторах по 200 мм.
            self.t_vsas1 = truba10704_L(DICT_Global.get(f"tr_{self.DN_in}_{self.ISPOLNEN_LOGIKI}"), 200)
            self.Elements.append(self.t_vsas1)
            self.Elements.append(self.t_vsas1)
            self.Elements.append(self.t_vsas1)
         
        # if self.ISTOCHNIK == "Водопровод":
        #     PD = DICT_Global.get("PD")
        #     if PD:
        #         Elements.append(PD)
        #         Elements.append(PD)
        # if ISTOCHNIK == "Резервуар":
        #     YKY = DICT_Global.get("YKY")
        #     if YKY:
        #         Elements.append(YKY)
        #         Elements.append(YKY)

            Truba_Naporn = DICT_Global.get(f"tr_{self.DN_out}_{self.ISPOLNEN_LOGIKI}") # объект трубы напорного коллектора
            for i in range(self.Sym_kol_pump):
                if self.D_in_pump != self.DN_in:
                    self.eks_key = f"eks_{self.DN_in}_{self.D_in_pump}_{self.isp_ekscentr}"
                    if self.eks_key in DICT_Global:
                        self.Perexod_eks = DICT_Global.get(self.eks_key)
                        self.Elements.append(self.Perexod_eks)
                    else:
                        self.DN_values = [32,40,50,65,80,100,125,150,200,250,300,350,400,450,500,600,700,800]  # Пример диапазона DN
                        for i in range(len(self.DN_values) - 1):
                            DN1 = self.DN_values[i]
                            DN2 = self.DN_values[i + 1]
                            
                            if ((self.DN_in + self.D_in_pump) / 2 >= DN1 and (self.DN_in +self.D_in_pump) / 2 <= DN2):
                                key1 = f"eks_{self.DN_in}_{DN1}_{self.isp_ekscentr}"
                                key2 = f"eks_{DN1}_{self.D_in_pump}_{self.isp_ekscentr}"
                                if key1 in DICT_Global and key2 in DICT_Global:
                                    self.Perexod_eks = DICT_Global.get(key1)
                                    self.Perexod_eks2 = DICT_Global.get(key2)
                                    self.Elements.append(self.Perexod_eks)
                                    self.Elements.append(self.Perexod_eks2)
                                    break
                else:
                    self.L_trub = 0
                    if self.DN_in < 100:
                        self.L_trub = 100
                    elif self.DN_in > 300:
                        self.L_trub = 220
                    elif 100 <= self.DN_in < 200:
                        self.L_trub = 140
                    else:
                        self.L_trub = 180
                    self.t_perex = truba10704_L(DICT_Global.get(f"tr_{self.DN_in}_{self.ISPOLNEN_LOGIKI}"), self.L_trub)
                    self.Elements.append(self.t_perex)

                konc_key = f"konc_{self.DN_kon}_{self.D_out_pump}_{self.isp_koncentr}"
                if self.D_out_pump != self.DN_out and konc_key in DICT_Global:
                    self.Perexod_konc = DICT_Global.get(konc_key)
                    self.Elements.append(self.Perexod_konc)

                if self.DN_kon == self.D_out_pump:
                    self.D_out_1 = self.D_trub_no_perex.D if self.D_trub_no_perex else 0
                elif self.Perexod_konc:
                    self.D_out_1 = self.Perexod_konc.D_in
                else:
                    self.D_out_1 = 0

        return self.Elements 
    def set_gabarit(self):
        Proklad = 2
        L_perex = 0
        L_trub = 180
        if self.DN_in < 100:
            L_trub = 100
        elif self.DN_in > 300:
            L_trub = 220
        elif 100 <= self.DN_in < 200:
            L_trub = 140

        if self.Perexod_eks is not None:
            if self.Perexod_eks2 is None:
                L_perex = self.Perexod_eks.L
            else:
                L_perex = self.Perexod_eks.L + self.Perexod_eks2.L
        else:
            L_perex = L_trub

        L_mhc_dop = 0
        L_patr = 200  # длина трубы на коллекторе
        t3 = 250  # расстояние между 2 и 3 насосов
        Perpad = 0
        if self.Perexod_eks is not None:
            if self.Perexod_eks2 is None:
                Perpad = self.Perexod_eks.D_in / 2 - self.Perexod_eks.D_out / 2
            else:
                Perpad = self.Perexod_eks.D_in / 2 - self.Perexod_eks2.D_out / 2
        else:
            Perpad = 0

        Norm = 600
        if self.Jok_Pump is None:
            Norm = 500
        else:
            Norm = 600

        if self.NASOS.MARKA_TFlex == "MHC":
            # расчёт длины швеллера А
            if self.BAK != "24 х 2":
                if self.JOKEI is not None:
                    L_mhc_dop = 400
                else:
                    L_mhc_dop = 0
            else:
                L_mhc_dop = 0

            self.L_rama = (
                self.NASOS.F + self.Z1.B + self.f1.B + 2 * self.f3.B +
                L_perex + L_patr + self.Tee_.h + self.Schveller_Ram.b / 2 +
                L_mhc_dop + Proklad
            )

            # расчёт t3
            self.t3=0
            Vix_razem = self.L_rama + 250 + self.LU_podst / 2
            if Vix_razem > 2300:
                self.t3 = 400
            else:
                self.t3 = 250

            # длина швеллера вдоль насосов  DICT_Global.get(f"zat_{self.DN_in}")f"sh_{self.SHram}"
            Sh_shirina = Schveller_L(
                 self.Schveller_Ram,
                 self.L_rama - 2 * self.Schveller_Ram.b
            )
            if self.Sym_kol_pump == 2:
                for _ in range(4):
                    self.Elements.append(Sh_shirina)
            else:
                for _ in range(6):
                    self.Elements.append(Sh_shirina)

            L_ram_dlin = 0
            
            b1_MHC=0

            if self.NASOS.Wide>self.Tee_.f*2:
                b1_MHC=self.NASOS.Wide
            else:
                b1_MHC = self.Tee_.f*2
            
            if self.Sym_kol_pump == 2:
                L_ram_dlin = (
                    b1_MHC * 2 + Norm + self.Schveller_Ram.b * 4
                )
            else:
                L_ram_dlin = (
                    b1_MHC * 3 + Norm + self.Schveller_Ram.b * 6 + t3
                )
            Sh_dlina = Schveller_L(
                self.Schveller_Ram,
                L_ram_dlin
            )
            self.Elements.append(Sh_dlina)
            self.Elements.append(Sh_dlina)

            if self.Jok_Pump is not None:
                Sh_jok = Schveller_L(
                    self.Schveller_Ram,
                    Norm
                )
                self.Elements.append(Sh_jok)
                self.Elements.append(Sh_jok)
            if self.Jok_Pump is None:
                Sh_jok = Schveller_L(
                    self.Schveller_Ram,
                    Norm
                )
                self.Elements.append(Sh_jok)

            L_lap = self.Schveller_Ram.h + (self.Schveller_Ram.b - self.Schveller_Ram.s)
            Sh_lap = Schveller_L(
                self.Schveller_Ram,
                L_lap
            )
            for _ in range(4):
                self.Elements.append(Sh_lap)
            self.A=self.L_rama
            

            # расчет ширины всасывающего коллектора D 
            # Коллектор 1
            self.L1_small = 0
            if (b1_MHC / 2 + self.Schveller_Ram.b - self.Tee_.f < 100):
               self.L1_small = 100
            else:
               self.L1_small = b1_MHC / 2 + self.Schveller_Ram.b - self.Tee_.f
            self.L2_big = (b1_MHC / 2 + self.Schveller_Ram.b - self.Tee_.f + Norm / 2 - self.Z1.B / 2 - self.f3.B) * 2
            L_Kol1_max = 0 ###/ Длниа мах коллектора L_inlet_12_1
            if (self.Jok_Pump == None):
                self.L_Kol1_max = round(self.L2_big * 0.35, 0)
            else:
                self.L_Kol1_max = round(self.L2_big * 0.5, 0)###/ Длниа мах коллектора L_inlet_12_1
            ################/Коллектор 2
            self.L2_Kol2 = 0 ####/ L_inlet_12_2
            self.L2_Kol2 = self.L2_big - self.L_Kol1_max ###/ Длина трубы коллектора у затвора (длина другйо трубы равна L1_small) 
            self.t_vsas_kray = truba10704_L(self.T_VSAS, self.L1_small)# # по краям коллекторов 
            if (self.Sym_kol_pump == 2):                
                    self.D = 4 * self.f3.B + self.Z1.B + 2 * self.Tee_.A+L_Kol1_max+ self.L1_small*2+self.L2_Kol2
                    self.Elements.append(self.t_vsas_kray);
                    self.Elements.append(self.t_vsas_kray);
                    self.t_vsas2 = truba10704_L(self.T_VSAS, self.L_Kol1_max)##/ 1 коллектор у затвора 
                    self.Elements.append(self.t_vsas2);
                    self.t_vsas3 =truba10704_L(self.T_VSAS, self.L2_Kol2)##/ 2 коллектор у затвора 
                    self.Elements.append(self.t_vsas3)   
            Out_L1 = 0
            t_napor=None
            if (self.Sym_kol_pump == 3):              
                    self.L2_K2_small = 0 ###/ Короткий патрубок на 2 коллекторе на 3 насоса
                    self.L2_K2_small = b1_MHC / 2 + self.Schveller_Ram.b - self.Tee_.f - self.Z1.B / 2 - self.f3.B + self.t3/2  ####/  L_in_23  ####// не учитывается разъемное или не разъемное соединение t3 
                    #######// на 3 коллекторе так же L_in_23
                    self.D = 6 * self.f3.B + self.Z1.B*2 + 3 * self.Tee_.A+ self.L1_small*2+ self.L_Kol1_max + self.L2_Kol2+ self.L2_K2_small*2;
                    #// t_vsas_kray = truba10704_L(DICT_Global.get(f"{DN_in}_{self.ISPOLNEN_LOGIKI}"), L1_small)# #/ по краям 1 и 3 коллекторов 
                    self.Elements.append(self.t_vsas_kray);
                    self.Elements.append(self.t_vsas_kray);
                    self.t_vsas2 = truba10704_L(self.T_VSAS, self.L_Kol1_max)##/ 1 коллектор у затвора 
                    self.Elements.append(self.t_vsas2);
                    self.t_vsas3 = truba10704_L(self.T_VSAS, self.L2_Kol2)# ##/ 2 коллектор у затвора 
                    self.Elements.append(self.t_vsas3);
                    self.t_vsas4 =truba10704_L(self.T_VSAS, self.L2_K2_small)# ##/ 2,3 коллектор у затвора  2 одинаковых патрубка
                    self.Elements.append(self.t_vsas4);
                    self.Elements.append(self.t_vsas4);
                    
################################################# Расчет верх коллектора F  /////// исполнение выходного коллектора  == ISPOLNEN_LOGIKI
            LL_napor = 0 # длина напорного коллектора
            if (self.Sym_kol_pump == 2):
                LL_napor = (self.D_out_1 / 2 + 150) * 2 + self.Schveller_Ram.b * 2 + Norm + b1_MHC / 2 + b1_MHC / 2
            if (self.Sym_kol_pump == 3):
                LL_napor = (self.D_out_1 / 2 + 150) * 2 + self.Schveller_Ram.b * 2 + Norm + b1_MHC / 2 + b1_MHC / 2+b1_MHC+ self.t3+self.Schveller_Ram.b*2
            t_napor = truba10704_L(DICT_Global.get(f"tr_{self.DN_out}_{self.ISPOLNEN_LOGIKI}"), LL_napor) ##/ напорный коллектор  
            self.Elements.append(t_napor);
            self.F = LL_napor + self.f4.B * 2 # ###/ габаритный размер напорного коллектора
            
            #######################################/ расчет напорной ветки Длин труб  и т.д.
                ###// длина патрубка от насоса до концентрич перехода 
            if (self.DN_kon != self.D_out_pump):
                Out_L1 = 80
            else:
                Out_L1 = 250### 250 - длина трубы без перехода
            Out_L2 = 0 ###/ длина патрубка о тперехода до обратного клапана
            if (self.DN_kon != self.D_out_pump):
                if (self.DN_kon >= 150):
                    Out_L2 = self.DN_kon
                else:
                    Out_L2 = 150
                t_napor2 = truba10704_L(DICT_Global.get(f"tr_{self.DN_kon}_{self.ISPOLNEN_LOGIKI}"), Out_L2)
                        
                if (self.Sym_kol_pump == 2):
                    self.Elements.append(t_napor2)
                    self.Elements.append(t_napor2)
                else:
                    self.Elements.append(t_napor2)
                    self.Elements.append(t_napor2)
                    self.Elements.append(t_napor2);
            else:
                Out_L2 = 0
            isp_trub1 = 0;
            
            if (self.D_out_pump == 125 and self.isp_koncentr == 1):
                isp_trub1 = 1
            else:
                isp_trub1= self.ISPOLNEN_LOGIKI
            t_napor=DICT_Global.get(f"tr_{self.DN_out}_{self.ISPOLNEN_LOGIKI}")
            t_napor1 = truba10704_L(DICT_Global.get(f"tr_{self.D_out_pump}_{self.ISPOLNEN_LOGIKI}"), Out_L1)
            if self.Sym_kol_pump == 2:
                self.Elements.extend([t_napor1, t_napor1])
            else:
                self.Elements.extend([t_napor1, t_napor1, t_napor1])

            Out_L3 = 0
            if self.DN_kon != self.D_out_pump and self.DN_kon < 125:
                Out_L3 = self.DN_kon * 2
            else:
                Out_L3 = 220

            t_napor3 = truba10704_L(DICT_Global.get(f"tr_{self.DN_kon}_{self.ISPOLNEN_LOGIKI}"), Out_L3)
            if self.Sym_kol_pump == 2:
                self.Elements.extend([t_napor3, t_napor3])
            else:
                self.Elements.extend([t_napor3, t_napor3, t_napor3])

            Out_L4 = 0
            if self.DN_kon >= 150 + t_napor.D1 / 2:
                Out_L4 = self.DN_kon
            else:
                Out_L4 = 150 +t_napor.D1 / 2

            Out_L4_1 = round(Out_L4 - ((t_napor.D1 / 2) ** 2 - (t_napor3.D1 / 2) ** 2) ** 0.5, 0)
            t_napor4 = truba10704_L(DICT_Global.get(f"tr_{self.DN_kon}_{self.ISPOLNEN_LOGIKI}"), Out_L4_1)
            if self.Sym_kol_pump == 2:
                self.Elements.extend([t_napor4, t_napor4])
            else:
                self.Elements.extend([t_napor4, t_napor4, t_napor4])
                ########################################### рассчитана длина основных труб и швеллеров , высоат и тип швеллера пока не учитывается             
                #/////////////////////////////////////////// расчет уголка на раме под шкаф
            L_Ugl_Skaf = 0
            Jok = 0
            Jokei_half = 70
            #if self.Jok_Pump is not None
            if self.Jok_Pump is not None:
                Jok = self.L_rama - 2 * self.Schveller_Ram.b - (self.Tee_.h + L_patr + 2 * self.f3.B + L_perex + self.f1.B + self.Z1.B + self.NASOS.B + self.NASOS.m1 / 2 - self.Schveller_Ram.b / 2) -(self.Jok_Pump.B_otv - 2 * (self.Schveller_Ram.b - 20) + self.Schveller_Ram.b * 2) / 2
                Jokei_half = (self.Jok_Pump.B_otv - 2 * (self.Schveller_Ram.b - 20) + self.Schveller_Ram.b * 2) / 2
                L_Ugl_Skaf = Jok + Jokei_half * 2 + self.Schveller_Ram.b
            else:
                Jok = self.L_rama - 2 * self.Schveller_Ram.b - (self.Tee_.h + L_patr + 2 * self.f3.B + L_perex + self.f1.B + self.Z1.B + self.NASOS.B + self.NASOS.m1 / 2 - self.Schveller_Ram.b / 2) -(self.Schveller_Ram.b * 2) / 2
                L_Ugl_Skaf = Jok + self.Schveller_Ram.b * 2

            # LU_pod_Skaf = ugolok(Form1.ugolok_COLL[f"{50}_{50}"], L_Ugl_Skaf)  будет использована толщина уголка 4 мм
            # Elements.extend([LU_pod_Skaf, LU_pod_Skaf])

            He_MHC_Gorizont = 0
            He_MHC_Vertikal = 0
            He_MHC_Vertikal_1 = 0
            MHC_variant = 0
            Rachet_visoti = self.Schveller_Nasos.h

            Visota_otosi = 0
            He_MHC = 0

            He_MHC_Gorizont = self.NASOS.h1 - Perpad - self.t_vsas_kray.D1 / 2 + self.Schveller_Nasos.b - 4
            He_MHC_Vertikal = self.NASOS.h1 - Perpad - self.t_vsas_kray.D1 / 2 + self.Schveller_Nasos.h - 4

            if self.Perexod_eks is not None:
                MHC_variant = He_MHC_Vertikal + 4 + self.Perexod_eks.D_in / 2 - self.f3.A / 2
            else:
                MHC_variant = He_MHC_Vertikal + 4 + self.t_vsas_kray.D1 / 2 - self.f3.A / 2

            if MHC_variant <= 0:
                Visota_otosi = Rachet_visoti - MHC_variant
            else:
                Visota_otosi = Rachet_visoti + MHC_variant
              
            #///////////////////////////////////////////////////////////////////////////поиск швеллера     
            filtered = [s for s in DICT_Scveller.values() if s.h > Visota_otosi]
            if filtered:
                filtered_sorted = sorted(filtered, key=lambda x: x.h)
                self.Sled_SCHvel = filtered_sorted[0]
            else:
                self.Sled_SCHvel = None
            
            if self.Sled_SCHvel is not None:
                
                He_MHC_Vertikal_1 = self.NASOS.h1 - Perpad - self.t_vsas_kray.D1/2+self.Sled_SCHvel.h-4
                
            if He_MHC_Gorizont <= 60 and MHC_variant >= 15:
                He_MHC = He_MHC_Vertikal
            elif MHC_variant < 15 and self.Sled_SCHvel is not None:
                He_MHC = He_MHC_Vertikal_1
            elif self.Pump.Power < 37:
                He_MHC = He_MHC_Vertikal
            else:
                He_MHC = He_MHC_Gorizont

            # if self.Sled_SCHvel is not None:
            #      if He_MHC=He_MHC_Vertikal_1:
                       

            L_podNasos = b1_MHC + self.Schveller_Ram.b * 2
            # Sh_nasos = Schveller(Form1.Schveller_COLL[f"{Sled_Schveller_Nasos.Name}"], L_podNasos)
            Sh_nasos = Schveller_L(self.Schveller_Ram,L_podNasos)
            if self.Sym_kol_pump == 2:
                self.Elements.extend([Sh_nasos] * 8)
            else:
                self.Elements.extend([Sh_nasos] * 12)
                Sh_mg_nasos =Schveller_L(self.Schveller_Ram,t3)
                self.Elements.append(Sh_mg_nasos)

            self.C = self.Schveller_Ram.h + He_MHC  + self.t_vsas_kray.D1 / 2 +4 

            if self.Perexod_konc is not None:
                self.B = (self.C + Perpad + (self.NASOS.h - self.NASOS.h1) + 3 * Proklad + 30 + self.f5.B * 2 +self.Z2.B + self.C_V.B + Out_L1 + Out_L2 +Out_L3 + Out_L4 + self.Perexod_konc.L)
            else:
                self.B = (self.C + Perpad + (self.NASOS.h - self.NASOS.h1) + 3 * Proklad + self.f5.B * 2 +self.Z2.B + self.C_V.B + Out_L1 + Out_L3 + Out_L4 + 30)
                





        if self.NASOS.MARKA_TFlex == "NM":
                # self.Schveller_Ram = DICT_Scveller.get(self.NASOS.Schvel_Numb) #///////////////////////////////////// швеллер рамы     
                L_NM_1 = 0;
                if (self.NASOS.L_ram - self.NASOS.F > 0):
                    L_NM_1 = (self.NASOS.L_ram - self.NASOS.F) + (self.NASOS.a - self.NASOS.L3)
                else:
                    L_NM_1 = 0
                self.L_rama = self.NASOS.F + L_NM_1 + self.Schveller_Ram.b / 2 + self.Z1.B + self.Tee_.h + L_patr + self.f3.B * 2 + self.f1.B + L_perex + Proklad;
                #######//расчет t3               
                Vix_razem = 0
                Vix_razem = self.L_rama + 250 + self.LU_podst / 2 ########/ 250 - ширина шкафа
                if (Vix_razem > 2300):
                   t3 = 400
                else:
                   t3 = 250
                ################# конец расчета t3
                Sh_shirina = Schveller_L(self.Schveller_Ram, self.L_rama - 2 * self.Schveller_Ram.b)###/ длина швеллера вдоль насосов
                if (self.Sym_kol_pump == 2):
                    for i in range(4):
                        self.Elements.append(Sh_shirina);
                    for i in range(6):
                        self.Elements.append(Sh_shirina);
                    Sh_mg_nasos = Schveller_L(self.Schveller_Ram, t3) ###/ длина швеллера между 2 и 3 насосом
                    self.Elements.append(Sh_mg_nasos);
                L_ram_dlin = 0;
                if (self.Sym_kol_pump == 2):
                   L_ram_dlin = (self.NASOS.Ws - (self.Schveller_Ram.b - (self.NASOS.Wide - self.NASOS.Ws) / 2) * 2) * 2 + Norm + self.Schveller_Ram.b * 4
                else:
                   L_ram_dlin = (self.NASOS.Ws - (self.Schveller_Ram.b - (self.NASOS.Wide - self.NASOS.Ws) / 2) * 2) * 3 + Norm + self.Schveller_Ram.b * 6 + t3
                Sh_dlina = Schveller_L(self.Schveller_Ram, L_ram_dlin)###/ длина швеллера поперек насосов
                self.Elements.append(Sh_dlina)
                self.Elements.append(Sh_dlina)
                if self.Jok_Pump is not None:
                    Sh_jok = Schveller_L(self.Schveller_Ram, Norm);
                    self.Elements.append(Sh_jok)
                    self.Elements.append(Sh_jok);
                if self.Jok_Pump==None:
                    Sh_jok = Schveller_L(self.Schveller_Ram, Norm);
                    self.Elements.append(Sh_jok);
                L_lap = 0
                L_lap = self.Schveller_Ram.h + (self.Schveller_Ram.b - self.Schveller_Ram.s)
                Sh_lap = Schveller_L(self.Schveller_Ram, L_lap);
                self.Elements.append(Sh_lap)
                self.Elements.append(Sh_lap)
                self.Elements.append(Sh_lap)
                self.Elements.append(Sh_lap)
                ###############//расчет ширины всасывающего коллектора D 
                #############//Коллектор 1
                L1_small = 0##/ кототкий патрубок 
                #// Коллектор 1 патрубок маленький 
                if ((self.NASOS.Ws - (self.Schveller_Ram.b - (self.NASOS.Wide - self.NASOS.Ws) / 2) * 2) / 2 + self.Schveller_Ram.b - self.Tee_.f < 100):
                    L1_small = 100
                else:
                    L1_small = (self.NASOS.Ws - (self.Schveller_Ram.b - (self.NASOS.Wide - self.NASOS.Ws) / 2) * 2) / 2 + self.Schveller_Ram.b - self.Tee_.f ###/ L_in_1

                L2_big = 0## длинный патрубок L_inlet_12              

                L2_big = ((self.NASOS.Ws - (self.Schveller_Ram.b - (self.NASOS.Wide - self.NASOS.Ws) / 2) * 2) / 2 + self.Schveller_Ram.b - self.Tee_.f + Norm / 2 - self.Z1.B / 2 - self.f3.B) * 2 ## длинный патрубок L_inlet_12
                L_Kol1_max = 0 ###/ Длниа мах коллектора L_inlet_12_1

                if self.Jok_Pump==None:
                   L_Kol1_max = round(L2_big * 0.35, 0)
                else:
                   L_Kol1_max = round(L2_big * 0.5, 0)# ##/ Длниа мах коллектора L_inlet_12_1
                ################/Коллектор 2
                L2_Kol2 = 0 ####/ L_inlet_12_2
                L2_Kol2 = L2_big - L_Kol1_max ###/ Длина трубы коллектора у затвора (длина другйо трубы равна L1_small) 
                t_vsas_kray = truba10704_L(DICT_Global.get(f"tr_{self.DN_in}_{self.ISPOLNEN_LOGIKI}"), L1_small)##/ по краям коллекторов 
                
                
                if (self.Sym_kol_pump == 2):
                    self.D = 4 * self.f3.B + self.Z1.B + 2 * self.Tee_.A + L_Kol1_max + L1_small * 2 + L2_Kol2#####// 
                   
                    self.Elements.append(t_vsas_kray)
                    self.Elements.append(t_vsas_kray)
                    t_vsas2 = truba10704_L(DICT_Global.get(f"tr_{self.DN_in}_{self.ISPOLNEN_LOGIKI}"), L_Kol1_max) # #/ 1 коллектор у затвора 
                    self.Elements.append(t_vsas2)
                    t_vsas3 = truba10704_L(DICT_Global.get(f"tr_{self.DN_in}_{self.ISPOLNEN_LOGIKI}"), L2_Kol2)##/ 2 коллектор у затвора 
                    self.Elements.append(t_vsas3)
                if (self.Sym_kol_pump == 3):
                    L2_K2_small = 0 ###/ Короткий патрубок на 2 коллекторе на 3 насоса
                    L2_K2_small = (self.NASOS.Ws - (self.Schveller_Ram.b - (self.NASOS.Wide - self.NASOS.Ws) / 2) * 2) / 2 + self.Schveller_Ram.b - self.Tee_.f - self.Z1.B / 2 - self.f3.B + t3 / 2####/  L_in_23  ####// не учитывается разъемное или не разъемное соединение t3 
                    #######// на 3 коллекторе так же L_in_23
                    self.D = 6 * self.f3.B + self.Z1.B * 2 + 3 * self.Tee_.A + L1_small * 2 + L_Kol1_max + L2_Kol2 + L2_K2_small * 2;
                    #t_vsas_kray = truba10704_L(DICT_Global.get(f"{DN_in}_{self.ISPOLNEN_LOGIKI}"), L1_small)# #/ по краям 1 и 3 коллекторов 
                    self.Elements.append(t_vsas_kray);
                    self.Elements.append(t_vsas_kray);
                    t_vsas2 = truba10704_L(DICT_Global.get(f"tr_{self.DN_in}_{self.ISPOLNEN_LOGIKI}"), L_Kol1_max) ##/ 1 коллектор у затвора 
                    self.Elements.append(t_vsas2);
                    t_vsas3 = truba10704_L(DICT_Global.get(f"tr_{self.DN_in}_{self.ISPOLNEN_LOGIKI}"), L2_Kol2)##/ 2 коллектор у затвора 
                    self.Elements.append(t_vsas3);
                    t_vsas4 = truba10704_L(DICT_Global.get(f"tr_{self.DN_in}_{self.ISPOLNEN_LOGIKI}"), L2_K2_small)##/ 2,3 коллектор у затвора  2 одинаковых патрубка
                    self.Elements.append(t_vsas4);
                    self.Elements.append(t_vsas4);


                #################### Расчет верх коллектора F  ##/ исполнение выходного коллектора  == self.ISPOLNEN_LOGIKI
                LL_napor = 0##// длина напорного коллектора
                if (self.Sym_kol_pump == 2):
                   LL_napor = (self.D_out_1 / 2 + 150) * 2 + self.Schveller_Ram.b * 2 + Norm + (self.NASOS.Ws - (self.Schveller_Ram.b - (self.NASOS.Wide - self.NASOS.Ws) / 2) * 2) / 2 + (self.NASOS.Ws - (self.Schveller_Ram.b - (self.NASOS.Wide - self.NASOS.Ws) / 2) * 2) / 2
                if (self.Sym_kol_pump == 3):
                    LL_napor = (self.D_out_1 / 2 + 150) * 2 + self.Schveller_Ram.b * 2 + Norm + (self.NASOS.Ws - (self.Schveller_Ram.b - (self.NASOS.Wide - self.NASOS.Ws) / 2) * 2) / 2 + (self.NASOS.Ws - (self.Schveller_Ram.b - (self.NASOS.Wide - self.NASOS.Ws) / 2) * 2) / 2 + t3 + self.Schveller_Ram.b * 2 + (self.NASOS.Ws - (self.Schveller_Ram.b - (self.NASOS.Wide - self.NASOS.Ws) / 2) * 2)
                t_napor = truba10704_L(DICT_Global.get(f"tr_{self.DN_out}_{self.ISPOLNEN_LOGIKI}"), LL_napor)#  #/ напорный коллектор  
                self.Elements.append(t_napor);
           
                self.F = LL_napor + self.f4.B * 2 ####/ габаритный размер напорного коллектора
                #######################################/ расчет напорной ветки Длин труб  и т.д.
                Out_L1 = 0###/ длина патрубка от насоса до концентрич перехода 
                if (self.DN_kon != self.D_out_pump):
                   Out_L1 = 80
                else:
                   Out_L1 = 250### 250 - длина трубы без перехода
                Out_L2 = 0###/ длина патрубка о тперехода до обратного клапана
                if (self.DN_kon != self.D_out_pump):
                    if (self.DN_kon >= 150):
                       Out_L2 = self.DN_kon
                    else:
                       Out_L2 = 150
                    t_napor2 = truba10704_L(DICT_Global.get(f"tr_{self.DN_kon}_{self.ISPOLNEN_LOGIKI}"), Out_L2);
                    if (self.Sym_kol_pump == 2):
                         self.Elements.append(t_napor2)
                         self.Elements.append(t_napor2)
                    else:
                        self.Elements.append(t_napor2)
                        self.Elements.append(t_napor2)
                        self.Elements.append(t_napor2)
                else:
                    Out_L2 = 0
                isp_trub1 = 0;
                if (self.D_out_pump == 125 and self.isp_koncentr == 1):
                     self.isp_trub1 = 1 
                else: 
                    self.isp_trub1 = self.ISPOLNEN_LOGIKI
                t_napor1 = truba10704_L(DICT_Global.get(f"tr_{self.D_out_pump}_{self.isp_trub1}"), Out_L1)##  длина патрубка от насоса до концентрич перехода 
                
                if (self.Sym_kol_pump == 2):
                    self.Elements.append(t_napor1)
                    self.Elements.append(t_napor1)
                else:
                    self.Elements.append(t_napor1)
                    self.Elements.append(t_napor1)
                    self.Elements.append(t_napor1)
                Out_L3 = 0######// длина патрубка между обратным клапаном и затвором
                if (self.DN_kon != self.D_out_pump and self.DN_kon < 125):
                    Out_L3 = self.DN_kon * 2
                else:
                    Out_L3 = 220
                t_napor3 = truba10704_L(DICT_Global.get(f"tr_{self.DN_kon}_{self.ISPOLNEN_LOGIKI}"), Out_L3)##/  длина патрубка между обратным клапаном и затвором
                if (self.Sym_kol_pump == 2):
                    self.Elements.append(t_napor3)
                    self.Elements.append(t_napor3)
                else:
                    self.Elements.append(t_napor3)
                    self.Elements.append(t_napor3)
                    self.Elements.append(t_napor3)

                Out_L4 = 0###// высота патрубка после затвора и до центра напорного коллектора !!!!!!!! внимание , не длина 
                if (self.DN_kon >= 150 + t_napor.D1 / 2):
                   Out_L4 = self.DN_kon
                else:
                   Out_L4 = 150 + t_napor.D1 / 2
                Out_L4_1 = 0###/ длина патрубка после завтвора
                Out_L4_1 = round(Out_L4 - pow(pow(t_napor.D1 / 2, 2) - pow(t_napor3.D1 / 2, 2), 0.5), 0)##### длинна патрубка от затвора до напорн коллектора
                t_napor4 = truba10704_L(DICT_Global.get(f"tr_{self.DN_kon}_{self.ISPOLNEN_LOGIKI}"), Out_L4_1)##/  длина патрубка между обратным клапаном и затвором
                if (self.Sym_kol_pump == 2):
                    self.Elements.append(t_napor4)
                    self.Elements.append(t_napor4)
                else:
                    self.Elements.append(t_napor4)
                    self.Elements.append(t_napor4)
                    self.Elements.append(t_napor4)

                ##################################/ рассчитана длина основных труб , кроме жокея и швеллер рамы (высота не учитывается)
                ###############/ расчет уголка на раме под шкаф
                L_Ugl_Skaf = 0;
                if self.Jok_Pump!=None:
                    Jok = 0 ############ она же Styl_op для МНС
                    Jok = self.NASOS.F + L_NM_1 - self.Schveller_Ram.b - self.NASOS.a - (self.Jok_Pump.B_otv - 2 * (self.Schveller_Ram.b - (self.NASOS.Wide - self.NASOS.Ws) / 2) + self.Schveller_Ram.b * 2) / 2 + Proklad;
                    Jokei_half = 0;
                    Jokei_half = (self.Jok_Pump.B_otv - 2 * (self.Schveller_Ram.b - (self.NASOS.Wide - self.NASOS.Ws) / 2) + self.Schveller_Ram.b * 2) / 2  ########/  
                    L_Ugl_Skaf = Jok + Jokei_half * 2 + self.Schveller_Ram.b ########## длина уголка под раму шкафов с жокеем!!!!!!!!
                else:
                    Jok = 0 ############ она же Styl_op для МНС
                    Jok = self.NASOS.F + L_NM_1 - self.Schveller_Ram.b - self.NASOS.a - (self.Schveller_Ram.b * 2) / 2 + Proklad;
                    L_Ugl_Skaf = Jok + self.Schveller_Ram.b * 2 ########## длина уголка под раму шкафов с жокеем!!!!!!!!
                # LU_pod_Skaf = ugolok(Form1.ugolok_COLL[$"{50}_{50}"], L_Ugl_Skaf)# #/ уголок под напорным коллектором 
                # self.Elements.append(LU_pod_Skaf)#self.Elements.append(LU_pod_Skaf);
                #######################################//
                #################################/расчет высоты всасывающего коллектора С 
                self.C = self.Schveller_Ram.h + (self.NASOS.He- Perpad - t_vsas_kray.D1/2-4) + 4+ t_vsas_kray.D1 / 2;#Изменил
                #################################/расчет высоты напорного коллектора коллектора В 
                if (self.Perexod_konc != None):
                    self.B = self.C + Perpad + (self.NASOS.h - self.NASOS.h1) + 3 * Proklad + 30 + self.f5.B * 2 + self.Z2.B + self.C_V.B + Out_L1 + Out_L2 + Out_L3 + Out_L4 + self.Perexod_konc.L ######/ 30 это расстояние от трубы в плоском фланце до зеркала фланца , толщина самих фланцев учитана в длине трубы и 30 мм.
                else:
                    self.B = self.C + Perpad + (self.NASOS.h - self.NASOS.h1) + 3 * Proklad + self.f5.B * 2 + self.Z2.B + self.C_V.B + Out_L1 + Out_L3 + Out_L4 + 30
                self.A=self.L_rama
        if self.NASOS.MARKA_TFlex == "NMM":

                b1_NMM = 0 ##### ширина пролета для NMM
                if (self.NASOS.AB_NMM > (self.NASOS.n1_NMM + 2 * self.Schveller_Ram.b)):
                    if self.NASOS.AB_NMM>self.Tee_.f*2:
                        b1_NMM = self.NASOS.AB_NMM
                    else:
                        b1_NMM= self.Tee_.f*2                        
                else:
                    if self.NASOS.n1_NMM>self.Tee_.f*2:
                        b1_NMM = self.NASOS.n1_NMM
                    else:
                        b1_NMM = self.Tee_.f*2    
                if (self.BAK != "24 х 2"):
                    if (self.Jok_Pump != None):
                        L_mhc_dop = 400
                    else:
                        L_mhc_dop = 0
                else:
                    L_mhc_dop = 0 #####// логика аналогично МНС
                self.L_rama = self.Schveller_Ram.b/2+self.NASOS.F+L_mhc_dop+Proklad+self.Tee_.h+L_patr+L_perex+2*self.f3.B+self.f1.B+self.Z1.B ## длинна рамы для МНС
                 #######//расчет t3               
                Vix_razem = 0
                Vix_razem = self.L_rama + 250 + self.LU_podst / 2########/ 250 - ширина шкафа
                if (Vix_razem > 2300):
                   t3 = 400
                else:
                   t3 = 250
                ################# конец расчета t3

                Sh_shirina = Schveller_L(self.Schveller_Ram, self.L_rama - 2 * self.Schveller_Ram.b)###/ длина швеллера вдоль насосов
                if (self.Sym_kol_pump == 2):
                    for i in range(4):
                        self.Elements.append(Sh_shirina)
                else:
                    for i in range(6):
                        self.Elements.append(Sh_shirina)
                L_ram_dlin = 0
                if (self.Sym_kol_pump == 2):
                   L_ram_dlin = b1_NMM * 2 + Norm + self.Schveller_Ram.b * 4
                else:
                   L_ram_dlin = b1_NMM * 3 + Norm + self.Schveller_Ram.b * 6 + t3
                  
                Sh_dlina = Schveller_L(self.Schveller_Ram, L_ram_dlin)###/ длина швеллера поперек насосов
                self.Elements.append(Sh_dlina)
                self.Elements.append(Sh_dlina)

                if (self.Jok_Pump != None):
                    Sh_jok = Schveller_L(self.Schveller_Ram, Norm)
                    self.Elements.append(Sh_jok)
                    self.Elements.append(Sh_jok)
                if (self.Jok_Pump == None):
                    Sh_jok = Schveller_L(self.Schveller_Ram, Norm)
                    self.Elements.append(Sh_jok)
                L_lap = 0;
                L_lap = self.Schveller_Ram.h + (self.Schveller_Ram.b - self.Schveller_Ram.s);
                Sh_lap = Schveller_L(self.Schveller_Ram, L_lap)
                self.Elements.append(Sh_lap)
                self.Elements.append(Sh_lap)
                self.Elements.append(Sh_lap)
                self.Elements.append(Sh_lap);
                                              

                ###############//расчет ширины всасывающего коллектора D 
                #############//Коллектор 1

                L1_small = 0###/ кототкий патрубок 
                # // Коллектор 1 патрубок маленький 
                if (b1_NMM/2 + self.Schveller_Ram.b - self.Tee_.f < 100):
                   L1_small = 100
                else:
                    L1_small = b1_NMM / 2 + self.Schveller_Ram.b - self.Tee_.f ###/ L_in_1
                L2_big = 0 ## длинный патрубок L_inlet_12           
                L2_big = (b1_NMM / 2 + self.Schveller_Ram.b - self.Tee_.f + Norm / 2 - self.Z1.B / 2 - self.f3.B) * 2 # # длинный патрубок L_inlet_12
                L_Kol1_max = 0 ###/ Длниа мах коллектора L_inlet_12_1
                if (self.Jok_Pump == None):
                    L_Kol1_max = round(L2_big * 0.35, 0)
                else:
                   L_Kol1_max = round(L2_big * 0.5, 0) ###/ Длниа мах коллектора L_inlet_12_1

                ################/Коллектор 2
                L2_Kol2 = 0 ####/ L_inlet_12_2
                L2_Kol2 = L2_big - L_Kol1_max ###/ Длина трубы коллектора у затвора (длина другйо трубы равна L1_small) 
                t_vsas_kray = truba10704_L(DICT_Global.get(f"tr_{self.DN_in}_{self.ISPOLNEN_LOGIKI}"), L1_small)##/ по краям коллекторов 
                if (self.Sym_kol_pump == 2):
                    self.D = 4 * self.f3.B + self.Z1.B + 2 * self.Tee_.A + L_Kol1_max + L1_small * 2 + L2_Kol2# ####// 
                   
                    self.Elements.append(t_vsas_kray);
                    self.Elements.append(t_vsas_kray);
                    t_vsas2 = truba10704_L(DICT_Global.get(f"tr_{self.DN_in}_{self.ISPOLNEN_LOGIKI}"), L_Kol1_max) # #/ 1 коллектор у затвора 
                    self.Elements.append(t_vsas2);
                    t_vsas3 =truba10704_L(DICT_Global.get(f"tr_{self.DN_in}_{self.ISPOLNEN_LOGIKI}"), L2_Kol2)# #/ 2 коллектор у затвора 
                    self.Elements.append(t_vsas3)
                if (self.Sym_kol_pump == 3):
                    L2_K2_small = 0# ##/ Короткий патрубок на 2 коллекторе на 3 насоса
                    L2_K2_small = b1_NMM / 2 + self.Schveller_Ram.b - self.Tee_.f - self.Z1.B / 2 - self.f3.B + t3 / 2####/  L_in_23  ####// не учитывается разъемное или не разъемное соединение t3 
                    #######// на 3 коллекторе так же L_in_23
                    self.D = 6 * self.f3.B + self.Z1.B * 2 + 3 * self.Tee_.A + L1_small * 2 + L_Kol1_max + L2_Kol2 + L2_K2_small * 2;
                    self.Elements.append(t_vsas_kray);
                    self.Elements.append(t_vsas_kray);
                    t_vsas2 = truba10704_L(DICT_Global.get(f"tr_{self.DN_in}_{self.ISPOLNEN_LOGIKI}"), L_Kol1_max)##/ 1 коллектор у затвора 
                    self.Elements.append(t_vsas2);
                    t_vsas3 = truba10704_L(DICT_Global.get(f"tr_{self.DN_in}_{self.ISPOLNEN_LOGIKI}"), L2_Kol2)#  #/ 2 коллектор у затвора 
                    self.Elements.append(t_vsas3);
                    t_vsas4 = truba10704_L(DICT_Global.get(f"tr_{self.DN_in}_{self.ISPOLNEN_LOGIKI}"), L2_K2_small)# #/ 2,3 коллектор у затвора  2 одинаковых патрубка
                    self.Elements.append(t_vsas4);
                #################### Расчет верх коллектора F  ##/ исполнение выходного коллектора  == self.ISPOLNEN_LOGIKI
                LL_napor = 0##// длина напорного коллектора
                if (self.Sym_kol_pump == 2):
                   LL_napor = (self.D_out_1 / 2 + 150) * 2 + self.Schveller_Ram.b * 2 + Norm + b1_NMM / 2 + b1_NMM / 2#}
                if (self.Sym_kol_pump == 3):
                   LL_napor = (self.D_out_1 / 2 + 150) * 2 + self.Schveller_Ram.b * 2 + Norm + b1_NMM / 2 + b1_NMM / 2 + b1_NMM + t3 + self.Schveller_Ram.b * 2#}
                t_napor = truba10704_L(DICT_Global.get(f"tr_{self.DN_out}_{self.ISPOLNEN_LOGIKI}"), LL_napor)# #/ напорный коллектор  
                self.Elements.append(t_napor);
                self.F = LL_napor + self.f4.B * 2####/ габаритный размер напорного коллектора
                ######################################/ расчет напорной ветки Длин труб  и т.д.
                Out_L1 = 0###// длина патрубка от насоса до концентрич перехода 
                if (self.DN_kon != self.D_out_pump):
                   Out_L1 = 80#} 
                else:
                     Out_L1 = 250#} ## 250 - длина трубы без перехода
                Out_L2 = 0###/ длина патрубка о тперехода до обратного клапана
                if (self.DN_kon != self.D_out_pump):
                    if (self.DN_kon >= 150):
                       Out_L2 = self.DN_kon#}
                    else:
                       Out_L2 = 150#}
                    t_napor2 = truba10704_L(DICT_Global.get(f"tr_{self.DN_kon}_{self.ISPOLNEN_LOGIKI}"), Out_L2);
                    if (self.Sym_kol_pump == 2):
                       self.Elements.append(t_napor2)
                       self.Elements.append(t_napor2)
                    else:
                        self.Elements.append(t_napor2)
                        self.Elements.append(t_napor2)
                        self.Elements.append(t_napor2)
                else:
                    Out_L2 = 0#}
                isp_trub1 = 0
                if (self.D_out_pump == 125 and self.isp_koncentr == 1):
                   isp_trub1 = 1
                else:
                   isp_trub1 = self.ISPOLNEN_LOGIKI#}
                t_napor1 = truba10704_L(DICT_Global.get(f"tr_{self.D_out_pump}_{isp_trub1}"), Out_L1)# #/  длина патрубка от насоса до концентрич перехода 

                if (self.Sym_kol_pump == 2):
                    self.Elements.append(t_napor1)
                    self.Elements.append(t_napor1)
                else:
                    self.Elements.append(t_napor1)
                    self.Elements.append(t_napor1)
                    self.Elements.append(t_napor1)#}
                Out_L3 = 0######// длина патрубка между обратным клапаном и затвором
                if (self.DN_kon != self.D_out_pump and self.DN_kon < 125):
                    Out_L3 = self.DN_kon * 2
                else:
                    Out_L3 = 220#}
                t_napor3 = truba10704_L(DICT_Global.get(f"tr_{self.DN_kon_trub}_{self.ISPOLNEN_LOGIKI}"), Out_L3)# #/  длина патрубка между обратным клапаном и затвором
                if (self.Sym_kol_pump == 2):
                   self.Elements.append(t_napor3)
                   self.Elements.append(t_napor3)
                else:
                    self.Elements.append(t_napor3)
                    self.Elements.append(t_napor3)
                    self.Elements.append(t_napor3)#}
                Out_L4 = 0###// высота патрубка после затвора и до центра напорного коллектора !!!!!!!! внимание , не длина 
                if (self.DN_kon >= 150 + t_napor.D1 / 2):
                   Out_L4 = self.DN_kon#} 
                else:
                   Out_L4 = 150 + t_napor.D1 / 2#}
                Out_L4_1 = 0;##/ длина патрубка после завтвора
                Out_L4_1 = round(Out_L4 - pow(pow(t_napor.D1 / 2, 2) - pow(t_napor3.D1 / 2, 2), 0.5), 0)##### длинна патрубка от затвора до напорн коллектора
                t_napor4 = truba10704_L(DICT_Global.get(f"tr_{self.DN_kon_trub}_{self.ISPOLNEN_LOGIKI}"), Out_L4_1)# #/  длина патрубка между обратным клапаном и затвором
                if (self.Sym_kol_pump == 2):
                   self.Elements.append(t_napor4)
                   self.Elements.append(t_napor4)
                else:
                    self.Elements.append(t_napor4)
                    self.Elements.append(t_napor4)
                    self.Elements.append(t_napor4)#}

                #################################/ рассчитана длина основных труб , кроме жокея и швеллер рамы (высота не учитывается)
                ##############/ расчет уголка на раме под шкаф
                L_Ugl_Skaf = 0;
                if (self.Jok_Pump != None):
                    Jok = 0############ она же Styl_op для МНС
                    Jok = self.L_rama - 2 * self.Schveller_Ram.b - (self.Tee_.h + L_patr + 2 * self.f3.B + L_perex + self.f1.B + self.Z1.B) + self.Schveller_Ram.b / 2 - self.NASOS.a - (self.Jok_Pump.B_otv - 2 * (self.Schveller_Ram.b - 20) + self.Schveller_Ram.b * 2) / 2#                                                           
                    Jokei_half = 0;
                    Jokei_half = (self.Jok_Pump.B_otv - 2 * (self.Schveller_Ram.b - 20) + self.Schveller_Ram.b * 2) / 2########//  
                    L_Ugl_Skaf = Jok + Jokei_half * 2 + self.Schveller_Ram.b;######### длина уголка под раму шкафов с жокеем!!!!!!!!
                else:
                    Jok = 0############ она же Styl_op для МНС
                    Jok = self.L_rama - 2 * self.Schveller_Ram.b  - (self.Tee_.h + L_patr + 2 * self.f3.B + L_perex + self.f1.B + self.Z1.B) + self.Schveller_Ram.b / 2 - self.NASOS.a - (self.Schveller_Ram.b * 2) / 2;
                    L_Ugl_Skaf = Jok + self.Schveller_Ram.b * 2;######### длина уголка под раму шкафов с жокеем!!!!!!!!
#                ugolok LU_pod_Skaf = new ugolok(Form1.ugolok_COLL[$"{50}_{50}"], L_Ugl_Skaf)# #/ уголок под напорным коллектором 
                #self.Elements.append(LU_pod_Skaf)#self.Elements.append(LU_pod_Skaf);

                ############################## прописать логику  подбора швеллера под насос и его положение (вертикал , горизонтал) !!!!!!!!!!!!!!!!!!!!
                                                
                L_podNasos = 0;
                L_podDvig = 0;

                Z_NMM_Vertikalno = 0;
                Z_NMM_Gorizontalno = 0;
                Z_NMM_Vertikalno_1 = 0;
                Z_NMM =0;
                H_NMM = 0;
                Visota_otosi_NMM = 0;
                
                H_NMM_Gorizontalno = 0;
                H_NMM_Vertikalno = 0;
                H_NMM_Vertikalno_1 = 0;
                NMM_variant = 0;
                ##########/ швеллер мотор равен швеллеру рамы

                Z_NMM_Vertikalno = self.Schveller_Ram.h * 2# #####/ швеллер рамы и под двигателем
                Z_NMM_Gorizontalno = self.Schveller_Ram.b + self.Schveller_Ram.h####### рама и подл двивглом

                H_NMM_Vertikalno = self.NASOS.h1 - Perpad - t_vsas_kray.D1 / 2 - 4 + Z_NMM_Vertikalno - self.Schveller_Ram.h - (self.NASOS.h1 - self.NASOS.m_H);
                H_NMM_Gorizontalno = self.NASOS.h1 - Perpad - t_vsas_kray.D1 / 2 - 4 + Z_NMM_Gorizontalno - self.Schveller_Ram.h - (self.NASOS.h1 - self.NASOS.m_H);
                #NMM_variant = H_NMM_Vertikalno + 4 + Perexod_eks.D_in / 2 - f3.A / 2#                                       

                if (self.Perexod_eks != None):
                   NMM_variant = H_NMM_Vertikalno + 4 + self.Perexod_eks.D_in / 2 - self.f3.A / 2
                else:
                   NMM_variant = H_NMM_Vertikalno + 4 + t_vsas_kray.D1 / 2 - self.f3.A / 2#} ####// расчет для МНС

                if (NMM_variant <= 0):
                    Visota_otosi_NMM = self.Schveller_Ram.h - NMM_variant
                else:
                    Visota_otosi_NMM = self.Schveller_Ram.h + NMM_variant#} #######// расчет высоты для двигла 

                #var Sled_SCHvel_dvig = Form1.Schveller_COLL.Values.Where(s => s.h > Visota_otosi_NMM).OrderBy(s => s.h).FirstOrDefault()##########/ следующий швеллер под двигло NMM $Sled_SCHvel
                 #///////////////////////////////////////////////////////////////////////////поиск швеллера     
                filtered = [s for s in DICT_Scveller.values() if s.h > Visota_otosi_NMM]
                if filtered:
                    filtered_sorted = sorted(filtered, key=lambda x: x.h)
                    self.Sled_SCHvel_dvig = filtered_sorted[0]
                else:
                    self.Sled_SCHvel_dvig = None



                # Sled_SCHvel_dvig=self.Schveller_Ram
                Z_NMM_Vertikalno_1 = self.Sled_SCHvel_dvig.h + self.Schveller_Ram.h;
                H_NMM_Vertikalno_1 = self.NASOS.h1 - Perpad - t_vsas_kray.D1 / 2 - 4 + Z_NMM_Vertikalno_1 - self.Schveller_Ram.h - (self.NASOS.h1 - self.NASOS.m_H);

                if (H_NMM_Gorizontalno<=60 and NMM_variant>=15):
                   H_NMM = H_NMM_Vertikalno#}
                elif(NMM_variant < 15):
                   H_NMM = H_NMM_Vertikalno_1#}
                elif (self.NASOS.Power<37):
                   H_NMM = H_NMM_Vertikalno#}
                else:
                    H_NMM = H_NMM_Gorizontalno#}

                if (self.NASOS.h1 - self.NASOS.h1_dvig == 0):
                   L_podNasos = b1_NMM + self.Schveller_Ram.b * 2
                else:
                    L_podNasos = b1_NMM#}
                L_podDvig = b1_NMM + self.Schveller_Ram.b * 2;
                if (H_NMM==H_NMM_Vertikalno_1):
                    Sh_dvigl = Schveller_L(self.Schveller_Ram, L_podDvig);########//швеллер под двигло
                    #Sh_dvigl = Schveller_L(self.Sled_SCHvel_dvig, L_podDvig);########//швеллер под двигло
                    if (self.Sym_kol_pump == 2):
                        for i in range(4):
                           #self.Elements.append(Sh_nasos);
                            self.Elements.append(Sh_dvigl);
                    else:
                        for i in range(6):
                           #self.Elements.append(Sh_nasos);
                            self.Elements.append(Sh_dvigl);
                        Sh_mg_nasos =Schveller_L(self.Schveller_Ram, t3)###/ длина швеллера между 2 и 3 насосом
                        self.Elements.append(Sh_mg_nasos);     
                else:
                    Sh_dvigl = Schveller_L(self.Schveller_Ram, L_podDvig)#########//швеллер под двигло 

                    if (self.Sym_kol_pump == 2):
                        for i in range(4):
                            #//self.Elements.append(Sh_nasos);
                            self.Elements.append(Sh_dvigl)

                    else:
                        for i in range(6):
                           #// self.Elements.append(Sh_nasos);
                            self.Elements.append(Sh_dvigl);
                        Sh_mg_nasos = Schveller_L(self.Schveller_Ram, t3)###/ длина швеллера между 2 и 3 насосом
                        self.Elements.append(Sh_mg_nasos)

                #############// расчет вшеллеров под насос NMM
                # Schveller Sled_SCHvel_NMM_1;
                # Schveller Sled_SCHvel_NMM_gorizont;
                # Schveller Sled_SCHvel_NMM;
                Visot_otosi_NMM = self.Schveller_Ram.h - (self.NASOS.h1 - self.NASOS.m_H);#########/
                if self.NASOS.h1 - self.NASOS.m_H==0:
                   Sled_SCHvel_NMM = self.Schveller_Ram#} 
                else:
                   filtered = [s for s in DICT_Scveller.values() if s.h > Visot_otosi_NMM]
                   if filtered:
                       filtered_sorted = sorted(filtered, key=lambda x: x.h)
                       self.Sled_SCHvel_NMM = filtered_sorted[0]
                   else:
                       self.Sled_SCHvel_NMM = None
                      #Sled_SCHvel_NMM = Form1.Schveller_COLL.Values.Where(s => s.h > Visot_otosi_NMM).OrderBy(s => s.h).FirstOrDefault()#}#########/ следующий швеллер под насос NMM $Sled_SCHvel_NMM
                                       

                Visot_otosi_NMM_1 = self.Sled_SCHvel_dvig.h - (self.NASOS.h1 - self.NASOS.m_H);#########/
                if self.NASOS.h1 - self.NASOS.m_H == 0:
                   Sled_SCHvel_NMM_1 = self.Sled_SCHvel_dvig#}
                else:
                     filtered = [s for s in DICT_Scveller.values() if s.h > Visot_otosi_NMM_1]
                     if filtered:
                         filtered_sorted = sorted(filtered, key=lambda x: x.h)
                         self.Sled_SCHvel_NMM_1 = filtered_sorted[0]
                     else:
                         self.Sled_SCHvel_NMM_1 = None

                   # Sled_SCHvel_NMM_1 = Form1.Schveller_COLL.Values.Where(s => s.h > Visot_otosi_NMM_1).OrderBy(s => s.h).FirstOrDefault()#}#########/ следующий швеллер под насос NMM $Sled_SCHvel_NMM_1

                Visot_otosi_NMM_goriz = self.Schveller_Ram.b - (self.NASOS.h1 - self.NASOS.m_H);#########/
                if self.NASOS.h1 - self.NASOS.m_H == 0:
                   Sled_SCHvel_NMM_gorizont = self.Schveller_Ram#}
                else:
                    filtered = [s for s in DICT_Scveller.values() if s.h > Visot_otosi_NMM_goriz]
                    if filtered:
                         filtered_sorted = sorted(filtered, key=lambda x: x.h)
                         self.Sled_SCHvel_NMM_gorizont = filtered_sorted[0]
                    else:
                         self.Sled_SCHvel_NMM_gorizont = None
                    
                    
                    #{ Sled_SCHvel_NMM_gorizont = Form1.Schveller_COLL.Values.Where(s => s.h > Visot_otosi_NMM_goriz).OrderBy(s => s.h).FirstOrDefault()#}#########/ следующий швеллер под насос NMM $Sled_SCHvel_NMM_gorizont

                ###############/

                if H_NMM==H_NMM_Vertikalno_1:
                    Sh_nasos = Schveller_L(self.Schveller_Ram, L_podNasos);########//швеллер под двигло 
                    #Sh_nasos = Schveller_L(self.Sled_SCHvel_NMM_1, L_podNasos);########//швеллер под двигло 
                    #Schveller Sh_nasos = new Schveller(Form1.Schveller_COLL[$"{Sled_SCHvel_NMM_1.Name}"], L_podNasos);
                    if self.Sym_kol_pump == 2:
                        for i in range(4):
                            self.Elements.append(Sh_nasos)                        
                    # {
                    #     for (int i = 0#i < 4#i++)
                    #     {
                    #         self.Elements.append(Sh_nasos);
                    #     }
                    # }
                    else:
                        for i in range(6):
                            self.Elements.append(Sh_nasos)  
                        
                #     {
                #         for (int i = 0#i < 6#i++)
                #         {
                #             self.Elements.append(Sh_nasos);
                #         }
                #     }
                # } ########// будет меняться номер швеллера !!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                elif H_NMM==H_NMM_Gorizontalno:
                    #Sh_nasos = Schveller_L(self.Sled_SCHvel_NMM_gorizont, L_podNasos);########//швеллер под двигло 
                    Sh_nasos = Schveller_L(self.Schveller_Ram, L_podNasos);########//швеллер под двигло 
                    #{ Schveller Sh_nasos = new Schveller(Form1.Schveller_COLL[$"{Sled_SCHvel_NMM_gorizont.Name}"], L_podNasos);
                    if self.Sym_kol_pump == 2:
                        for i in range(4):
                            self.Elements.append(Sh_nasos)  
                    # {
                    #     for (int i = 0#i < 4#i++)
                    #     {
                    #         self.Elements.append(Sh_nasos);
                    #     }
                    # }
                    else:
                        for i in range(6):
                            self.Elements.append(Sh_nasos)  
                #     {
                #         for (int i = 0#i < 6#i++)
                #         {
                #             self.Elements.append(Sh_nasos);
                #         }

                #     }
                # } ########// будет меняться номер швеллера !!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                else:                 
                     Sh_nasos = Schveller_L(self.Schveller_Ram, L_podNasos);########//швеллер под двигло 
                     #Sh_nasos = Schveller_L(self.Sled_SCHvel_NMM, L_podNasos);########//швеллер под двигло
                     #{ Schveller Sh_nasos = new Schveller(Form1.Schveller_COLL[$"{Sled_SCHvel_NMM.Name}"], L_podNasos);
                     if self.Sym_kol_pump == 2:
                         for i in range(4):
                              self.Elements.append(Sh_nasos)  
                #     {
                    # {
                    #     for (int i = 0#i < 4#i++)
                    #     {
                    #         self.Elements.append(Sh_nasos);
                    #        // self.Elements.append(Sh_dvigl);
                    #     }
                    # }
                     else:
                         for i in range(6):
                              self.Elements.append(Sh_nasos)  
                #     {
                    
                #     {
                #         for (int i = 0#i < 6#i++)
                #         {
                #             self.Elements.append(Sh_nasos);
                #         }
                #     }
                # } ########// будет меняться номер швеллера !!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                ################################/расчет высоты всасывающего коллектора С 
                self.C = self.Schveller_Ram.h + H_NMM + 4 + t_vsas_kray.D1 / 2#self.LU_pod_Skaf.T
                ################################/расчет высоты напорного коллектора коллектора В 
                if (self.Perexod_konc != None):
                        self.B = self.C + Perpad + (self.NASOS.h - self.NASOS.h1) + 3 * Proklad + 30 + self.f5.B * 2 + self.Z2.B + self.C_V.B + Out_L1 + Out_L2 + Out_L3 + Out_L4 + self.Perexod_konc.L#}#####/ 30 это расстояние от трубы в плоском фланце до зеркала фланца , толщина самих фланцев учитана в длине трубы и 30 мм.
                else:
                        self.B = (self.C + Perpad + (self.NASOS.h - self.NASOS.h1) + 3 * Proklad + self.f5.B * 2 + self.Z2.B + self.C_V.B + Out_L1 + Out_L3 + Out_L4 + 30)
                self.A=self.L_rama



        if (self.NASOS.MARKA_TFlex == "Hydroo"):
               b2 = 0;
               if math.ceil(self.NASOS.Wide / 50) * 50>self.Tee_.f*2:
                    b2 = math.ceil(self.NASOS.Wide / 50) * 50
               else:
                    b2 = self.Tee_.f*2
                                  
               self.L_rama = self.Otvod.R_F+10+  120  +self.NASOS.F+self.Schveller_Ram.b+Proklad+ L_patr + self.Tee_.h+ L_perex + self.Z1.B + self.f1.B + 2 * self.f3.B; # длинна рамы для Hydroo ##// 10 и 120 постоянные величины во флексе

               ######//расчет t3
               L_kran = 0;
               L_troynik = 0;
               if (self.Jok_Pump!=None):
                   if (self.Jok_Pump.DN == 25 or self.Jok_Pump.DN == 32):
                       L_troynik = 35
                   elif (self.Jok_Pump.DN == 40):
                       L_troynik = 46
                   elif (self.Jok_Pump.DN == 50):
                       L_troynik = 52 ######## тройник на обвязке бака 24л

                   if (self.Jok_Pump.DN == 25 or self.Jok_Pump.DN == 32):
                         L_kran = 66
                   elif (self.Jok_Pump.DN == 40):
                        L_kran = 89
                   elif (self.Jok_Pump.DN == 50):
                      L_kran = 101
                     #########// кран на обвязке бака 24л
 
               Vix_razem = 0;
               if (self.BAK == "24 х 2"):
                   Vix_razem = self.L_rama + self.LU_podst / 2 + 150 + 70 + self.DN_out / 2 + L_kran + L_troynik
               else:
                   Vix_razem = self.L_rama + self.LU_podst / 2 + self.DN_kon_trub / 2 + 250
                   #####/ 150 это длина патрубка на баки , 70 это радиус бака 24л.    250 - толщина шкафа
               if (Vix_razem > 2300):
                   t3 = 400
               else:
                  t3 = 250
               ################ конец расчета t3
               
               Sh_shirina = Schveller_L(self.Schveller_Ram, self.L_rama - 2 * self.Schveller_Ram.b);##/ длина швеллера вдоль насосов
               if (self.Sym_kol_pump == 2):
                   for i in range(4):
                       self.Elements.append(Sh_shirina)
               else:
                   for i in range(6):
                       self.Elements.append(Sh_shirina)
               L_ram_dlin = 0;
               if (self.Sym_kol_pump == 2):
                  L_ram_dlin = b2*2+Norm+self.Schveller_Ram.b*4
               else:
                  L_ram_dlin = b2*3+Norm+t3+self.Schveller_Ram.b*6
               Sh_dlina = Schveller_L(self.Schveller_Ram, L_ram_dlin);##/ длина швеллера поперек насосов
               self.Elements.append(Sh_dlina)
               self.Elements.append(Sh_dlina)
               if (self.Jok_Pump != None):
                   Sh_jok = Schveller_L(self.Schveller_Ram, Norm)
                   self.Elements.append(Sh_jok); self.Elements.append(Sh_jok)
               if (self.Jok_Pump == None):
                   Sh_jok = Schveller_L(self.Schveller_Ram, Norm);
                   self.Elements.append(Sh_jok);
               L_lap = 0;
               L_lap = self.Schveller_Ram.h + (self.Schveller_Ram.b - self.Schveller_Ram.s);
               Sh_lap = Schveller_L(self.Schveller_Ram, L_lap);
               self.Elements.append(Sh_lap)
               self.Elements.append(Sh_lap)
               self.Elements.append(Sh_lap)
               self.Elements.append(Sh_lap);

              
               ###############/расчет ширины всасывающего коллектора D 
               #############/Коллектор 1
               ###### ширина пролета                 
               L1_small = 0; #/ кототкий патрубок 
               #// Коллектор 1 патрубок маленький 
               if (b2 / 2 + self.Schveller_Nasos.b - self.Tee_.f < 100):
                  L1_small = 100
               else:
                   L1_small = b2 / 2 + self.Schveller_Nasos.b - self.Tee_.f##/ L_in_1 #########/ хз почему тут во Флексе швеллер насоса , а не рамы
               L2_big = 0; # длинный патрубок L_inlet_12 
               L2_big = (self.Schveller_Ram.b * 2 + Norm + b2 - self.Z1.B - self.f3.B * 2 - self.Tee_.f * 2); # длинный патрубок L_inlet_12            
               L_Kol1_max = 0;##/ Длниа мах коллектора L_inlet_12_1
               if (self.Jok_Pump == None):
                   L_Kol1_max = round(L2_big * 0.35, 0)
               else:
                   L_Kol1_max = round(L2_big * 0.5, 0)##/ Длниа мах коллектора L_inlet_12_1


               ###############/Коллектор 2
               L2_Kol2 = 0;###/ L_inlet_12_2
               L2_Kol2 = L2_big - L_Kol1_max; ##/ Длина трубы коллектора у затвора (длина другйо трубы равна L1_small) 
               t_vsas_kray = truba10704_L(DICT_Global.get(f"tr_{self.DN_in}_{self.ISPOLNEN_LOGIKI}"), L1_small);  #/ по краям коллекторов 
               if (self.Sym_kol_pump == 2):
 
                   self.D = 4 * self.f3.B + self.Z1.B + 2 * self.Tee_.A + L_Kol1_max + L1_small * 2 + L2_Kol2; ####// 
                  
                   self.Elements.append(t_vsas_kray);
                   self.Elements.append(t_vsas_kray);
                   t_vsas2 = truba10704_L(DICT_Global.get(f"tr_{self.DN_in}_{self.ISPOLNEN_LOGIKI}"), L_Kol1_max);  #/ 1 коллектор у затвора 
                   self.Elements.append(t_vsas2);
                   t_vsas3 = truba10704_L(DICT_Global.get(f"tr_{self.DN_in}_{self.ISPOLNEN_LOGIKI}"), L2_Kol2);  #/ 2 коллектор у затвора 
                   self.Elements.append(t_vsas3);


               if (self.Sym_kol_pump == 3):
                   L2_K2_small = 0; ##/ Короткий патрубок на 2 коллекторе на 3 насоса
                   L2_K2_small = (b2+t3+self.Schveller_Ram.b*2-self.Z1.B-self.Tee_.f*2-self.f3.B*2)/2;###/  L_in_23  ####// не учитывается разъемное или не разъемное соединение t3 
                   ######// на 3 коллекторе так же L_in_23
                   self.D = 6 * self.f3.B + self.Z1.B * 2 + 3 * self.Tee_.A + L1_small * 2 + L_Kol1_max + L2_Kol2 + L2_K2_small * 2;
                  #// t_vsas_kray = truba10704_L(DICT_Global.get(f"tr_{self.DN_in}_{self.ISPOLNEN_LOGIKI}"), L1_small);  #/ по краям 1 и 3 коллекторов 
                   self.Elements.append(t_vsas_kray);
                   self.Elements.append(t_vsas_kray);
                   t_vsas2 = truba10704_L(DICT_Global.get(f"tr_{self.DN_in}_{self.ISPOLNEN_LOGIKI}"), L_Kol1_max);  #/ 1 коллектор у затвора 
                   self.Elements.append(t_vsas2);
                   t_vsas3 = truba10704_L(DICT_Global.get(f"tr_{self.DN_in}_{self.ISPOLNEN_LOGIKI}"), L2_Kol2);  #/ 2 коллектор у затвора 
                   self.Elements.append(t_vsas3);
                   t_vsas4 = truba10704_L(DICT_Global.get(f"tr_{self.DN_in}_{self.ISPOLNEN_LOGIKI}"), L2_K2_small);  #/ 2,3 коллектор у затвора  2 одинаковых патрубка
                   self.Elements.append(t_vsas4);
                   self.Elements.append(t_vsas4);
               ################### Расчет верх коллектора F  ##/ исполнение выходного коллектора  == self.ISPOLNEN_LOGIKI
               LL_napor = 0; #// длина напорного коллектора
               if (self.Sym_kol_pump == 2):
                   LL_napor = (self.D_out_1 / 2 + 150) * 2+b2+Norm+self.Schveller_Ram.b*2
               if (self.Sym_kol_pump == 3):
                  LL_napor = (self.D_out_1 / 2 + 150) * 2 + b2 + Norm + self.Schveller_Ram.b * 2+b2+self.Schveller_Ram.b*2+t3
               t_napor = truba10704_L(DICT_Global.get(f"tr_{self.DN_out}_{self.ISPOLNEN_LOGIKI}"), LL_napor);  #/ напорный коллектор  
               self.Elements.append(t_napor);
               self.F = LL_napor + self.f4.B * 2; ###/ габаритный размер напорного коллектора

               ######################################/ расчет напорной ветки Длин труб  и т.д.
               Out_L1 = 0; ##// длина патрубка от насоса до концентрич перехода 
               #if (DN_kon != D_out_pump) { Out_L1 = 120; } else { Out_L1 = 250; } ## 250 - длина трубы без перехода
               Out_L1 = 120;
               Out_L2 = 0; ##/ длина патрубка о тперехода до обратного клапана
               isp_trub1 = 0;
               if (self.D_out_pump == 125 and self.isp_koncentr == 1):
                   isp_trub1 = 1
               else:
                   isp_trub1 = self.ISPOLNEN_LOGIKI
               t_napor1 = truba10704_L(DICT_Global.get(f"tr_{self.D_out_pump}_{isp_trub1}"), Out_L1);  #/  длина патрубка от насоса до концентрич перехода 
               if (self.Sym_kol_pump == 2):
                   self.Elements.append(t_napor1)
                   self.Elements.append(t_napor1)
               else :
                   self.Elements.append(t_napor1)
                   self.Elements.append(t_napor1)
                   self.Elements.append(t_napor1)
                               
               if (self.DN_kon >= 150):
                  Out_L2 = self.DN_kon
               else:
                   Out_L2 = 150;
               t_napor2 = truba10704_L(DICT_Global.get(f"tr_{self.DN_kon}_{self.ISPOLNEN_LOGIKI}"), Out_L2);
               if (self.Sym_kol_pump == 2):
                   self.Elements.append(t_napor2)
                   self.Elements.append(t_napor2)
               else:
                   self.Elements.append(t_napor2)
                   self.Elements.append(t_napor2)
                   self.Elements.append(t_napor2)
                              
               Out_L3 = 0; #####// длина патрубка между обратным клапаном и затвором
               if (self.DN_kon != self.D_out_pump and self.DN_kon < 125):
                   Out_L3 = self.DN_kon * 2
               else:
                   Out_L3 = 220
               t_napor3 = truba10704_L(DICT_Global.get(f"tr_{self.DN_kon_trub}_{self.ISPOLNEN_LOGIKI}"), Out_L3);  #/  длина патрубка между обратным клапаном и затвором
               if (self.Sym_kol_pump == 2):
                   
                   self.Elements.append(t_napor3)
                   self.Elements.append(t_napor3)
               else:
                  self.Elements.append(t_napor3)
                  self.Elements.append(t_napor3)
                  self.Elements.append(t_napor3)

               Out_L4 = 0; ##// высота патрубка после затвора и до центра напорного коллектора !!!!!!!! внимание , не длина 
               if (self.DN_kon >= 150 + t_napor.D1 / 2):
                   Out_L4 = self.DN_kon
               else:
                   Out_L4 = 150 + t_napor.D1 / 2
               Out_L4_1 = 0;##/ длина патрубка после завтвора
               Out_L4_1 = round(Out_L4 - pow(pow(t_napor.D1 / 2, 2) - pow(t_napor3.D1 / 2, 2), 0.5), 0); #### длинна патрубка от затвора до напорн коллектора
               t_napor4 = truba10704_L(DICT_Global.get(f"tr_{self.DN_kon_trub}_{self.ISPOLNEN_LOGIKI}"), Out_L4_1);  #/  длина патрубка между обратным клапаном и затвором
               if (self.Sym_kol_pump == 2):
                   self.Elements.append(t_napor4)
                   self.Elements.append(t_napor4)
               else:
                  self.Elements.append(t_napor4)
                  self.Elements.append(t_napor4)
                  self.Elements.append(t_napor4)

               #################################/ рассчитана длина основных труб , кроме жокея и швеллер рамы (высота не учитывается)
               ##############/ 
               # ugolok LU_norm = new ugolok(Form1.ugolok_COLL[$"{50}_{50}"], Norm);  #/ уголок под опоры стула на вертикальках
               # self.Elements.append(LU_norm);
               #######################расчет уголка на раме под шкаф
               L_Ugl_Skaf = 0;
               indent = 200; ###########// const величина во Флексе
               Ygol = 50; ###########// const величина во Флексе
               if (self.Jok_Pump != None):
                   Styl_op = 0; ########### Hydroo
                   Styl_op =   self.L_rama - self.Schveller_Ram.b*2 + self.Schveller_Ram.b- indent+Ygol; #######// 2 постоянные величины                                   
                                                           
                   L_Ugl_Skaf = Styl_op;######### длина уголка под раму шкафов с жокеем!!!!!!!!
               else:
                   Styl_op = 0; ########### Hydroo
                   Styl_op = self.L_rama - self.Schveller_Ram.b * 2 + self.Schveller_Ram.b - indent + Ygol; #######// 2 постоянные величины                              

                   L_Ugl_Skaf = Styl_op;######### длина уголка под раму шкафов с жокеем!!!!!!!!
               # ugolok LU_pod_Skaf = new ugolok(Form1.ugolok_COLL[$"{50}_{50}"], L_Ugl_Skaf);  #/ уголок под напорным коллектором 
               # self.Elements.append(LU_pod_Skaf); self.Elements.append(LU_pod_Skaf);
               #####################################/

               ############################## прописать логику  подбора швеллера под насос и его положение (вертикал , горизонтал)!!!!!!!!!!!

               He_Hydroo_Gorizontalno = 0;
               He_Hydroo_Vertikalno = 0;
               He_Hydroo_Vertikalno_1 = 0;
               Hydroo_variant = 0;
               Rachet_visoti = self.Schveller_Nasos.h; ########// высота для расчета насоса 
               Visota_otosi_Hydroo = 0;
               He_Hydroo = 0; ############## высота стоек под всасывающим коллектором


               He_Hydroo_Gorizontalno = self.NASOS.h1 - Perpad - t_vsas_kray.D1 / 2 + self.Schveller_Nasos.b - 4; ##########/ горизонтальное расположение 
               He_Hydroo_Vertikalno = self.NASOS.h1 - Perpad - t_vsas_kray.D1 / 2 + self.Schveller_Nasos.h - 4;########### вертикальное расположение

               if (self.Perexod_eks != None):
                   Hydroo_variant = He_Hydroo_Vertikalno + 4 + self.Perexod_eks.D_in / 2 - self.f3.A / 2
               else:
                   Hydroo_variant = He_Hydroo_Vertikalno + 4 + t_vsas_kray.D1 / 2 - self.f3.A / 2 ####// расчет для МНС

               if (Hydroo_variant <= 0):
                   Visota_otosi_Hydroo = Rachet_visoti - Hydroo_variant
               else:
                  Visota_otosi_Hydroo = Rachet_visoti + Hydroo_variant ########// расчет Visota_otosi
               
                 
                  #///////////////////////////////////////////////////////////////////////////поиск швеллера     
               filtered = [s for s in DICT_Scveller.values() if s.h > Visota_otosi_Hydroo]
               if filtered:
                  filtered_sorted = sorted(filtered, key=lambda x: x.h)
                  self.Sled_SCHvel = filtered_sorted[0]
               else:
                  self.Sled_SCHvel = None   

               #Sled_SCHvel = Form1.Schveller_COLL.Values.Where(s => s.h > Visota_otosi_Hydroo).OrderBy(s => s.h).FirstOrDefault(); #########/ следующий швеллер МНС                               
               # Sled_SCHvel=self.Schveller_Nasos

               if (self.Sled_SCHvel != None):
                   He_Hydroo_Vertikalno_1 = self.NASOS.h1 - Perpad - t_vsas_kray.D1 / 2 + self.Sled_SCHvel.h - 4; ##########/ логика подбора следующего швеллера  Sled_SCHvel_Sb1


               if (He_Hydroo_Gorizontalno <= 60 and Hydroo_variant >= 15):
                  He_Hydroo = He_Hydroo_Vertikalno
               elif (Hydroo_variant < 15 and self.Sled_SCHvel != None):
                  He_Hydroo = He_Hydroo_Vertikalno_1
               elif (self.NASOS.Power < 37):
                  He_Hydroo = He_Hydroo_Vertikalno
               else:
                  He_Hydroo = He_Hydroo_Gorizontalno
               if (self.Sled_SCHvel != None):
                   if (He_Hydroo == He_Hydroo_Vertikalno_1):
                       Sled_Schveller_Nasos = self.Sled_SCHvel
                   else:
                        Sled_Schveller_Nasos = self.Schveller_Nasos #следующий швеллер насоса (по логике расчета либо заменяется , либо остается)
               else:
                   Sled_Schveller_Nasos = self.Schveller_Nasos

               L_podNasos = 0;
               L_podNasos = b2 + self.Schveller_Ram.b * 2;
               #Sh_nasos = Schveller_L(Sled_Schveller_Nasos, L_podNasos); #####/ будет меняться номер швеллера !!!!!!!!!!!!!!!!!!!!!!!!!!!!!
               Sh_nasos = Schveller_L(self.Schveller_Ram, L_podNasos); #####/ будет меняться номер швеллера !!!!!!!!!!!!!!!!!!!!!!!!!!!!!
               if (self.Sym_kol_pump == 2):
                   for i in range(4):
                       self.Elements.append(Sh_nasos);
               else:
                   for i in range(6):
                       self.Elements.append(Sh_nasos);
                   Sh_mg_nasos = Schveller_L(self.Schveller_Ram, t3); ##/ длина швеллера между 2 и 3 насосом
                   self.Elements.append(Sh_mg_nasos);

               ################################/расчет высоты всасывающего коллектора С 
               self.C = self.Schveller_Ram.h + He_Hydroo + 4 + t_vsas_kray.D1 / 2;#self.LU_pod_Skaf.T=3
               ########################
               ################################/расчет высоты напорного коллектора коллектора В 
               if (self.Perexod_konc != None):
                   self.B = self.C + Perpad  + 2 * Proklad + 20 + self.f5.B * 2 + self.Z2.B + self.C_V.B + self.Otvod.R_F+ Out_L2 + Out_L3 + Out_L4 + self.Perexod_konc.L#####/ 30 это расстояние от трубы в плоском фланце до зеркала фланца , толщина самих фланцев учитана в длине трубы и 30 мм.
               else:
                  self.B = self.C + Perpad  + 2 * Proklad + self.f5.B * 2 + self.Z2.B + self.C_V.B + self.Otvod.R_F + Out_L2+ Out_L3 + Out_L4 + 20
               ##############################################//
               self.A=self.L_rama


        for e in self.Elements:
            self.Price=self.Price+e.Price
            self.Spisok=self.Spisok+f"{e.Name}_{e.Price}"

def Get_DN(DN_out_pump, DN_out):
    DN = [32, 40, 50, 65, 80, 100, 125, 150, 200, 250, 300, 350, 400, 450, 500]
    DN_ok = []
    
    for DN_ in DN:
        if(DN_>=DN_out_pump and DN_<=DN_out):
            DN_ok.append(DN_)  # Используем метод append вместо add
    
    return DN_ok
        
IMPORT()
        
def Coll_MPNY(Q, H, DN_in, DN_out, ist_h, jok_bool, Q_jok, H_jok, istochik):
    # IMPORT()
    d={}
    N_jok = []
    Q_jok=float(Q_jok)
    if jok_bool:
        for N1 in DICT_Nasos.values():
            N1.Name
            # Проверка диапазона и производителя
            if (N1.Producer=="Hydroo" and Q_jok>min(N1.Q) and max(N1.Q)>Q_jok and N1.Get(Q_jok)>=H_jok) :
                N_jok.append(N1)
    
                
        

    N_jok_sorted = sorted(N_jok, key=lambda x: x.Power)
    H_NPSH=ist_h+10
    
    DICT_MPNY.clear()
    var= [1,2]
    DN = [32, 40, 50, 65, 80, 100, 125, 150, 200, 250, 300, 350, 400, 450, 500]
    for i in var:
        Qn=Q/i
        for N in DICT_Nasos.values():
            if (min(N.Q)<Qn and max(N.Q)>Qn and N.Get_NPSH(Qn)<=H_NPSH and N.DN_in >25 and N.DN_out >25):
                for DN_kon in Get_DN(N.DN_out, DN_out):
                    
                    Pot = H_pot(DN_in,DN_out,DN_kon,N,i,Q)
                    if (N.Get(Qn)-Pot.H_poteri>H):
                        M=MPNY1(N,Pot,DN_in,DN_out,DN_kon,Q,H,i,jok_bool,Q_jok,H_jok,ist_h,istochik)
                        if jok_bool:  # Упрощение проверки на True
                            M.Add(N_jok_sorted[0])
                        DICT_MPNY[f"Кол-во основных насосов: {i}; Модель: {N.Name}"]=M
                        M.Element()
                        M.set_gabarit()
                        #d[f"Кол-во основных насосов: {i} Модель: {N.Name}"]=MPNY_new(M.dict())
                        break
    from operator import attrgetter

    # Сортировка по возрастанию цены (сначала дешевые)
    sorted_items = sorted(
        DICT_MPNY.items(),
        key=lambda item: (
            getattr(getattr(item[1], 'Pump', None), 'Price', 0) == 0,
            getattr(getattr(item[1], 'Pump', None), 'Price', 0)
        )
    )
    
    # 5. Обновление словаря с сохранением порядка
    DICT_MPNY.clear()
    DICT_MPNY.update(OrderedDict(sorted_items))
    for k, v in DICT_MPNY.items():
        d[k]=MPNY_new(v.dict())
    return d



# Coll_MPNY(30, 80, 100, 80, 5, True, 2, 54,"v")
# for M in DICT_MPNY.values():
#           #if "MHC" in M.Name:        
#           if "LCR" in M.Name: 
#             print(M.Name)    
#             for E in M.Elements:
#                 print(E.Name)
#             print(f"A={M.A} B={M.B} C={M.C} D={M.D} F={M.F}")
#             print(f"{M.Pump.Name}")
#             print(f"{M.Name}")
#             print(f"длина насоса{M.Pump.F}")
#             print(f"затвор{M.Z1.B}")
#             print(f"фланец маленький{M.f1.B}")
#             print(f"фланец маленький{M.f3.B}")
#             print(f"длина перехода{M.Perexod_eks.L}")
#             print(f"тройник{M.Tee_.h}")
#             # print(f"{DICT_Global}")
#             break


   