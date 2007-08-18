from django.conf.urls.defaults import *

urlpatterns = patterns('',
    # Example:
    # (r'^nextvista/', include('nextvista.apps.foo.urls.foo')),

    # Uncomment this for admin:
    (r'^admin/', include('django.contrib.admin.urls')),
)
