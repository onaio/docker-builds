import os
import sys

from django.core.wsgi import get_wsgi_application

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "graphite.settings")
application = get_wsgi_application()

from django.contrib.auth.models import User

username = 'admin'

try:
    User.objects.get(username=username)
except User.DoesNotExist:
    user = User.objects.create(username=username)
    user.set_password(username)
    user.is_super_user = True
    user.is_staff = True
    user.save()
