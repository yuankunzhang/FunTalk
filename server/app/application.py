# -*- coding: utf-8 -*-
from flask import Flask

__all__ = ['create_app']

ENABLED_BLUEPRINTS = (
)


def create_app(app_name=None, config=None):
    """
    Create a new Flask application instance, and return it to the caller.
    """
    if not app_name:
        app_name = 'app'

    app = Flask(app_name)

    configure_app(app, config)
    configure_logging(app)
    configure_error_handlers(app)
    configure_event_hooks(app)
    configure_extensions(app)
    configure_blueprints(app, ENABLED_BLUEPRINTS)

    @app.route("/")
    def greet():
        return 'hello!'

    return app


def configure_app(app, config):
    app.config.from_object('app.config.Config')

    if config is not None:
        app.config.from_object(config)

    app.config.from_envvar('APP_CONFIG', silent=True)


def configure_logging(app):
    if app.debug or app.testing:
        return


def configure_error_handlers(app):
    if app.testing:
        return

    @app.errorhandler(401)
    def unauthorized(error):
        return 'Unauthorized'

    @app.errorhandler(403)
    def forbidden(error):
        return 'Forbidden'

    @app.errorhandler(404)
    def page_not_found(error):
        return 'Page Not Found'

    @app.errorhandler(500)
    def server_error(error):
        return 'Internal Server Error'


def configure_event_hooks(app):
    pass


def configure_extensions(app):
    pass


def configure_blueprints(app, blueprints):
    for blueprint, url_prefix in blueprints:
        app.register_blueprint(blueprint, url_prefix=url_prefix)
