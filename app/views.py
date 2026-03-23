"""
Definition of views.
"""
from datetime import date
from datetime import datetime
from django.shortcuts import render
from django.http import HttpRequest
from .forms import CommentArticleForm
from django.shortcuts import render, redirect
from .forms import CalculationForm,SP,PumpForm
from .models import MPNY1,NASOS,IMPORT,Coll_MPNY,DICT_MPNY,MPNY_new
import json
from django.http import JsonResponse
from django.contrib.sessions.models import Session
from io import BytesIO
from django.http import FileResponse
from reportlab.pdfgen import canvas
from django.http import HttpResponse
from django.template.loader import get_template
from django.conf import settings
from django.template.loader import render_to_string
from django.conf import settings
# from django.templatetags.static import static
import os
import base64
from io import BytesIO
from django.shortcuts import render
import matplotlib
import numpy as np
matplotlib.use('Agg')  # Должен быть в начале файла (после импортов Django)
from matplotlib import pyplot as plt
from io import BytesIO
from django.utils.encoding import escape_uri_path
from urllib.parse import quote
import base64

from weasyprint import HTML
from weasyprint.text.fonts import FontConfiguration
from django.templatetags.static import static

#from django.contrib.auth.decorators import login_required
#@login_required(login_url='/accounts/login/')
def calculate(request):
    my_dict = {}
    my_list = []
    d={}
    form=None
    form1=None
    form2=None
    result = None  # Инициализируем результат как None
    Q= None
    H = None
    DN_in = None
    DN_out = None
    DN_in_sp = None
    DN_out_sp = None
    key_mpny=None
    sp=None
    selected_pump_data = None
    CALCULATION_CHOICES1 = (
            ('option1', 'V 111'),
            ('option2', 'V 112'),
            ('option3', 'V 113')
            )
    DN_CHOICES1 = []
    CALCULATION_CHOICES = None
   
    
    if request.method == 'POST':
        which_form_is_submiting = request.POST.get('which_form_is_it')
        DN_in_sp = request.POST.get('DN_in_sp', '[]')
        DN_out_sp= request.POST.get('DN_out_sp', '[]')
        DN_in_sp_ = [(str(x), f"DN {x}") for x in json.loads(DN_in_sp)]
        DN_out_sp_ = [(str(x), f"DN {x}") for x in json.loads(DN_out_sp)]

        if which_form_is_submiting == 'form1':
            form = CalculationForm(request.POST, dn_choices_out=DN_out_sp_ ,dn_choices_in=DN_in_sp_)
            if form.is_valid():
                istochik=form.cleaned_data['istochik']
                Q = form.cleaned_data['Q']
                H = form.cleaned_data['H']
                DN_in = form.cleaned_data['DN_in']
                DN_out = form.cleaned_data['DN_out']
                IST_V = form.cleaned_data['IST_V']
                IST_H = form.cleaned_data['IST_H']
                jok_bool = form.cleaned_data['jok_bool']
                H_jok = form.cleaned_data['H_jok']
                Q_jok = form.cleaned_data['Q_jok']
                Pressure_input=0
                if istochik=="v" :
                    Pressure_input=IST_V
                else:
                    Pressure_input=IST_H
                d=Coll_MPNY(Q,H,int(DN_in),int(DN_out),Pressure_input,jok_bool,Q_jok,H_jok, istochik)
                result =  DICT_MPNY.keys()  # Пример вычисленияDICT_MPNY= {}
                my_list = DICT_MPNY.values()
                for key, value in DICT_MPNY.items():
                    my_dict[key] = value
                key_mpny=f"key_{Q}_{H}_{DN_in}_{DN_out}_{Pressure_input}_{jok_bool}_{Q_jok}_{H_jok}_{istochik}"
                Q_gl=float(Q);
                request.session[f'{key_mpny}_Q_gl'] = Q_gl
                H_gl=float(H);
                request.session[f'{key_mpny}_H_gl'] = H_gl
                CALCULATION_CHOICES = [(key, value.Name) for key, value in DICT_MPNY.items()]
                form1=SP(CALCULATION_CHOICES)
                form2 = PumpForm()
                pass
                
        elif which_form_is_submiting == 'form2':
             form2 = PumpForm(request.POST)
             if form2.is_valid():
                pass

    else:
        form = CalculationForm()
        form1=SP(CALCULATION_CHOICES1)
        form2 = PumpForm()
    serializable_d = {key: obj.to_dict() for key, obj in d.items()}
    request.session[f'{key_mpny}_mpny_dict'] = serializable_d
    request.session.modified = True 
    

    # Передаем форму, результат и числа в один шаблон
    return render(request, 'mpnu.html', {
    # return render(request, 'app/form.html', {
        'form': form,
        'form1':form1,
        'form2':form2,
        'result': result,
        'DN_out_sp':DN_out_sp,
        'DN_in_sp':DN_in_sp,
        'key_mpny':key_mpny,
        # 'selected_pump_data': selected_pump_data
       
    
        
    })


