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
    related = {}
    videos=[]
    rv={}
    # Lame.  I need to figureo out how to get a proper intersection.
    for v in vres:
        has_all_tags = True
        vtags = v.tags.all()
        for t in tags:
            if t not in vtags:
                has_all_tags = False
        if has_all_tags:
            rv[v.id] = v
    # Set up the related tags.
    for v in rv.values():
        for t in v.tags.all():
            related[t.name] = t
    for t in tags:
        if t.name in related:
            del related[t.name]
    return render_to_response('video/tag.html',
        {'tag': tag,
        'tags': tags,
        'related': sorted(related.values()),
        'videos': sorted(rv.values())})
