#!/usr/bin/env python
"""

Copyright (c) 2007  Dustin Sallings <dustin@spy.net>
"""

from nextvista.app.video.models import UserProfile
from django import newforms as forms

def get_country_choices():
    return [('US', 'United States')]

class SignUpForm(forms.Form):

    username = forms.CharField(
        label='username:',
        max_length=30
    )

    first_name = forms.CharField(
        label='first name:',
        max_length=30
    )

    last_name = forms.CharField(
        label='last name:',
        max_length=30
    )

    email = forms.EmailField(
        label='email:'
    )

    password = forms.CharField(
        label='password:',
        max_length=128,
        widget=forms.PasswordInput,
    )

    password2 = forms.CharField(
        label='password (confirm):',
        max_length=128,
        widget=forms.PasswordInput,
    )

    city = forms.CharField(
        label='city:',
        max_length=64
    )

    state = forms.CharField(
        label='state:',
        max_length=64
    )

    country = forms.ChoiceField(
        label='country:',
        choices=get_country_choices(),
    )

    is_teacher = forms.BooleanField(
        label='are you a teacher?',
        required=False,
    )

    descr = forms.CharField(
        label='tell us about yourself:',
        required=False,
        widget=forms.Textarea
    )

    referral = forms.CharField(
        label="how'd you find out about nextvista?",
        required=False,
        widget=forms.Textarea
    )
