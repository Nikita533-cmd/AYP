# from django.shortcuts import render, redirect
# from django.http import JsonResponse
# from django.views.decorators.csrf import csrf_exempt
# from django.utils.decorators import method_decorator
# import json
# from datetime import datetime
# from management_node.models import ControlUnit
# from tubes.models import TubeType
# from django.http import JsonResponse
# from rest_framework.views import APIView
# # from .solve import JsonBranchesViewer
# # from .Generat_equation import HydraulicParser

# @csrf_exempt
# def solve(request):
#     data = json.loads(request.body)
#     # solveer = HydraulicParser(data).run_fsolve()
#     # print(f"📦 Данные: {solveer}")
#     # print(f"⏰ Время: {datetime.now()}")
#     # # t = JsonBranchesViewer(data).run()
#     return JsonResponse({'data': data}) 


# from .forms import BirthdayForm


# def forms_test(request):
#     if request.method == 'POST':
#         form = BirthdayForm(request.POST)
#         if form.is_valid():  # ← КРИТИЧНО!
#             print("✅ Данные:", form.cleaned_data)
#             return redirect('success')
#         else:
#             print("❌ Ошибки:", form.errors)
#     else:
#         form = BirthdayForm()
    
#     return render(request, 'forms_test.html', {'form': form})

# # class Solve(APIView):
# #     def get(self, request):
# #         # Создаём экземпляр класса формы.
# #         form = BirthdayForm()
# #         # Добавляем его в словарь контекста под ключом form:
# #         context = {'form': form}
# #         # Указываем нужный шаблон и передаём в него словарь контекста.
# #         return render(request, 'forms_test.html', context) 
# from django.template.loader import render_to_string
# from django.shortcuts import render
# from .forms import BranchForm
# from django.http import HttpResponse

# def dynamic_forms(request):
#     branches_forms = []
    
#     if request.method == 'POST':
#         branches_count = int(request.POST.get('branches_count', 3))
        
#         for branch_num in range(1, branches_count + 1):
#             # Создаём форму ветки
#             prefix = f'branch_{branch_num}'
#             branch_form = BranchForm(request.POST, prefix=prefix)
            
#             if branch_form.is_valid():
#                 branches_forms.append(branch_form.cleaned_data)
#                 print(f"✅ Ветка {branch_num}:", branch_form.cleaned_data)
#             else:
#                 branches_forms.append(branch_form)
        
#         # Общая валидация
#         if all(form.is_valid() for form in branches_forms):
#             print("🎉 ВСЕ ветки валидны!")
    
#     else:
#         branches_count = 3
#         for i in range(1, branches_count + 1):
#             branches_forms.append(BranchForm(prefix=f'branch_{i}'))
    
#     context = {
#         'branches_count': branches_count,
#         'branches_forms': branches_forms
#     }
#     return render(request, 'dynamic_forms.html', context)

# def get_forms_ajax(request):
#     count = int(request.GET.get('count', 3))
#     forms_html = ''
    
#     for i in range(1, count + 1):
#         prefix = f'branch_{i}'
#         form = BranchForm(prefix=prefix)
#         forms_html += render_to_string('branch_form.html', {
#             'branch_form': form, 
#             'branch_num': i
#         })
    
#     return HttpResponse(forms_html)

# def dynamic_forms(request):
#     if request.method == 'POST':
#         print(request.POST)
#         form = BranchForm(request.POST)
#         log = form.is_valid()
#         print(log)
#         print("formset:", form.cleaned_data)
#         # Обработка всех данных
#         clean_data = {k: float(v) for k, v in request.POST.items() 
#                      if k.startswith('branch_') and v.strip()}
#         print("✅ Данные:", clean_data)
#         return render(request, 'dynamic_forms.html')
    
#     return render(request, 'dynamic_forms.html', {'form': form})

# def dynamic_forms(request):
#     if request.method == 'POST':
#         print(request.POST)
        
#         # 🔥 FormSet с правильным префиксом 'form'
#         formset1 = SprinklerFormSet(request.POST, prefix='form')
#         formset = BranchForm(request.POST, prefix='form')
#         print("Валиден?", formset.is_valid())
#         if formset.is_valid():
#             # Только заполненные формы!
#             filled_forms = [f.cleaned_data for f in formset if f.cleaned_data]
#             print("✅ Заполненные формы:", filled_forms)
#         else:
#             print("❌ Ошибки:", formset.errors)
        
#         return render(request, 'dynamic_forms.html', {
#             'formset': formset,  # Для показа ошибок
#             'filled_data': filled_forms if formset.is_valid() else []
#         })
    
#     # GET - пустой FormSet
#     formset = SprinklerFormSet(prefix='form')
#     return render(request, 'dynamic_forms.html', {'formset': formset})

from django.shortcuts import render, redirect
from django.http import JsonResponse
from .forms import SprinklerFormSet, SprinklerForm
from django.forms import formset_factory, BaseFormSet
from .forms import formset_factory as fr
from django.core.exceptions import ValidationError

