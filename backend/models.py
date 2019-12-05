from backend import db
import datetime

class User(db.Model):
    __tablename__ = 'user'
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String, unique=True, nullable=False)
    email = db.Column(db.String, unique=True, nullable=False)
    password = db.Column(db.String, nullable=False)

class Category(db.Model):
    __tablename__ = 'category'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String, unique=True, nullable=False)
    desc = db.Column(db.String, nullable=False)

class Article(db.Model):
    __tablename__ = 'article'
    id = db.Column(db.Integer, primary_key=True)
    status = db.Column(db.String, nullable=False)
    name = db.Column(db.String, nullable=False)
    desc = db.Column(db.String, nullable=False)  
    owner = db.Column(db.Integer, db.ForeignKey('user.id'))
    category = db.Column(db.Integer, db.ForeignKey('category.id'))

class Image(db.Model):
    __tablename__ = 'image'
    id = db.Column(db.Integer, primary_key=True)
    path = db.Column(db.String, nullable=False)
    item = db.Column(db.Integer, db.ForeignKey('article.id'))

class Conversation(db.Model):
    __tablename__ = 'conversation'
    id = db.Column(db.Integer, primary_key=True)
    subject = db.Column(db.String, nullable=False)    
    user1 = db.Column(db.Integer, db.ForeignKey('user.id'))
    user2 = db.Column(db.Integer, db.ForeignKey('user.id'))
    messages = db.relationship("Message", cascade="all, delete, delete-orphan", backref="conversation")


class Message(db.Model):
    __tablename__ = 'message'    
    id = db.Column(db.Integer, primary_key=True)
    conversation_id = db.Column(db.Integer, db.ForeignKey('conversation.id'))
    message = db.Column(db.String, nullable=False)
    message_date = db.Column(db.DateTime, nullable=False)

    
db.create_all()