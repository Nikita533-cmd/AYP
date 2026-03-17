# # from django import forms
# # from django.utils.safestring import mark_safe

# # class BirthdayForm(forms.Form):
# #     DN_out = forms.ChoiceField(
# #         label=mark_safe('Выходной диаметр <img src="/static/app/img/vop_ico13.png" title="СП485 п.6.7.1.37" style="cursor:help;width:18px;height:18px;vertical-align:middle;">'),
# #         choices=[
# #             ('25', '25 мм'), ('40', '40 мм'), ('50', '50 мм'), ('65', '65 мм'),
# #             ('80', '80 мм'), ('100', '100 мм'), ('125', '125 мм'), ('150', '150 мм'),
# #         ],
# #         widget=forms.Select(attrs={'class': 'widget'}),
# #         required=True
# #     )
    
# #     L = forms.FloatField(
# #         label=mark_safe('Длина <img src="/static/app/img/vop_ico13.png" title="Введите длину в м" style="cursor:help;width:18px;height:18px;vertical-align:middle;">'),
# #         widget=forms.NumberInput(attrs={'class': 'widget', 'id': 'length_field'}),
# #         min_value=0.1, max_value=3000, required=True
# #     )
    
# #     Z = forms.FloatField(
# #         label=mark_safe('Высота <img src="/static/app/img/vop_ico13.png" title="Введите высотную отметку в м" style="cursor:help;width:18px;height:18px;vertical-align:middle;">'),
# #         widget=forms.NumberInput(attrs={'class': 'widget', 'id': 'height_field'}),
# #         min_value=0.1, max_value=3000, required=True
# #     )

# from django.forms import modelformset_factory, formset_factory
# from django import forms

# # Форма для одного оросителя
# class SprinklerForm(forms.Form):
#     length = forms.FloatField(label='Длина, м', min_value=0.1, required=True)
#     diameter = forms.IntegerField(label='Диаметр, мм', min_value=1, required=True)
#     pressure = forms.FloatField(label='Давление, бар', min_value=0.1, required=True)
#     flow = forms.FloatField(label='Расход, л/ч', required=False)

# # FormSet для оросителей одной ветки
# SprinklerFormSet = formset_factory(SprinklerForm, extra=0, max_num=20, validate_min=True)

# # Форма для ветки (содержит FormSet оросителей)
# class BranchForm(forms.Form):
#     branch_number = forms.IntegerField(widget=forms.HiddenInput())
#     sprinklers_count = forms.IntegerField(min_value=1, max_value=10, widget=forms.HiddenInput())
#     sprinklers = SprinklerFormSet()  # Вложенный FormSet!

# from django import forms
# from django.forms import formset_factory

# class SprinklerForm(forms.Form):
#     length = forms.FloatField(min_value=0.1, required=True, label='Длина, м')
#     diameter = forms.IntegerField(min_value=1, required=True, label='Диаметр, мм')
#     pressure = forms.FloatField(min_value=0.1, required=True, label='Давление, бар')
#     flow = forms.FloatField(required=True, label='Расход, л/ч')

# # FormSet для веток (несколько оросителей)
# SprinklerFormSet = formset_factory(SprinklerForm, extra=2, max_num=50)

# class BranchForm(forms.Form):
#     branch_number = forms.IntegerField(widget=forms.HiddenInput())
#     sprinklers = SprinklerFormSet()  # Вложенный FormSet!

# from django import forms
# from django.forms import formset_factory, BaseFormSet

# class SprinklerForm(forms.Form):
#     length = forms.FloatField(min_value=0.1, required=True, label='Длина, м')
#     diameter = forms.IntegerField(min_value=1, required=True, label='Диаметр, мм')

# SprinklerFormSet = formset_factory(SprinklerForm, extra=2, max_num=50)

# class BaseBranchFormSet(BaseFormSet):
#     def __init__(self, *args, **kwargs):
#         super().__init__(*args, **kwargs)
#         # Добавляем sprinklers FormSet к каждой форме
#         for form in self.forms:
#             form.sprinklers = SprinklerFormSet(
#                 prefix=f'sprinklers-{form.prefix}',
#                 data=form.data if form.is_bound else None
#             )

# # 🔥 BranchFormSet - содержит branch_number + sprinklers
# BranchFormSet = formset_factory(
#     SprinklerForm,  # Одна ветка = несколько оросителей
#     formset=BaseBranchFormSet,
#     extra=1, 
#     max_num=10
# )

from django import forms
from django.forms import formset_factory, BaseFormSet
from django.core.exceptions import ValidationError

class SprinklerForm(forms.Form):
    length = forms.FloatField(min_value=0.1, required=True, label='Длина, м')
    diameter = forms.IntegerField(min_value=1, required=True, label='Диаметр, мм')
    pressure = forms.FloatField(min_value=0.1, required=True, label='Давление, бар')
    flow = forms.FloatField(min_value=0.1, required=True, label='Расход, л/ч')

class BaseSprinklerFormSet(BaseFormSet):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        # 🔥 ВСЕ формы обязательны!
        for form in self.forms:
            form.empty_permitted = False

SprinklerFormSet = formset_factory(
    SprinklerForm,
    formset=BaseSprinklerFormSet,
    extra=0,
    validate_min=True,
    min_num=1
)

# 🔥 ГЛОБАЛЬНЫЙ FormSet
SprinklerFormSet = formset_factory(
    SprinklerForm, 
    formset=BaseSprinklerFormSet,
    extra=0, 
    max_num=50,
    validate_min=True,
    min_num=1
)
