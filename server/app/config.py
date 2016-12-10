# -*- coding: utf-8 -*-
import os

_basedir = os.path.abspath(os.path.dirname(__file__))


class Config(object):

    DEBUG = True
    ADMINS = frozenset(['admin@example.com'])
    SECRET_KEY = 'modify this in production'
