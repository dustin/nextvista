from django.shortcuts import render_to_response

from django.http import HttpResponseRedirect, HttpResponse
from django.template import RequestContext

from django.contrib.auth import authenticate, login
from django.contrib.auth.models import User

from nextvista.app.video.models import UserProfile, Video, Tag, Rating
from nextvista.app.video import forms
from nextvista import settings

def render_ctx_to_response(request, tmpl, h):
    return render_to_response(tmpl, RequestContext(request, h))

def show_video(request, slug):
    video=Video.objects.get(slug=slug)
    ratings = Rating.objects.filter(video=video)
    avg_rating = 0
    if ratings:
        avg_rating = sum([r.value for r in ratings]) / len(ratings)
    return render_ctx_to_response(request, 'video/display.html',
        {'video': video, 'rating': avg_rating, 'num_ratings': len(ratings)})

def show_user(request, username):
    user=User.objects.get(username=username)
    up=UserProfile.objects.get(user__exact=user)
    videos = Video.objects.filter(submitter__exact=up)
    return render_ctx_to_response(request, 'user.html',
        {'profile': up, 'videos': videos})

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

    return render_ctx_to_response(request, 'video/tag.html',
        {'tag': tag,
        'tags': tags,
        'related': sorted(related.values(), key=lambda x: x.name),
        'videos': sorted(videos.values(), key=lambda x: x.title)})

def register(request):
    created = False
    params = { 'request': request }
    if request.method == 'POST':
        f = forms.SignUpForm(request.POST)
        if f.is_valid():
            data = f.clean_data
            # Do stuff with the form
            user=User()
            user = User.objects.create_user(data['username'],
                data['email'], data['password'])
            user.first_name = data['first_name']
            user.last_name = data['last_name']
            user.save()

            # Profile stuff.
            profile=UserProfile()
            profile.user=user
            profile.city=data['city']
            profile.state=data['state']
            profile.country=data['country']
            profile.is_teacher=data['is_teacher']
            profile.descr=data['descr']
            profile.referral=data['referral']
            profile.save()

            u = authenticate(username=data['username'],
                password=data['password'])
            login(request, u)
            created = True
        else:
            params['errors'] = f.errors
    else:
        f = forms.SignUpForm()
    params['form'] = f
    if f.errors:
        params['errors'] = f.errors
    if created:
        return HttpResponseRedirect(settings.LOGIN_REDIRECT_URL)
    else:
        return render_ctx_to_response(request, 'registration/signup.html',
            params)
