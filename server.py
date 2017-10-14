from flask import Flask
import json

app = Flask(__name__)


@app.route('/status')
def status():
    return json.dumps({'status': 'online'})


@app.route('/')
def index(): pass


@app.route('/login')
def login(): pass


@app.route('/user/<username>')
def user(): pass


@app.route('/user/<username>/edit')
def user_edit(): pass


@app.route('/user/<username>/inbox')
def user_inbox(): pass


@app.route('/user/<username>/listings')
def user_listings(): pass


@app.route('/class/<class>')
def class_listing(): pass


@app.route('/listings/<listing>')
def listing(): pass
