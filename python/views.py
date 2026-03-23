import re
from django.shortcuts import render
from django.utils.timezone import datetime
from django.http import HttpResponse
from python import views
from django.shortcuts import redirect

from python.models import otv
from django.views.generic import ListView

from django.http import JsonResponse
from django.views.decorators.csrf import ensure_csrf_cookie, csrf_protect
from django.middleware.csrf import get_token

from django.template.loader import render_to_string
from weasyprint import HTML
from weasyprint.text.fonts import FontConfiguration
from django.core.serializers.json import DjangoJSONEncoder
from django.templatetags.static import static

from django.conf import settings

import json
import os
import base64
from PIL import Image
import io
import math
from datetime import datetime



class OtvView(ListView):
    model = otv

    def get_context_data(self, **kwargs):
        context = super(OtvView, self).get_context_data(**kwargs)
        return context


# def home(request):
#     return render(request, "python/layout.html")


def Ploshad (vetk, qnty, s):
    
    a=6.4**2
    b=(float(s)/2)**2
    h=math.sqrt(a-b)
    ss=h*2*int(vetk)*qnty*s
    
    return ss
        

def ipa(request):
    return render(request, "ipa.html", {})        


def generate_pdf(request):

    if request.method == "POST":
        # Получаем данные из формы или контекста

        # Рендерим HTML шаблон
        html_string = render_to_string("users/ipa_pdf.html")
        pdf = HTML(string=html_string).write_pdf()
        response = HttpResponse(pdf, content_type="application/pdf")
        response["Content-Disposition"] = 'attachment; filename="your_file.pdf"'
        # Создаем PDF
        ##  response = HttpResponse(content_type='application/pdf')
        ##  response['Content-Disposition'] = 'attachment; filename="report.pdf"'

        # Конфигурация шрифтов
        font_config = FontConfiguration()

        # Генерируем PDF
        # HTML(string=html_string, base_url=request.build_absolute_uri()).write_pdf(response,
        #   font_config=font_config)

        return response

    # Если GET запрос, показываем страницу с кнопкой
    return render(request, "generate_pdf.html")


##@ensure_csrf_cookie
##def ajax_form_page(request):
##  """Просто отображает страницу с формой"""
## return render(request, 'python/ajax_form.html')


def get_csrf_token(request):
    """Endpoint для получения CSRF токена"""
    print(get_token(request))
    return JsonResponse({"csrfToken": get_token(request)})
    
def check_static_file_exists(relative_path):
    # Путь для разработки
    dev_path = os.path.join(settings.BASE_DIR, 'python', 'static', relative_path)
    
    # Путь для production (после collectstatic)
    prod_path = os.path.join(settings.STATIC_ROOT, relative_path) if settings.STATIC_ROOT else None
    
    if os.path.exists(dev_path):
        return dev_path
    elif prod_path and os.path.exists(prod_path):
        return prod_path
    else:
        return None    
    
    
