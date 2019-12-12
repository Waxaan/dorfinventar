from backend import app
from backend.routes import api

if __name__ == '__main__':
    # register all api routes grouped as blueprint
    app.register_blueprint(api, url_prefix='/api/')
    app.run(debug=True) # For working reloader
    # app.run(debug=True, use_reloader=False)  # For working logging
    # app.run() # Production