def get_branch_form(request, branch_num):
    """AJAX - возвращает HTML одной ветки"""
    if request.method == 'GET':
        sprinklers_count = int(request.GET.get('count', 2))
        # 🔥 ПРАВИЛЬНО: сначала класс, потом экземпляр!
        FormSetClass = formset_factory(SprinklerForm, extra=sprinklers_count, max_num=20)
        formset = FormSetClass(prefix=f'form')  # prefix для правильных имён
        
        return render(request, 'branch.html', {
            'branch_num': branch_num,
            'formset': formset,
            'sprinklers_count': sprinklers_count
        })
    return JsonResponse({'error': 'Только GET'}, status=405)

def neworms(request):
    print(f"🔍 Метод: {request.method}")
    
    if request.method == 'POST':
        formset = SprinklerFormSet(request.POST, prefix='form')
        
        if formset.is_valid():
            # ✅ ТОЛЬКО при успехе
            filled_forms = [f.cleaned_data for f in formset if f.cleaned_data]
            print(f"✅ {len(filled_forms)} форм успешно!")
            return redirect('success')  # PRG pattern!
        else:
            print("❌ Ошибки:", formset.errors)
            # 🔥 НЕ рендерим страницу - возвращаем ошибку!
            return render(request, 'neworms.html', {
                'formset': formset,  # Показываем ошибки в шаблоне
                'errors': True
            })
    else:
        formset = SprinklerFormSet(prefix='form')
    
    return render(request, 'neworms.html', {'formset': formset})


def index(request):
    if request.method == 'POST':
        form = request.POST['form']
        return render(request, "dynamic_forms.html", {'form': form})

    return render(request, "dynamic_forms.html", {})
# class RequiredFormSet(BaseFormSet):
#     def clean(self):
#         """Проверяет, что хотя бы одна форма заполнена."""
#         if any(self.errors):
#             return
        
#         # Проверка, что хотя бы одна форма не пустая
#         if not any(form.cleaned_data and not form.cleaned_data.get('DELETE', False) for form in self.forms):
#             raise ValidationError("Необходимо заполнить хотя бы одну форму.")

# def get_branch_form(request, branch_num):
#     """AJAX - возвращает HTML одной ветки"""
#     if request.method == 'POST':
#         formset = formset_factory(data=request.POST)
#         formset.clean()
#         print(formset.errors)
#         print(request.POST)
#         print(formset.is_valid())
#     if request.method == 'GET':
#         sprinklers_count = int(request.GET.get('count', 2)) 
#         formset = formset_factory(SprinklerForm, extra=sprinklers_count, max_num=20, formset=RequiredFormSet)
#     return render(request, 'branch.html', {
#         'branch_num': branch_num,
#         'formset': formset,
#         'sprinklers_count': sprinklers_count
#     })

# def dynamic_forms(request):
#     if request.method == 'POST':
#         print(request.POST)
        
#         # 🔥 Правильный FormSet с префиксом 'form'
#         formset = BranchFormSet(request.POST, prefix='form')
        
#         print("Валиден?", formset.is_valid())
#         if formset.is_valid():
#             filled_forms = []
#             for form in formset:
#                 if form.cleaned_data:  # Только заполненные ветки
#                     filled_forms.append(form.cleaned_data)
#                     print(f"✅ Ветка: {form.cleaned_data}")
#             print(f"📊 Всего веток: {len(filled_forms)}")
#         else:
#             print("❌ Ошибки:", formset.errors)
        
#         context = {
#             'formset': formset,
#             'filled_data': filled_forms if formset.is_valid() else []
#         }
#         return render(request, 'dynamic_forms.html', context)
    
#     # GET - пустой FormSet
#     formset = BranchFormSet(prefix='form')
#     return render(request, 'dynamic_forms.html', {'formset': formset})

# def neworms(request):
#     print(f"🔍 Метод: {request.method}")
#     print(f"🔍 POST данные: {dict(request.POST)}")
    
#     if request.method == 'POST':
#         # 🔥 ПЕРВЫЙ аргумент = FORM CLASS!
#         FormSetClass = formset_factory(SprinklerForm, extra=0, max_num=50)
#         formset = FormSetClass(request.POST, prefix='form')  # ВТОРОЙ аргумент = данные
        
#         print(f"✅ Валиден: {formset.is_valid()}")
#         if formset.is_valid():
#             filled_forms = [f.cleaned_data for f in formset if f.cleaned_data]
#             print(f"✅ Заполнено форм: {len(filled_forms)}")
#         else:
#             print(f"❌ Ошибки: {formset.errors}")
            
#     else:  # GET
#         FormSetClass = formset_factory(SprinklerForm, extra=0, max_num=50)
#         formset = FormSetClass(prefix='form')
    
#     return render(request, 'neworms.html', {'formset': formset})