def Sort(request):
    key_mpny = request.POST.get('key_mpny')
    
    podbor=request.session.get('podbor')
    serializable_d = request.session.get(f'{key_mpny}_mpny_dict', {})
    my_dict = {key: MPNY_new.from_dict(value) for key, value in serializable_d.items()}
    
    selected={}
    pricesort={}
    powersort={}
    type_sort = request.POST.get('variable')
    

    producer=[]
    Other=request.POST.get('Other')
    Hydroo=request.POST.get('Hydroo')
    CNP=request.POST.get('CNP')
    Lubi=request.POST.get('Lubi')
    MasDaf=request.POST.get('MasDaf')
    if(Other=="true"):
        producer.append("Центральный офис ООО «Торговый Дом АДЛ»")
        producer.append("Wellmix")
        producer.append("aquapolis")
        producer.append("ООО «Элком»")
        producer.append("GRANDFAR")
        producer.append("FANCY")
        producer.append("Heisskraft")
        producer.append("Lubi")
    if(Hydroo=="true"):
        producer.append("Hydroo")
    if(MasDaf=="true"):
        producer.append("Masdaf")
    # if(Lubi=="true"):
#     producer.append("Lubi")
    if(CNP=="true"):
        producer.append("CNP")
    powersort = sorted(
        my_dict.items(),
        key=lambda item: (
            getattr(item[1], 'Power_f', 0)
        )
    )
    powersort_up = sorted(
        my_dict.items(),
        key=lambda item: (
            getattr(item[1], 'Power_f', 0)
        ),
        reverse=True
    )
    # pricesort = sorted(
    #     my_dict.items(),
    #     key=lambda item: (
    #         getattr(getattr(item[1], 'Pump', None), 'Price', 0) == 0,
    #         getattr(getattr(item[1], 'Pump', None), 'Price', 0)
    #     )
    # )
    # pricesort_up = sorted(
    #     my_dict.items(),
    #     key=lambda item: (
    #         getattr(getattr(item[1], 'Pump', None), 'Price', 0) == 0,
    #         getattr(getattr(item[1], 'Pump', None), 'Price', 0)
    #     ),
    #     reverse=True
    # )

    pricesort_up = sorted(
    my_dict.items(),
    key=lambda item: (
        getattr(item[1], 'Nasos_price', 0) == 0,  # True для Nasos_price == 0 — в конец
        getattr(item[1], 'Price', 0)               # сортировка по возрастанию Price
    ),
    reverse=True
)
    pricesort = sorted(
    my_dict.items(),
    key=lambda item: (
        getattr(item[1], 'Nasos_price', 0) == 0,  # True для Nasos_price == 0 — в конец
        getattr(item[1], 'Price', 0)               # сортировка по возрастанию Price
    )

)

    if(type_sort=="power"):
        selected=powersort
    elif(type_sort=="price"):
       selected=pricesort
    elif(type_sort=="price_up"):
       selected=pricesort_up
    elif(type_sort=="power_up"):
       selected=powersort_up
    else:
        return JsonResponse({"error": "Invalid sort type"}, status=400)
    sp={}
    for k,v in selected:
        if v.Nasos_producer in producer:
            sp[k]=k
    return JsonResponse(sp)

