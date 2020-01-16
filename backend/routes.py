import os
import uuid
import pathlib
from passlib.hash import argon2
from datetime import timedelta

from flask import jsonify, request, Blueprint
from backend import app, db
from backend.models import User, Category, Article
from werkzeug.utils import secure_filename
from flask_jwt import JWT, jwt_required, current_identity

# USER AUTHENTIFICATION / LOGIN
# 
# Most ressources are protected and require a JSON Web Token (JWT). Send a POST request to 
# /api/auth/login . As body set username and password as form fields! with the corresponding values
#
# Response:
#
# {
#  "access_token": "long jwt"
# }
#
# Store this token locally. To access protected ressouces, set as the request header field AU
# to "JWT $the_jwt". Replace $the_jwt with the actual JWT. Mind the space between JWT and $the_jwt
def authenticate(username, password):
    json = request.json
    user = User.query.filter(User.username == json.get("username", "")).one_or_none()
    if user and argon2.verify(password, user.password):
        return user
    return None

# returns user object from database by using the user id stored inside the jwt
def identity(payload):
    user_id = payload['identity']
    return User.query.filter(User.id == user_id).one_or_none()

jwt = JWT(app, authenticate, identity)
app.config['SECRET_KEY'] = os.getenv("DORFINV_SECRET")
app.config['JWT_EXPIRATION_DELTA'] = timedelta(days=30)
app.config['JWT_AUTH_URL_RULE'] = "api/auth/login" # url to get jwt token


ALLOWED_EXTENSIONS = set(['txt', 'pdf', 'png', 'jpg', 'jpeg', 'gif'])
def allowed_file(filename):
    return '.' in filename and \
           filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

def error(msg):
    """Helper function to create consistent JSON error messages"""
    return jsonify({"error": msg})

@app.route("/dashboard")
def dashboard():
    return error("Admin template. No data to retrieve"), 400

# The blueprint allows the grouping of multiple request. During registration a prefix for all
# urls can be specified
api = Blueprint("api", __name__)

@api.route("auth/register", methods=["POST"])
def register():
    #if not request.is_json:
     #   return error("Expected data to be JSON encoded"), 400
    
    #data = request.get_json()
    username = request.form.get("username", "").lower() # to normalize usernames
    password = request.form.get("password", "")

    password = argon2.hash(password)
    email    = request.form.get("email", "")

    if not (username and password and email):
        return error("Please set a username, password and email address for the registration"), 400

    if User.query.filter_by(username=username, email=email).first():
        return error(f"An account with username '{username}' or email address '{email}' already exists"), 400

    user = User(username=username, password=password, email=email)
    db.session.add(user)
    db.session.commit()
    return jsonify(user.serialize), 201



@api.route("categories/", methods=["GET"])
def get_categories():
    return jsonify([c.serialize for c in Category.query.all()]), 200

@api.route("articles/", methods=["GET"])
def get_articles():
    query = Article.query
    if request.args['query']:
        query = query.filter(Article.name.ilike("%"+request.args['query']+"%"))
    if request.args['category']:
        query = query.filter(Article.category.ilike(request.args['category']))
    if request.args['status']:
        query = query.filter(Article.status.ilike(request.args['status']))

    return jsonify([c.serialize for c in query.filter().all()]), 200

@api.route("articles/", methods=["PUT"])
@jwt_required()
def update_article():
    id = request.form.get('id', -1)

    article = Article.query.filter(Article.id == id).one_or_none()
    if article is None:
        return error("Article with id %s not found." % id), 404
    if "name" in request.form:
        article.name = request.form["name"]
    if "desc" in request.form:
        article.desc = request.form["desc"]        
    if "price" in request.form:
        article.price = request.form["price"]        
    if "status" in request.form:
        article.status = request.form["status"]

    db.session.commit()
    return jsonify(article.serialize), 200

@api.route("article/", methods=["POST"])
@jwt_required()
def create_article():
    name = request.form.get('name', '')
    category = request.form.get('category', '')
    desc = request.form.get('desc', '')
    price = request.form.get('price', 0.0)
    # need middleware here
    owner = "Albert"
    
    if not (name and category and desc and price and owner):
        return error("Name, description, category, price and owner must be specified"), 401

    if not request.files:
        return error("Need at least one image to create article"), 401

    img_folder_uuid = uuid.uuid4().hex
    os.mkdir(os.path.join(app.config['UPLOAD_FOLDER'], img_folder_uuid))

    article = Article(status='active', name=name, desc=desc, img_folder=img_folder_uuid, owner=owner,category=category)
    db.session.add(article)
    db.session.commit()

    for index, image in enumerate(request.files):
        image = request.files[image]
        if image and allowed_file(image.filename):
            new_filename = "img%s.%s" %(index, secure_filename(image.filename).split(".")[-1])
            image.save(os.path.join(app.config['UPLOAD_FOLDER'], img_folder_uuid, new_filename))

    return jsonify(article.serialize), 201
    
@api.route("/search", methods=["GET"])
def search():
    """
    Suche durchfuhrbar mit Url-Parameter q, z.B. /api/search?q=spachtel
    !!! Achte darauf, dass spachtel nicht von Anführungszeichen umgeben ist, Sonst gibt es keine Suchergebnisse
    Filtern nach status bzw category z.B. via /api/search?q=spachtel&status=active
    """
    query = "%{}%".format(request.args.get("q", ""))
    status = request.args.get("status")
    category = request.args.get("category")
    sql = Article.query.filter(Article.name.like(query) | Article.desc.like(query))

    if status:
        sql = sql.filter(Article.status == status) 

    if category:
        sql = sql.filter(Article.category == category) 

    return jsonify([r.serialize for r in sql.all()]), 200
