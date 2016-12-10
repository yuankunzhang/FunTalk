# -*- coding: utf-8 -*-
from datetime import datetime

from app.extensions import db
from .user import User


class Topic(db.Model):

    __tablename__ = 'topics'

    id = db.Column(db.Integer, primary_key=True)
    subject = db.Column(db.Unicode(255), nullable=False)
    description = db.Column(db.UnicodeText, nullable=False)
    tags = db.Column(db.UnicodeText, nullable=True)
    user_id = db.Column(db.Integer,
                        db.ForeignKey(User.id, ondelete='CASCADE'),
                        nullable=False)

    completed = db.Column(db.Boolean, default=False)
    completed_at = db.Column(db.DateTime, nullable=True)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    updated_at = db.Column(db.DateTime, default=datetime.utcnow)

    user = db.relation(User, innerjoin=True, lazy="joined")

    def __init__(self, *args, **kwargs):
        super(Topic, self).__init__(*args, **kwargs)

    def __str__(self):
        return self.subject

    def __repr__(self):
        return "<Topic(%s)>" % self