def get_data(request):
    
    key_mpny = request.POST.get('key_mpny')
    
    serializable_d = request.session.get(f'{key_mpny}_mpny_dict', {})
    d = {key: MPNY_new.from_dict(value) for key, value in serializable_d.items()}
    Q_gl = request.session.get(f'{key_mpny}_Q_gl')
    if Q_gl is None:
        return JsonResponse({'error': 'Q_gl not found in session'}, status=400)

    my_variable = request.POST.get('variable')
    if not my_variable or my_variable not in d:
        return JsonResponse({'error': 'Invalid or missing variable parameter'}, status=400)

    M = d[my_variable]
    request.session['NAME'] = my_variable;
    Qt = M.Qt
    Ht = M.Ht

    Q = M.Q
    H = M.H
    NPSH = list(M.NPSH)
    Qgl = list(Qt)
    Hgl = list(Ht)
    img=M.img_MPNU
    img_PDF=M.img_MPNU_PDF
    Q_f=Q_gl
    H_f=M.H_f
    Power_f=M.Power_f
    Kol=M.Kol
    DN_in=M.DN_in
    DN_out=M.DN_out
    if M.jok_bool:
        Q_jok=M.Q_jok
        H_jok=M.H_jok
    else:
         Q_jok="-"
         H_jok="-"
    NPSH_F=M.NPSH_F
    Comment = (f"Фактический напор МПНУ")

    return JsonResponse({
        'Q': Q,
        'H': H,
        'Qgl': Qgl,
        'Hgl': Hgl,
        'Comment': Comment,
        'img': img,
        'img_PDF': img_PDF,
        'H_f': H_f,
        'Power_f':Power_f,
        'Kol': Kol,
        'DN_in': DN_in,
        'DN_out': DN_out,
        'Q_f':Q_f,
        'NPSH_F': NPSH_F,
        'Q_jok':Q_jok,
        'H_jok':M.H_jok_f,
        'mass' : M.mass,
        'A': M.A,
        'B': M.B,
        'C': M.C,
        'D': M.D,
        'F': M.F,
        
        
    })

def fetch_resources(uri, rel):
    if uri.startswith(settings.STATIC_URL):
        path = os.path.join(settings.STATIC_ROOT, uri.replace(settings.STATIC_URL, ''))
        return path
    return uri

# import pdfkit
from django.contrib.staticfiles import finders

