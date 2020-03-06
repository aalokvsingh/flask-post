from flask import Flask, render_template, request, session, redirect
from flask_sqlalchemy import SQLAlchemy
from werkzeug import secure_filename
from flask_mail import Mail
import json
import os
import math
from datetime import datetime


with open('config.json', 'r') as c:
    params = json.load(c)["params"]


local_server = True
app = Flask(__name__)
app.secret_key = "super secret key"
app.config['UPLOAD_FOLDER'] = params['upload_location']

app.config.update(
    MAIL_SERVER = 'smtp.gmail.com',
    MAIL_PORT = '465',
    MAIL_USE_SSL = True,
    MAIL_USERNAME = params['gmail_username'],
    MAIL_PASSWORD=  params['gmail_password']
)
mail = Mail(app)
if(local_server):
    app.config['SQLALCHEMY_DATABASE_URI']= params["local_uri"]
else:
    app.config['SQLALCHEMY_DATABASE_URI'] = params["prod_uri"]

db = SQLAlchemy(app)

class Contacts(db.Model):
    '''
    sno, name phone_num, msg, date, email
   '''
    srno = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(80),nullable=False)
    phone_no = db.Column(db.String(80), nullable=False)
    msg = db.Column(db.String(80), nullable=False)
    email = db.Column(db.String(80), nullable=False)
    date = db.Column(db.String(80), nullable=False)

class Posts(db.Model):
    srno = db.Column(db.Integer,primary_key=True)
    title = db.Column(db.String(80),nullable=False)
    tagline = db.Column(db.String(80), nullable=False)
    slug = db.Column(db.String(25),nullable=False)
    content = db.Column(db.String(100),nullable=False)
    img_file = db.Column(db.String(100), nullable=False)
    date = db.Column(db.String(80),nullable=False)

@app.route("/post/<string:post_slug>", methods=['GET'])
def post_route(post_slug):
    post = Posts.query.filter_by(slug = post_slug).first()
    return render_template("post.html",params=params,post=post)

@app.route("/")
def home():

    #posts = Posts.query.filter_by().all()[0:params["no_of_posts"]]
    posts = Posts.query.filter_by().all()
    last = math.floor(len(posts) / int(params["no_of_posts"]))

    page = request.args.get('number')

    if(not str(page).isnumeric()):
        page = 1
    page = int(page)

    posts = posts[(page-1) * int(params["no_of_posts"]) : (page-1) * int(params["no_of_posts"]) + int(params["no_of_posts"])]
    if (page == 1):
        prev = '#'
        next = "/?number=" + str(page +1)
    elif(page == last):
        prev = "/?number=" + str(page -1)
        next = '#'
    else:
        prev = "/?number=" + str(page - 1)
        next = "/?number=" + str(page + 1)



    return render_template("index.html",params = params,posts=posts, prev = prev, next = next)


@app.route("/about")
def about():
    return render_template("about.html",params = params)


@app.route("/contact", methods=["GET","POST"])
def contact():
    if(request.method=='POST'):
        ''' Add entry to database'''
        name = request.form.get('name')
        email = request.form.get('email')
        phone = request.form.get('phone')
        message = request.form.get('message')
        entry = Contacts(name=name,phone_no=phone,msg=message,email=email,date=datetime.now())
        db.session.add(entry)
        db.session.commit()
        # mail.send_message('New message from ' + name,
        #                   sender=email,
        #                   recipients=[params['gmail_username']],
        #                   body=message + "\n" + phone
        #                   )

    return render_template("contact.html",params = params)

@app.route("/dashboard", methods=['GET','POST'])
def dashboard():
    if ('username' in session and session["username"] == params["admin_username"]):
        post = Posts.query.all()
        return render_template("dashboard.html", params=params, post =post)



    if (request.method == 'POST') :
        username = request.form.get("name")
        password = request.form.get("password")
        #return request.form.get("name") + request.form.get("password")
        if(username == params['admin_username'] and password == params["admin_password"]):
            session["username"] = username
            post = Posts.query.all()
            return render_template("dashboard.html", params=params, post =post)
        else:
            return 'invalid data'

    return render_template("login.html",params=params)

@app.route("/edit/<string:srno>", methods = ["GET","POST"])
def post_edit(srno):
    if ('username' in session and session["username"] == params["admin_username"]):
        if (request.method == 'POST'):
            title = request.form.get("title")
            tagline = request.form.get("tagline")
            slug = request.form.get("slug")
            content = request.form.get("content")
            img_file = request.form.get("img_file")
            if srno == '0':
                post = Posts(title = title, tagline = tagline, slug = slug, content  = content, img_file = img_file)
                db.session.add(post)
                db.session.commit()
            else:
                post = Posts.query.filter_by(srno=srno).first()
                post.title =title
                post.tagline = tagline
                post.slug = slug
                post.content = content
                post.img_file = img_file
                date = datetime.now()
                db.session.commit()
                return redirect("/edit/"+srno)
    post = Posts.query.filter_by(srno=srno).first()
    return render_template("post_edit.html", params = params, post = post, srno =srno)

@app.route("/uploader", methods=['GET','POST'])
def uploader():
    if ('username' in session and session["username"] == params["admin_username"]):
        if (request.method == 'POST') :
            f = request.files['file1']
            f.save(os.path.join(app.config['UPLOAD_FOLDER'],secure_filename(f.filename)))
            return "Upload sucessfull"
        else:
            return "aaaaa"

@app.route("/logout")
def logout():
    session.pop("username")
    return redirect("/dashboard")

@app.route("/delete/<string:srno>", methods = ['GET','POST'])
def delete(srno):
    if ('username' in session and session["username"] == params["admin_username"]):
        posts = Posts.query.filter_by(srno = srno).first()
        db.session.delete(posts)
        db.session.commit()
    return redirect("/dashboard")


app.run(debug=True)
