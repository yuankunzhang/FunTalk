# -*- coding: utf-8 -*-
import os

_basedir = os.path.abspath(os.path.dirname(__file__))


class Config(object):

    DEBUG = True
    ADMINS = frozenset(['admin@example.com'])
    SECRET_KEY = 'modify this in production'

    '''
    SQLAlchemy
    '''
    SQLALCHEMY_ECHO = True
    SQLALCHEMY_TRACK_MODIFICATIONS = False
    SQLALCHEMY_DATABASE_URI = 'sqlite:///' + os.path.join(_basedir, 'development.db')