from django.conf import settings
from django.conf.urls.static import static
from django.contrib import admin
from django.urls import include, path

from .views import sole_api

urlpatterns = [
    path('sole/', sole_api, name='solve'),
]

