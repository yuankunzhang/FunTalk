# -*- coding: utf-8 -*-
from datetime import datetime

from app.extensions import db
from .topic import Topic
from .user import User


class Vote(db.Model):

    __tablename__ = 'votes'

    id = db.Column(db.Integer, primary_key=True)
    topic_id = db.Column(db.Integer,
                         db.ForeignKey(Topic.id),
                         nullable=False)
    user_id = db.Column(db.Integer,
                        db.ForeignKey(User.id),
                        nullable=False)
    count = db.Column(db.Integer, default=1)

    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    updated_at = db.Column(db.DateTime, default=datetime.utcnow)

    topic = db.relation(Topic, innerjoin=True, lazy="joined")
    user = db.relation(User, innerjoin=True, lazy="joined")

    def __init__(self, *args, **kwargs):
        super(Vote, self).__init__(*args, **kwargs)
