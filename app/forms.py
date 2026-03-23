"""
Definition of forms.
"""

from typing import Any, Mapping
from django import forms
from django.contrib.auth.forms import AuthenticationForm
from django.forms.renderers import BaseRenderer
from django.forms.utils import ErrorList
from django.utils.translation import gettext_lazy as _
from django.utils.safestring import mark_safe
from django.core.validators import MaxValueValidator
from django.core.validators import MinValueValidator
class BootstrapAuthenticationForm(AuthenticationForm):
    """Authentication form which uses boostrap CSS."""
    username = forms.CharField(max_length=254,
                               widget=forms.TextInput({
                                   'class': 'form-control',
                                   'placeholder': 'User name'}))
    password = forms.CharField(label=_("Password"),
                               widget=forms.PasswordInput({
                                   'class': 'form-control',
                                   'placeholder':'Password'}))
class CommentArticleForm(forms.Form):
    content = forms.CharField(label='New', max_length=200)
class CalculationForm(forms.Form):                       
    Q= forms.FloatField(label=mark_safe('Расход '' <img src="/static/images/vop_ico13.png" ''title="Введите расход в м³/час" ''style="cursor: help; width:18px; height:18px; vertical-align:middle;">'),widget=forms.NumberInput(attrs={'id': 'Q', 'class':'wiget'}), min_value=0, max_value=3000)
     # Q= forms.FloatField(label=mark_safe('Расход <span title="Введите расход в м³/час" style="cursor: help;">&#65311;</span>'),widget=forms.NumberInput(attrs={'id': 'Q', 'class':'wiget'}), min_value=0, max_value=3000)
    H = forms.FloatField(label=mark_safe('Напор '' <img src="/static/images/vop_ico13.png" ''title="Введите напор в метрах водяного столба" ''style="cursor: help; width:18px; height:18px; vertical-align:middle;">'), widget=forms.NumberInput(attrs={'id': 'H', 'class':'wiget'}) ,min_value=0, max_value=160)
    istochik =forms.ChoiceField(
        label=mark_safe('Источник водоснабжения '' <img src="/static/images/vop_ico13.png" ''title="Выберите источник водоснабжения. Внимание! Для варианта «Резервуар»: если уровень воды в резервуаре выше минимального — используйте знак &quot;-&quot;." ''style="cursor: help; width:18px; height:18px; vertical-align:middle;">'),
        # label=mark_safe('Источник водоснабжения<span  title="Выберите источник водоснабжения. Внимание! Для варианта <Резервуар> если насос выше минимального уровня воды - использовать знак <->" style="cursor: help;">&#65311;</span>'),
        choices=[('r_up', 'Резервуар'),
        # ('r_down', 'Резервуар, ниже оси насоса'),
        ('v', 'Водопровод')],
        widget=forms.Select(attrs={'id': 'istochik', 'name': 'istochik', 'class':'wiget'})
        
    )    
    IST_H= forms.FloatField(label=mark_safe('Расстояние от оси насоса до минимального уровня воды в резервуаре'), widget=forms.NumberInput(attrs={'id': 'IST_H', 'class':'wiget'}),initial=0,required=False)
    IST_V= forms.FloatField(label=mark_safe('Давление (напор)'), widget=forms.NumberInput(attrs={'id': 'IST_V', 'class':'wiget'}),initial=0,required=False)
    
    
    DN_in = forms.ChoiceField(
        label=mark_safe('Входной диаметр '' <img src="/static/images/vop_ico13.png" ''title="Выберите диаметр на входе в МПНУ, список огранчиен в соответствии с СП485. п.6.7.1.37" ''style="cursor: help; width:18px; height:18px; vertical-align:middle;">'),
        choices=[],  # сюда нужно добавить варианты выбора (value, label)
        widget=forms.Select(attrs={'id': 'DN_in', 'name': 'DN_in', 'class':'wiget'})
        
    )
    DN_out = forms.ChoiceField(
        label=mark_safe('Выходной диаметр '' <img src="/static/images/vop_ico13.png" ''title="Выберите диаметр на выходе из МПНУ, список огранчиен в соответствии с СП485. п.6.7.1.37" ''style="cursor: help; width:18px; height:18px; vertical-align:middle;">'),
        choices=[],  # сюда нужно добавить варианты выбора (value, label)
        widget=forms.Select(attrs={'id': 'DN_out', 'name': 'DN_out', 'class':'wiget'})
    )
    DN_out_sp = forms.CharField(widget=forms.HiddenInput(attrs={'id': 'DN_out_sp'}))
    DN_in_sp = forms.CharField(widget=forms.HiddenInput(attrs={'id': 'DN_in_sp'}))
    jok_bool = forms.BooleanField(
    label=mark_safe('Жокей насос '' <img src="/static/images/vop_ico13.png" ''title="Жокей-насос необходим для поддержания давления в системе пожаротушения и обеспечения срабатывания узла управления, который контролирует запуск основных пожарных насосов." ''style="cursor: help; width:18px; height:18px; vertical-align:middle;">'),
    required=False,
    widget=forms.CheckboxInput(attrs={'id': 'jok_bool'})
    
)
    Q_jok= forms.FloatField(label=mark_safe('Расход жокей-насоса'), widget=forms.NumberInput(attrs={'id': 'Q_jok', 'class':'wiget'}),required=False,initial=1.6,min_value=1.6, max_value=30)
    H_jok = forms.FloatField(label='Напор жокей-насоса', widget=forms.NumberInput(attrs={'id': 'H_jok', 'class':'wiget'}),required=False,initial=0,min_value=0, max_value=160)
    def __init__(self, *args, **kwargs):
        dn_choices_in = kwargs.pop('dn_choices_in', [])
        dn_choices_out = kwargs.pop('dn_choices_out', [])
        super().__init__(*args, **kwargs)
        self.fields['DN_in'].choices = dn_choices_in
        self.fields['DN_out'].choices = dn_choices_out
    
class SP(forms.Form):
    def __init__(self, CALCULATION_CHOICES, *args, **kwargs):
        super().__init__(*args, **kwargs)  # Вызов конструктора родительского класса
        self.fields['calculation_type'] = forms.ChoiceField(
            label='Выбор насоса', 
            choices=CALCULATION_CHOICES
        )
class PumpForm(forms.Form):
    pump_name = forms.CharField(label='Название насоса')
from django import forms

from django.contrib.auth.forms import AuthenticationForm

class CustomAuthenticationForm(AuthenticationForm):

    username = forms.CharField(

        label='Имя пользователя',

        max_length=254,

        widget=forms.TextInput(attrs={

            'class': 'form-control',

            'placeholder': 'Введите имя пользователя'

        })

    )

    password = forms.CharField(

        label='Пароль',

        strip=False,

        widget=forms.PasswordInput(attrs={

            'class': 'form-control',

            'placeholder': 'Введите пароль'

        }),

    )

