from django.conf import settings
from django.conf.urls.static import static
from django.contrib import admin
from django.urls import include, path
from . import  views


from .views import index
from .urls_api import api as api1
# from api.views import forms_test

urlpatterns = [
    path("admin/", admin.site.urls),
    # path("", index),
    path("sprinkler/", include("sprinkler.urls")),
    path('ayp/', views.new_view, name='new'),
    path('editor/', views.editor_view, name='editor'),
    path("api/", api1.urls),
    path("users/", include("users.urls", namespace="users")),
    path('', views.baseaup, name='baseaup'),
    path("ipa/", include("python.urls")),
    path("irrigation/", views.index, name='index'),
    path("test/", include("api.urls")),

]


if settings.DEBUG:
    urlpatterns += static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
    urlpatterns += static("/media/", document_root=settings.MEDIA_ROOT)


admin.site.site_header = "ПО «Спецавтоматика»"
