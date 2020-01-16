from backend import db
import datetime

class User(db.Model):
    __tablename__ = 'user'
    username = db.Column(db.String, primary_key=True)
    email = db.Column(db.String, unique=True, nullable=False)
    password = db.Column(db.String, nullable=False)

    @property
    def serialize(self):
        return {
            "username": self.username,
            "email": self.email
        }


class Category(db.Model):
    __tablename__ = 'category'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String, unique=True, nullable=False)
    desc = db.Column(db.String, nullable=False)

    @property
    def serialize(self):
        return {
            "name": self.name,
            "description": self.desc
        }

class Article(db.Model):
    __tablename__ = 'article'
    id = db.Column(db.Integer, primary_key=True)
    status = db.Column(db.String, nullable=False)
    name = db.Column(db.String, nullable=False)
    desc = db.Column(db.String, nullable=False)  
    img_folder = db.Column(db.String, nullable=False)
    owner = db.Column(db.String, db.ForeignKey('user.username'))
    category = db.Column(db.Integer, db.ForeignKey('category.id'))

    @property
    def serialize(self):
        return {
            "status": self.status,
            "name": self.name,
            "description": self.desc,
            "category": self.category
        }

class Image(db.Model):
    __tablename__ = 'image'
    id = db.Column(db.Integer, primary_key=True)
    path = db.Column(db.String, nullable=False)
    item = db.Column(db.Integer, db.ForeignKey('article.id'))

    @property
    def serialize(self):
        return {
            "path": self.path,
            "item": self.item,
        }    

class Conversation(db.Model):
    __tablename__ = 'conversation'
    id = db.Column(db.Integer, primary_key=True)
    subject = db.Column(db.String, nullable=False)    
    user1 = db.Column(db.String, db.ForeignKey('user.username'))
    user2 = db.Column(db.String, db.ForeignKey('user.username'))
    messages = db.relationship("Message", cascade="all, delete, delete-orphan", backref="conversation")

    @property
    def serialize(self):
        return {
            "subject": self.subject,
            "participants": [self.user1, self.user2],
            "messages": [m.serialize for m in self.messages]
        }    


class Message(db.Model):
    __tablename__ = 'message'    
    id = db.Column(db.Integer, primary_key=True)
    conversation_id = db.Column(db.Integer, db.ForeignKey('conversation.id'))
    message = db.Column(db.String, nullable=False)
    message_date = db.Column(db.DateTime, nullable=False)
    sender = db.Column(db.String, db.ForeignKey('user.username'), nullable=False)
    recipient = db.Column(db.String, db.ForeignKey('user.username'), nullable=False)
   
    @property
    def serialize(self):
        return {
            "message": self.message,
            "message_date": self.message_date,
        }    

    
db.create_all()