from django.shortcuts import render_to_response

from django.contrib.auth.models import User
from nextvista.app.video.models import UserProfile, Video, Tag

def show_user(request, username):
    user=User.objects.get(username=username)
    up=UserProfile.objects.get(user__exact=user)
    videos = Video.objects.filter(submitter__exact=up)
    return render_to_response('user.html', {'user': up, 'videos': videos})

def show_tag(request, tag):
    tag=Tag.objects.get(name=tag)
    videos = Video.objects.filter(tags=tag)
    return render_to_response('video/tag.html', {'tag': tag, 'videos': videos})
