from flask import Flask, json
from flask_sqlalchemy import SQLAlchemy
from flask_admin import Admin
from flask_admin.contrib.sqla import ModelView


app = Flask(__name__)
app.config['SECRET_KEY'] = 'f03b64dca19c7e6e86b419e8c3abf4db'
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///dorfinv.db'
db = SQLAlchemy(app)


from backend import models
from backend import routes

admin = Admin(app, 'Database')

from backend.models import User, Category, Article, Image, Conversation, Message

class UserView(ModelView):
    column_display_pk = True
    #form_columns = ('id', 'status', 'group_id', 'position', 'workers')

class CategoryView(ModelView):
    #column_exclude_list = ('layout')
    column_display_pk = True

class ArticleView(ModelView):
    column_display_pk = True
    #form_columns = ('id', 'active', 'hidden')

class ImageView(ModelView):
    column_display_pk = True

class ConversationView(ModelView):
    column_display_pk = True

class MessageView(ModelView):
    column_display_pk = True    

admin.add_view(UserView(User, db.session, 'User'))
admin.add_view(CategoryView(Category, db.session, 'Category'))
admin.add_view(ArticleView(Article, db.session, 'Article'))
admin.add_view(ImageView(Image, db.session, 'Image'))
admin.add_view(ConversationView(Conversation, db.session, 'Conversation'))
admin.add_view(MessageView(Message, db.session, 'Message'))