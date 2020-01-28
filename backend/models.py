from backend import db
from datetime import datetime

class User(db.Model):
    __tablename__ = 'user'
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String, unique=True, nullable=False)
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

    def __repr__(self):
        return "<Category(id='%s', name='%s')>" % (self.id, self.name)

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
    price = db.Column(db.Integer, nullable=False)
    desc = db.Column(db.String, nullable=False)  
    img_amount = db.Column(db.Integer, nullable=False)
    img_folder = db.Column(db.String, nullable=False)
    owner = db.Column(db.String, db.ForeignKey('user.username'))
    pub_date = db.Column(db.DateTime, nullable=False, default=datetime.now)
    cat_id = db.Column(db.Integer, db.ForeignKey('category.id')) 
    category = db.relationship("Category")

    @property
    def serialize(self):
        return {
            "id": self.id,
            "status": self.status,
            "name": self.name,
            "price": self.price,
            "description": self.desc,
            "img_amount": self.img_amount,
            "category_id": self.category.id,
            "category_name": self.category.name,
            "owner": self.owner,
            "pub_date": self.pub_date
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
            "messages": [m.serialize for m in self.messages],
            "id": self.id
        }    


class Message(db.Model):
    __tablename__ = 'message'    
    id = db.Column(db.Integer, primary_key=True)
    conversation_id = db.Column(db.Integer, db.ForeignKey('conversation.id'))
    message = db.Column(db.String, nullable=False)
    pub_date = db.Column(db.DateTime, nullable=False, default=datetime.now)
    sender = db.Column(db.String, db.ForeignKey('user.username'), nullable=False)
    recipient = db.Column(db.String, db.ForeignKey('user.username'), nullable=False)
   
    @property
    def serialize(self):
        return {
            "message": self.message,
            "message_date": self.pub_date,
        }    

    
db.create_all()