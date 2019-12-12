from flask import jsonify, request, Blueprint
from backend import app, db
from backend.models import User, Category


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
    if not request.is_json:
        return error("Expected data to be JSON encoded"), 400
    
    data = request.get_json()
    username = data.get("username", "").lower() # to normalize usernames
    password = data.get("password", "")
    email    = data.get("email", "")

    if not (username and password and email):
        return error("Please set a username, password and email address for the registration"), 400

    if User.query.filter_by(username=username, email=email).first():
        return error(f"An acccount with username '{username}' or email address '{email}' already exists"), 400

    user = User(username=username, password=password, email=email)
    db.session.add(user)
    db.session.commit()
    return jsonify(user.serialize), 201


@api.route("categories", methods=["GET"])
def get_article():
    return jsonify([c.serialize for c in Category.query.all()])
    