#config = pdfkit.configuration(wkhtmltopdf='/var/www/u3023438/data/wkhtmltox/bin/wkhtmltopdf')
# config = pdfkit.configuration(wkhtmltopdf=r'C:\Program Files\wkhtmltopdf\bin\wkhtmltopdf.exe')
#config = pdfkit.configuration(wkhtmltopdf='/usr/local/bin/wkhtmltopdf')
def generate_pdf(request):
    
    
        key_mpny = request.GET.get('key_mpny')
        name = request.GET.get('name')
        if not name :
            return JsonResponse({'error': 'Invalid name parameter'}, status=400)
        serializable_d = request.session.get(f'{key_mpny}_mpny_dict', {})
        d = {key: MPNY_new.from_dict(value) for key, value in serializable_d.items()}
        M = d[name]

        # 2. Проверка Q_gl в сессии
        Q_gl = request.session.get(f'{key_mpny}_Q_gl')
        H_gl = request.session.get(f'{key_mpny}_H_gl')
        if Q_gl is None:
            return JsonResponse({'error': 'Q_gl not found'}, status=400)

        # 3. Генерация данных
        Qt = M.Qt
        Ht = M.Ht
        
        coeffs = np.polyfit(M.Q, M.H, 3)  # Получаем коэффициенты кубического полинома
        poly = np.poly1d(coeffs)      # Создаём сам полином
        x_poly = np.linspace(min(M.Q), max(M.Q), 200)
        y_poly = poly(x_poly)
        y_poly_Ch = poly(Q_gl)
        Htt =[y_poly_Ch,y_poly_Ch,0]
        # 4. График характеристики насоса
        plt.figure(figsize=(8, 4))
        plt.plot(x_poly, y_poly, color='#000080', linewidth=2, label='Кривая МПНУ')
        plt.xlabel('Расход, м³/ч')
        plt.ylabel('Напор, м')
        plt.xlim(0, max(M.Q) * 1.1)
        plt.ylim(0, max(M.H) * 1.1)
        plt.grid(True, linestyle='-', linewidth=0.5, color='gray')
        plt.plot(Qt, Htt, linestyle=':', color='red', linewidth=1, label='Точка')
        plt.legend(fontsize='small')
        # plt.title('Характеристика насоса')
        buffer = BytesIO()
        plt.savefig(buffer, format='png', dpi=150, bbox_inches='tight')
        plt.close()
        chart_img_h = f"data:image/png;base64,{base64.b64encode(buffer.getvalue()).decode('utf-8')}"

        # Наименвоание для гидросхемы
        if M.jok_bool:
            jok_nal = 1
        else:
            jok_nal = 0
        if M.istochik=="v" :
            PD_UKU = "P"
            ISTOK ="Водопровод"
        else:
            PD_UKU ="U"
            ISTOK ="Резервуар"
        name_GS=f"GS{M.Kol}_{jok_nal}_{PD_UKU}"




        # 6. Обработка изображения из статики img_gidr
        img_gidr = f'app/img/{name_GS}.png'
        full_img_gidr = finders.find(img_gidr)
        if not full_img_gidr:
            return JsonResponse({'error': f"Static file {img_gidr} not found"}, status=500)
        with open(full_img_gidr, 'rb') as img_file:
            img_data_gidr = img_file.read()
        img_base64_G = base64.b64encode(img_data_gidr).decode('utf-8')
        data_uri_gidr = f"data:image/png;base64,{img_base64_G}"

        print (data_uri_gidr)

         
        # 6. Обработка изображения из статики img_path_K
        img_path_K = 'app/img/kostrul.png'
        full_img_path_K = finders.find(img_path_K)
        if not full_img_path_K:
            return JsonResponse({'error': f"Static file {img_path_K} not found"}, status=500)
        with open(full_img_path_K, 'rb') as img_file:
            img_data_K = img_file.read()
        img_base64_K = base64.b64encode(img_data_K).decode('utf-8')
        data_uri_K = f"data:image/png;base64,{img_base64_K}"
        

        if M.jok_bool and M.Kol==2 and M.Nasos_power<=45: 
             img_SHUN = 'app/img/N1_J_D.png'
        if M.jok_bool==False and M.Kol==2 and M.Nasos_power<=45: 
             img_SHUN = 'app/img/N1_N_D.png'  
        if M.jok_bool and M.Kol==2 and M.Nasos_power>45: 
             img_SHUN = 'app/img/N1_J_S.png'
        if M.jok_bool==False and M.Kol==2 and M.Nasos_power>45: 
             img_SHUN = 'app/img/N1_N_S.png'      
        if M.jok_bool and M.Kol==3 and M.Nasos_power>45 : 
             img_SHUN = 'app/img/N2_J_S.png'   
        if M.jok_bool==False and M.Kol==3 and M.Nasos_power>45 : 
             img_SHUN = 'app/img/N2_N_S.png'   
        if M.jok_bool==False and M.Kol==3 and M.Nasos_power<=45 : 
             img_SHUN = 'app/img/N2_N_D.png' 
        if M.jok_bool and M.Kol==3 and M.Nasos_power<=45 : 
             img_SHUN = 'app/img/N2_J_D.png'      

