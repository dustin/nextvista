from django import template

register = template.Library()

@register.filter()
def listify_tag(iterable, separator=', '):
    tags = []
    for i in iterable:
        tags.append('<a href="/tag/%s/">%s</a>' % (i.name, i.display))
    rv = separator.join(tags)
    return rv
