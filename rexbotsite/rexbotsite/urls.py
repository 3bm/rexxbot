from django.conf.urls import patterns, include, url

from rexbotapp import views

# Uncomment the next two lines to enable the admin:
from django.contrib import admin
admin.autodiscover()

from django.conf import settings

urlpatterns = patterns('',
    # Examples:

    url(r'^static/(?P<path>.*)$', 'django.views.static.serve', {'document_root': settings.STATIC_ROOT}),
    url(r'^$', 'rexbotapp.views.home', name='home'),
    url(r'^charts/', 'rexbotapp.views.charts', name='charts'),
    url(r'^tables/', 'rexbotapp.views.tables', name='tables'),
    
    url(r'^piechart/', 'rexbotapp.views.piechart', name='piechart'),
    url(r'^linechart/', 'rexbotapp.views.linechart', name='linechart'),
    url(r'^simulation/', 'rexbotapp.views.rules_simulation', name='simulation'),
    # url(r'^rexbotsite/', include('rexbotsite.foo.urls')),

    # Uncomment the admin/doc line below to enable admin documentation:
    url(r'^admin/doc/', include('django.contrib.admindocs.urls')),

    # Uncomment the next line to enable the admin:
    url(r'^admin/', include(admin.site.urls)),
)