# if M.jok_bool and M.Sym_kol_pump==2 and M.Power<=45 : 
#     img_SHUN = 'app/img/1 рабочий с жокеем.png'
# if M.jok_bool and M.Sym_kol_pump==2 and M.Power>45 : 
#     img_SHUN = 'app/img/1 рабочий с жокеем.png'
# if M.jok_bool and M.Sym_kol_pump==3 and M.Power<=45 : 
#     img_SHUN = 'app/img/2 рабочих с жокеем.png'    
# if M.jok_bool and M.Sym_kol_pump==3 and M.Power>45 : 
#     img_SHUN = 'app/img/2 рабочих с плавным пуском с жокеем.png'
# if M.jok_bool==False and M.Sym_kol_pump==2 and M.Power<=45 : 
#     img_SHUN = 'app/img/1 рабочий без жокея.png'   
# if M.jok_bool==False and M.Sym_kol_pump==2 and M.Power>45 : 
#     img_SHUN = 'app/img/1 рабочий без жокея.png'  
# if M.jok_bool==False and M.Sym_kol_pump==3 and M.Power<=45 : 
#     img_SHUN = 'app/img/2 рабочих без жокея.png'  
# if M.jok_bool==False and M.Sym_kol_pump==3 and M.Power>45 : 
#     img_SHUN = 'app/img/2 рабочих с плавным пуском без жокея.png'        


        # 6. Обработка изображения из статики img_SHUN
        # img_SHUN = 'app/img/gidr.png'
        full_img_shun = finders.find(img_SHUN)
        if not full_img_shun:
            return JsonResponse({'error': f"Static file {img_SHUN} not found"}, status=500)
        with open(full_img_shun, 'rb') as img_file:
            img_data_shun = img_file.read()
        img_base64_shun = base64.b64encode(img_data_shun).decode('utf-8')
        data_uri_SHUN = f"data:image/png;base64,{img_base64_shun}"


        # 6. Обработка изображения из статики SHUK
        img_shuk = 'app/img/SHUK.png'
        full_img_shuk = finders.find(img_shuk)
        if not full_img_shuk:
            return JsonResponse({'error': f"Static file {img_shuk} not found"}, status=500)
        with open(full_img_shuk, 'rb') as img_file:
            img_data_shuk = img_file.read()
        img_base64_shuk = base64.b64encode(img_data_shuk).decode('utf-8')
        data_uri_shuk = f"data:image/png;base64,{img_base64_shuk}"

        # 6. Обработка изображения из статики SHUK
        img_shuk2 = 'app/img/SHUK2.png'
        full_img_shuk2 = finders.find(img_shuk2)
        if not full_img_shuk2:
            return JsonResponse({'error': f"Static file {img_shuk2} not found"}, status=500)
        with open(full_img_shuk2, 'rb') as img_file:
            img_data_shuk2 = img_file.read()
        img_base64_shuk2 = base64.b64encode(img_data_shuk2).decode('utf-8')
        data_uri_shuk2 = f"data:image/png;base64,{img_base64_shuk2}"

        img_shus = 'app/img/SHUS.png'
        full_img_shus = finders.find(img_shus)
        if not full_img_shus:
            return JsonResponse({'error': f"Static file {img_shus} not found"}, status=500)
        with open(full_img_shus, 'rb') as img_file:
            img_data_shus = img_file.read()
        img_base64_shus = base64.b64encode(img_data_shus).decode('utf-8')
        data_uri_shus = f"data:image/png;base64,{img_base64_shus}"

        
        coeffs2 = np.polyfit(M.Q, M.NPSH, 3)  # Получаем коэффициенты кубического полинома
        poly2 = np.poly1d(coeffs2)      # Создаём сам полином
        x_poly2 = np.linspace(min(M.Q), max(M.Q), 200)
        y_poly2 = poly2(x_poly2)
        y_poly2_CH = poly2(Q_gl)
     
        # 5. График NPSH
        plt.figure(figsize=(8, 4))
        plt.plot(x_poly2, y_poly2, color='#008000', linewidth=2, label='NPSH')
        plt.xlabel('Расход, м³/ч')
        plt.ylabel('NPSH, м')
        plt.xlim(0, max(M.Q) * 1.1)
        plt.ylim(0, max(M.NPSH) * 1.1)
        plt.grid(True, linestyle='-', linewidth=0.5, color='gray')
              
        NPSH_t = [y_poly2_CH, y_poly2_CH, 0]
        

        plt.plot(Qt, NPSH_t, linestyle=':', color='red', linewidth=1, label='Точка')               
                
        plt.legend(fontsize='small')
        # plt.title('NPSH')

        buffer = BytesIO()
        plt.savefig(buffer, format='png', dpi=150, bbox_inches='tight')
        plt.close()
        chart_img_npsh = f"data:image/png;base64,{base64.b64encode(buffer.getvalue()).decode('utf-8')}"
                
        # img_path = finders.find(M.Pump.img2)
        img_path = finders.find(M.img_MPNU_PDF)
                
        img_base64=None
        with open(img_path, 'rb') as img_file:
            img_data = img_file.read()
            img_base64 = base64.b64encode(img_data).decode('utf-8')

        data_uri = f"data:image/png;base64,{img_base64}"
        NPSH_F=M.NPSH_F
        # NPSH_F=round(y_poly2_CH,1)
        NPSH_a=M.NPSH_a

        massa=M.mass
        if M.jok_bool:
            Q_jok=M.Q_jok
            H_jok=M.H_jok
            nal_jok = "-ЖН-"
        else:
             Q_jok="-"
             H_jok="-"
             nal_jok = "-"
        # Name_MPNY = "sdsddssdsd"
        Name_MPNY = f"МПНУ-{str(Q_gl).replace('.',',')}/{str(H_gl).replace('.',',')}.{M.Kol-1}{nal_jok}{str(M.DN_in).replace('.',',')}/{str(M.DN_out).replace('.',',')}"
        # 6. Формирование контекста
        formatted_date = date.today().strftime("%d.%m.%Y")
        context = {
            "Q": list(M.Q),
            'H': list(M.H),
            "Qgl": Q_gl,
            'Hgl': H_gl,
            'Comment': (
                f"Фактический напор МПНУ"
            ),
            'img': data_uri,
            'img_kostrul': data_uri_K,
            'img_gidr' : data_uri_gidr,
            'img_shun' : data_uri_SHUN,
            'img_shuk' : data_uri_shuk,
            'img_shuk2' : data_uri_shuk2,
            'img_shus' : data_uri_shus,
            'H_f': M.H_f,
            'Power_f': M.Power_f,
            'Kol': M.Kol,
            'DN_in': M.DN_in,
            'DN_out': M.DN_out,
            'Q_f': Q_gl,
            'chart_img_h': chart_img_h,
            'chart_img_npsh': chart_img_npsh,
            'NPSH_F': NPSH_F,
            'NPSH_a': NPSH_a,
            'Q_jok':Q_jok,
            'H_jok':M.H_jok_f,
            'mass':massa,
            "A": int(M.A),
            'B': int(M.B),
            'C': int(M.C),
            'D': int(M.D),
            'F': int(M.F),
            'ISTOK' : ISTOK,
            'Name_MPNY':Name_MPNY,
            'data_generate':f"Дата: {formatted_date}",
            'nasos_name' : M.nasos_name,
           
        }

        # 7. Генерация PDF
        #footer_path = os.path.join(settings.BASE_DIR,'app', 'home', 'app', 'home.html')
        #footer_path = os.path.join(settings.STATIC_APP,'app', 'templates', 'app', 'Footer.html')
        # footer_path = '/home/i/itsabijt/test/public_html/HelloDjango/app/templates/app/Footer.html'
        # footer_path_url = 'file:///' + footer_path.replace('\\', '/')


        # html = render_to_string('app/template.html', context)
        # options = {
        #     'encoding': 'UTF-8',
        #     'enable-local-file-access': '',  # Разрешить доступ к локальным файлам            
        #     'margin-bottom': '20mm', # Ключевое добавление
        #     'margin-right': '0',  # Ключевое добавление            
        #     # 'margin-bottom': '25mm',
        #     # 'footer-html': footer_path_url,
        # }
        
        # Генерация PDF в память (без создания файла)
        # pdf = pdfkit.from_string(html, False, configuration=config, options=options)
        # pdf = pdfkit.from_string(html, False, options=options,configuration=config)
        # Отправка PDF
        #filename = f"{Name_MPNY}.pdf"
        #quoted_filename = quote(filename)

        #response = HttpResponse(pdf, content_type='application/pdf') #тест 
        #response['Content-Disposition'] = f"attachment; filename*=UTF-8''{quoted_filename}"
        
        
        
        #response = HttpResponse(pdf, content_type='application/pdf')
        #response['Content-Disposition'] = 'attachment; filename="report.pdf"'
        #return response
        html_string = render_to_string("users/mpnu_pdf.html", context)
        pdf = HTML(string=html_string).write_pdf()
        
        response = HttpResponse(pdf, content_type='application/pdf')
        filename = f"{Name_MPNY}.pdf"
        response['Content-Disposition'] = f'attachment; filename="{escape_uri_path(filename)}"'
        print(response)
        return response







from django.contrib.auth.mixins import LoginRequiredMixin

from django.views.generic import TemplateView
class MyView(LoginRequiredMixin, TemplateView):

    template_name = 'app/login.html'

    login_url = '/accounts/login/'  # URL страницы входа