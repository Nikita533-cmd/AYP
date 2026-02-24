from django import forms

from python.models import otv


class OtvForm(forms.ModelForm):
    class Meta:
        model = otv
        fields = ["distance","speed","n_vetk","n_otv","d1","d2","d3","d4","d5","d6","d7","d8","d9","d10","d11","d12","d13","d14","d15","d16","d17","d18","d19","d20","d21","Max_L_C","Max_L_B","Max_L_A","Max_L2_C","Max_L2_B","Max_L2_A","q_C","q_B","q_A"]   # NOTE: the trailing comma is required
 