from django.conf.urls.defaults import *
from nextvista.app.video.models import Video, Tag
from nextvista import settings

v_info_dict = {
    'queryset': Video.objects.all(),
}

t_info_dict = {
    'queryset': Tag.objects.all(),
}

urlpatterns = patterns('',
    # Example:
    # (r'^nextvista/', include('nextvista.apps.foo.urls.foo')),

    (r'^video/$', 'django.views.generic.list_detail.object_list', v_info_dict),
    (r'^video/(?P<slug>[-\w]+)/$', 'nextvista.app.video.views.show_video'),

    (r'^user/(?P<username>[-\w]+)/$', 'nextvista.app.video.views.show_user'),
    (r'^signup/$', 'nextvista.app.video.views.register'),
    (r'^login/$', 'django.contrib.auth.views.login'),
    (r'^logout/$', 'django.contrib.auth.views.logout'),

    (r'^tag/$', 'django.views.generic.list_detail.object_list', t_info_dict),
    (r'^tag/(?P<tag>[-\+\w]+)/$', 'nextvista.app.video.views.show_tag'),

    (r'^admin/', include('django.contrib.admin.urls')),
    (r'^comments/', include('django.contrib.comments.urls.comments')),
)

# Extra stuff for running in debug mode.
if settings.DEBUG:
    import os
    media_path=os.path.join(os.path.dirname(os.path.abspath(__file__)),
        '../media')
    urlpatterns += patterns('',
        (r'^media/(?P<path>.*)$', 'django.views.static.serve',
            {'document_root': media_path}),)
