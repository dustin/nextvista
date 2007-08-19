from django.shortcuts import render_to_response

from django.contrib.auth.models import User
from nextvista.app.video.models import UserProfile, Video, Tag

def show_user(request, username):
    user=User.objects.get(username=username)
    up=UserProfile.objects.get(user__exact=user)
    videos = Video.objects.filter(submitter__exact=up)
    return render_to_response('user.html', {'user': up, 'videos': videos})

def show_tag(request, tag):
    tags=Tag.objects.filter(name__in=tag.split('+'))
    vres = Video.objects.filter(tags__in=tags)
    videos=[]
    rv={}
    # Lame.  I need to figureo out how to get a proper intersection.
    for v in vres:
        has_all_tags = True
        for t in tags:
            if t not in v.tags.all():
                has_all_tags = False
        if has_all_tags:
            rv[v.id] = v
    return render_to_response('video/tag.html',
        {'tag': tag, 'tags', tags, 'videos': sorted(rv.values())})
