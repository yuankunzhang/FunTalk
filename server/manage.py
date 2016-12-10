# -*- coding: utf-8 -*-
from flask import current_app
from flask_script import Manager, prompt_bool

from app import create_app

manager = Manager(create_app)


@manager.shell
def make_shell_context():
    return dict(app=current_app)


@manager.command
def db_init():
    if not prompt_bool(
            'Caution!!!\nThis will drop the whole database '
            'and re-create it, are you sure? [yn]'):
        return
    pass


@manager.command
def dev_setup():
    """Setup a development environment"""
    pass


if __name__ == '__main__':
    manager.run()
