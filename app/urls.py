from django.contrib import admin
from django.urls import path
from app import  forms, views
from django.contrib.auth import views as auth_views
from app.forms import CustomAuthenticationForm
# from django.contrib.staticfiles.storage import staticfiles_storage
from django.views.generic.base import RedirectView

urlpatterns = [
    #path('', admin.site.urls),
    path('',  views.calculate, name='calculate'),
    path('get_data/', views.get_data,name='get_data'),
    path('generate_pdf/', views.generate_pdf, name='generate_pdf'),
    # path('generate-pdf/', views.generate_pdf, name='generate_pdf'),
    path('Sort/', views.Sort,name='Sort'),
    # path('favicon.ico', RedirectView.as_view(url=staticfiles_storage.url('favicon.ico'))),
    # path('favicon.svg', RedirectView.as_view(url=staticfiles_storage.url('favicon.svg'))),
    # path('robots.txt', RedirectView.as_view(url=staticfiles_storage.url('robots.txt'))),
    # path('sitemap.xml', RedirectView.as_view(url=staticfiles_storage.url('sitemap.xml'))),
]