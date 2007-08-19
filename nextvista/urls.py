from django.conf.urls.defaults import *
from nextvista.app.video.models import Video

v_info_dict = {
    'queryset': Video.objects.all(),
}

urlpatterns = patterns('',
    # Example:
    # (r'^nextvista/', include('nextvista.apps.foo.urls.foo')),

    (r'^video/$', 'django.views.generic.list_detail.object_list', v_info_dict),
    (r'^video/(?P<slug>[-\w]+)/$',
        'django.views.generic.list_detail.object_detail',
            dict(v_info_dict, slug_field='slug',
            template_name='video/display.html')),

    (r'^user/(?P<username>[-\w]+)/$', 'nextvista.app.video.views.show_user'),

    # Uncomment this for admin:
    (r'^admin/', include('django.contrib.admin.urls')),
)
