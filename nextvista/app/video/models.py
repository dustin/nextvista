from django.db import models
from django.contrib.auth.models import User

class UserProfile(models.Model):

    # This will eventually be an OpenID URL or something.
    user = models.ForeignKey(User, unique=True)
    city = models.CharField(maxlength=64)
    state = models.CharField(maxlength=2)
    country = models.CharField(maxlength=2)
    is_teacher = models.BooleanField()
    descr = models.TextField()
    referral = models.TextField()

    class Admin:
        pass

class Language(models.Model):

    code = models.CharField(maxlength=2)


class Tag(models.Model):

    name = models.CharField(maxlength=32)

    def __str__(self):
        return self.name

    class Meta:
        ordering = ['name']

    class Admin:
        pass

class Video(models.Model):

    submitter = models.ForeignKey(User)
    submit_date = models.DateTimeField('date posted')
    language = models.ForeignKey(Language)
    duration = models.IntegerField()
    title = models.CharField(maxlength=128)
    slug = models.SlugField(prepopulate_from=['title'])
    descr = models.TextField()
    tags = models.ManyToManyField(Tag)

    class Admin:
        pass
