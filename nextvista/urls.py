from django.conf.urls.defaults import *
from nextvista.app.video.models import Video, Tag

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

    (r'^tag/$', 'django.views.generic.list_detail.object_list', t_info_dict),
    (r'^tag/(?P<tag>[-\+\w]+)/$', 'nextvista.app.video.views.show_tag'),

    # Uncomment this for admin:
    (r'^admin/', include('django.contrib.admin.urls')),
)
