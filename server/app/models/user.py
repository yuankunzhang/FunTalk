# -*- coding: utf-8 -*-
from datetime import datetime

from app.extensions import db


class User(db.Model):

    __tablename__ = 'users'

    id = db.Column(db.Integer, primary_key=True)
    email = db.Column(db.String(120), unique=True, nullable=False)
    first_name = db.Column(db.Unicode(80), nullable=False, default=u'')
    last_name = db.Column(db.Unicode(80), nullable=False, default=u'')
    vote_count = db.Column(db.SmallInteger, default=1)

    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    updated_at = db.Column(db.DateTime, default=datetime.utcnow)

    def __init__(self, *args, **kwargs):
        super(User, self).__init__(*args, **kwargs)

    def __str__(self):
        return self.email

    def __repr__(self):
        return "<User(%s)>" % self
