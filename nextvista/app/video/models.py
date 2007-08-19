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

    def __str__(self):
        return str(self.user)

    class Admin:
        pass

class Language(models.Model):

    code = models.CharField(maxlength=2)

    def __str__(self):
        return self.code

    class Admin:
        pass

class Tag(models.Model):

    name = models.CharField(maxlength=32)
    display_name = models.CharField(maxlength=64)

    @property
    def display(self):
        rv=self.display_name
        if not rv:
            rv=self.name
        return rv

    def __str__(self):
        return self.name

    class Meta:
        ordering = ['name']

    class Admin:
        pass

class Video(models.Model):

    submitter = models.ForeignKey(UserProfile)
    submit_date = models.DateTimeField('date posted')
    language = models.ForeignKey(Language)
    duration = models.IntegerField()
    title = models.CharField(maxlength=128)
    slug = models.SlugField(prepopulate_from=['title'])
    descr = models.TextField()
    long_descr = models.TextField()
    tags = models.ManyToManyField(Tag)

    def __str__(self):
        return self.title

    class Admin:
        pass

class VideoFormat(models.Model):

    name = models.CharField(maxlength=64)
    mime_type = models.CharField(maxlength=32)

    def __str__(self):
        return self.name

    class Admin:
        pass

class VideoVariant(models.Model):

    video = models.ForeignKey(Video)
    format = models.ForeignKey(VideoFormat)
    width = models.IntegerField()
    height = models.IntegerField()
    size = models.IntegerField()

    def __str__(self):
        return format.name + " variant of " + video.name

    class Admin:
        pass

class Rating(models.Model):

    user = models.ForeignKey(UserProfile)
    video = models.ForeignKey(Video)
    value = models.IntegerField()

    def __str__(self):
        return self.user.user.first_name + " " + self.user.user.last_name \
            + " rated " + self.video.title + " as " + str(self.value)

    class Admin:
        pass
