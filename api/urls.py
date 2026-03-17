from django.conf import settings
from django.conf.urls.static import static
from django.contrib import admin
from django.urls import include, path

# from .views import solve, forms_test

# urlpatterns = [
#     path('sole/', solve, name='solve'),
#     path('forms_test/', forms_test, name='forms_test'),
# ]

from . import views

urlpatterns = [
    path('',views.index),
    path('branch/<int:branch_num>/', views.get_branch_form, name='get_branch'),
    # path('forms-test/', views.dynamic_forms, name='dynamic_forms'),
    path('forms-test1/', views.neworms, name='neworms'),
]