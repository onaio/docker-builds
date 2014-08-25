import os

TIME_ZONE = 'UTC'
DEBUG = True

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql_psycopg2',
        'NAME': os.environ.get('GRAPHITE_DB_NAME', 'graphite'),
        'USER': os.environ.get('GRAPHITE_DB_USER', 'graphite'),
        'PASSWORD': os.environ.get('GRAPHITE_DB_PASSWORD', 'graphite'),
        'HOST': os.environ.get('GRAPHITE_DB_HOST', '127.0.0.1'),
        'PORT': os.environ.get('GRAPHITE_DB_PORT')
    }
}

NOSE_ARGS = ['--stop']
NOSE_PLUGINS = ['mspray.libs.utils.nose_plugins.SilenceSouth']

CACHES = {
    'default': {
        'BACKEND': 'django.core.cache.backends.memcached.MemcachedCache',
        'LOCATION': '127.0.0.1:11211',
    }
}
