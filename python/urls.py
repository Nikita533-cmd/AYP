from django.urls import path
from python import views

from python.models import otv


home_list_otv_view = views.OtvView.as_view(
    queryset= otv.objects.filter(speed=3).filter(n_vetk=1), 
    context_object_name="message_list",
    template_name="python/home.html",
)



urlpatterns = [
    path("", views.ipa , name="home"),
    # path('ajax-handler/', views.ajax_button_handler, name='ajax_handler'),
    path('ajax-handler/', views.ajax_button_handler, name='ajax_handler'),
    path('api/csrf-token/', views.get_csrf_token, name='get_csrf_token'),
    path('generate-pdf/', views.generate_pdf, name='generate_pdf'),
   
]

