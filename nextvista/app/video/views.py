from django.shortcuts import render_to_response

from django.contrib.auth.models import User
from nextvista.app.video.models import UserProfile, Video, Tag, Rating

def show_video(request, slug):
    video=Video.objects.get(slug=slug)
    ratings = Rating.objects.filter(video=video)
    avg_rating = 0
    if ratings:
        avg_rating = sum([r.value for r in ratings]) / len(ratings)
    return render_to_response('video/display.html',
        {'video': video, 'rating': avg_rating, 'num_ratings': len(ratings)})

def show_user(request, username):
    user=User.objects.get(username=username)
    up=UserProfile.objects.get(user__exact=user)
    videos = Video.objects.filter(submitter__exact=up)
    return render_to_response('user.html', {'user': up, 'videos': videos})

def show_tag(request, tag):
    tags=Tag.objects.filter(name__in=tag.split('+'))
    vres = Video.objects.filter(tags__in=tags)
    related = {}
    videos={}
    # Lame.  I need to figureo out how to get a proper intersection.
    for v in vres:
        has_all_tags = True
        vtags = v.tags.all()
        for t in tags:
            if t not in vtags:
                has_all_tags = False
        if has_all_tags:
            videos[v.id] = v
    # Set up the related tags.
    for v in videos.values():
        for t in v.tags.all():
            related[t.name] = t
    for t in tags:
        if t.name in related:
            del related[t.name]

    return render_to_response('video/tag.html',
        {'tag': tag,
        'tags': tags,
        'related': sorted(related.values(), key=lambda x: x.name),
        'videos': sorted(videos.values(), key=lambda x: x.title)})