@ensure_csrf_cookie
def ajax_button_handler(request):
    """Обрабатывает AJAX запросы"""
    
    v="v1.0" #Версия кода
    db="db1.0" #Версия базы данных
    
    
    if request.method == "POST":
        try:
            data = json.loads(request.body)
            button_name = data.get("button_name", "")
            vers_g = data.get("param1", "")
            h_g = int(data.get("param2", ""))

            vetk_g = int(data.get("param3", ""))
            s_otv_g = float(data.get("param4", ""))
            s_g = int(data.get("param5", ""))
            q_otv_g = int(data.get("param6", ""))
            s_vetk_g = int(data.get("param7", ""))
            n = ["№"]
            i = 1
            while i < (q_otv_g + 1):
                n.append(i)
                i += 1

            last_itemC = list()
            last_itemB = list()
            last_itemA = list()

            c_en = 0
            b_en = 0
            a_en = 0
            ver=0
            
            if vers_g=="ИПАv5":
                ver=5
            if vers_g=="ИПА-Селект":
                ver=4
            
            plosh=Ploshad(vetk_g,q_otv_g,s_otv_g)     
            if h_g > 12:  # класс С
                last_itemC.append(0)
                c_en = 6 #Уменьшите высоту установки труб
            else:    
                querysetС = otv.objects.filter(n_vetk=vetk_g).filter(distance=s_otv_g).filter(vers=ver)
                if q_otv_g > 0:
                    querysetС = querysetС.filter(q_C=q_otv_g)
                    if querysetС.count() == 0:
                        c_en = 2 #Слишком много отверстий
                    else:
                        if s_vetk_g > 0:
                            querysetС = querysetС.filter(Max_L_C__gte=s_vetk_g)
                            
                            if querysetС.count() == 0:
                                c_en = 5 #Слишком большое расстояние до последнего отверстия
                            else:
                                if s_g > 0:
                                    querysetС = querysetС.filter(Max_L2_C__gte=s_g)
                                    if querysetС.count() == 0:
                                        if vetk_g==1:
                                            c_en = 3 #Слишком большое расстояние до первого отверстия
                                        else:
                                            c_en = 4 #Слишком большое расстояние до разветвления
                                    else:
                                        if querysetС.count() == 0:
                                            last_itemC.append(0)
                                        else:
                                            last_itemC.append(list(querysetС.values())[-1])
                                            c_en = 1 #Нашлось
            
                

            if h_g > 18:  # класс B
                last_itemB.append(0)
                b_en = 6 #Уменьшите высоту установки труб
            else:
                querysetB = otv.objects.filter(n_vetk=vetk_g).filter(distance=s_otv_g).filter(vers=ver)
                if q_otv_g > 0:
                    querysetB = querysetB.filter(q_B=q_otv_g)
                    if querysetB.count() == 0:
                        b_en = 2 #Слишком много отверстий
                    else:
                        if s_vetk_g > 0:
                            querysetB = querysetB.filter(Max_L_B__gte=s_vetk_g)
                            if querysetB.count() == 0:
                                b_en = 5 #Слишком большое расстояние до последнего отверстия
                            else:  
                                if s_g > 0:
                                    querysetB = querysetB.filter(Max_L2_B__gte=s_g)
                                    if querysetB.count() == 0:
                                        if vetk_g==1:
                                            b_en = 3 #Слишком большое расстояние до первого отверстия
                                        else:
                                            b_en = 4 #Слишком большое расстояние до разветвления
                                    else:
                                
                                        if querysetB.count() == 0:
                                            last_itemB.append(0)
                                        else:
                                            last_itemB.append(list(querysetB.values())[-1])
                                            b_en = 1
  
            if h_g >30:  # класс A
                last_itemA.append(0)
                a_en = 6 #Уменьшите высоту установки труб
            else:
                querysetA = otv.objects.filter(n_vetk=vetk_g).filter(distance=s_otv_g).filter(vers=ver)
                if q_otv_g > 0:
                    querysetA = querysetA.filter(q_A=q_otv_g)
                    if querysetA.count() == 0:
                        a_en = 2 #Слишком много отверстий
                    else:
                        if s_vetk_g > 0:
                            querysetA = querysetA.filter(Max_L_A__gte=s_vetk_g)
                            if querysetA.count() == 0:
                                a_en = 5 #Слишком большое расстояние до последнего отверстия
                            else:
                                if s_g > 0:
                                    querysetA = querysetA.filter(Max_L2_A__gte=s_g)
                                    if querysetA.count() == 0:
                                        if vetk_g==1:
                                            a_en = 3 #Слишком большое расстояние до первого отверстия
                                        else:
                                            a_en = 4 #Слишком большое расстояние до разветвления
                                    else:
                                        if querysetA.count() == 0:
                                            last_itemA.append(0)
                                        else:
                                            last_itemA.append(list(querysetA.values())[-1])
                                            a_en = 1
            
            
            
            correct_path = os.path.join(settings.BASE_DIR, 'python', 'static', 'python', 'img', 'lbtopdf.png')
            current_datetime = datetime.now()
         
            contxt = {
                "vers": vers_g,
                "h": h_g,
                "q_vetk": vetk_g,
                "s_otv": s_otv_g,
                "s1": s_g,
                "s2": s_vetk_g,
                "q_otv_mas": n,
                "q_otv": q_otv_g,
                "C_enable": c_en,
                "B_enable": b_en,
                "A_enable": a_en,
                "message_list_C": last_itemC,
                "message_list_B": last_itemB,
                "message_list_A": last_itemA,
                "correct_path":correct_path,
                "dt": current_datetime.strftime("%d.%m.%Y"),
                # "dt": current_datetime.strftime("%d.%m.%Y %H:%M:%S"),
                "ploshad": round(plosh, 2),
                "vb":v+db,
            }
            html_string = render_to_string("ipa_resolution.html", contxt)

            if button_name == "submit":

                response_data = {"status": "success", "message": html_string}

            elif button_name == "getpdf":
                html_string = render_to_string("users/ipa_pdf.html", contxt)
                
                pdf = HTML(string=html_string, base_url=request.build_absolute_uri()).write_pdf()
                response = HttpResponse(pdf, content_type="application/pdf")
               # response["Content-Disposition"] = 'attachment; filename="your_file.pdf"'

                return response

            else:
                response_data = {"status": "error", "message": "Неизвестное действие"}

            return JsonResponse(response_data)

        except json.JSONDecodeError:
            return JsonResponse(
                {"status": "error", "message": "Неверный формат данных"}
            )
        except Exception as e:
            return JsonResponse(
                {"status": "error", "message": f"Ошибка сервера: {str(e)}"}
            )

    # Если GET запрос к обработчику - возвращаем ошибку
    return JsonResponse(
        {"status": "error", "message": "Этот endpoint принимает только POST запросы"}
    )
