#!/usr/bin/env python
from flask import current_app
from flask_script import Manager, prompt_bool

from app import create_app
from app.extensions import db
from app.models import Topic, User, Vote

manager = Manager(create_app)


@manager.shell
def make_shell_context():
    return dict(app=current_app, db=db)


@manager.command
def db_init():
    if not prompt_bool(
            'Caution!!!\nThis will drop the whole database '
            'and re-create it, are you sure? [yn]'):
        return

    db.drop_all()
    db.create_all()


@manager.command
def dev_setup():
    """Setup a development environment"""

    db_init()


@manager.command
def about():
    print 'Models:'
    print ', '.join([
        Topic.__name__,
        User.__name__,
        Vote.__name__,
    ])


if __name__ == '__main__':
    manager.run()
