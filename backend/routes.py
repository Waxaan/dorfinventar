from flask import jsonify
from backend import app, db
from backend.models import User

@app.route("/dashboard")
def dashboard():
    return jsonify({'success': False, 'error': _('TEST')}), 400


@app.route("/auth/register/", methods=["GET", "POST"])
def register():
    user = User(username="User1", password="Test", email="test@test.test")
    db.session.add(user)
    db.session.commit()
    return jsonify({'data': 'success'}), 200


@app.route("/article/list/", methods=["GET"])
def list_articles():
    pass
@app.route("/article/list/", methods=["POST"])
def post_article():
    pass