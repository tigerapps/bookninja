from flask import Flask, render_template, request
import json

app = Flask(__name__)


@app.route('/api/v1/listings', methods=['GET', 'POST'])
@app.route('/api/v1/listings/<int:listing_id>')
def api_listings(listing_id=None):
    """ Retrieves information about listings.

    GET: Retrieves all listings matching the query parameters, or information
         about a specific listing if a listing ID is given.

    POST: Creates a new listing.
    """

    if listing_id is not None:
        return json.dumps({})
    elif request.method == 'GET':
        return json.dumps([])
    else:
        return json.dumps({'status': 'okay'})


@app.route('/api/v1/messages', methods=['GET', 'POST'])
@app.route('/api/v1/messages/<int:message_id>')
def api_messages(message_id=None):
    """ Retrieves messages.

    GET: Retrieves all messages for an authenticated user, or a single message
         if a message ID is given.

    POST: Creates a message.
    """

    if message_id is not None:
        return json.dumps({})
    elif request.method == 'GET':
        return json.dumps([])
    else:
        return json.dumps({'status': 'okay'})


@app.route('/api/v1/status')
def api_status():
    """ Returns the status of the API service. """

    return json.dumps({'status': 'online'})


@app.route('/api/v1/users', methods=['GET', 'POST'])
@app.route('/api/v1/users/<int:user_id>')
def api_users(user_id=None):
    """ Retrieves information about users.

    GET: Retrieves all users, or information about a specific user if a user ID
         is given.

    POST: Creates a new user.
    """

    if user_id is not None:
        return json.dumps({})
    elif request.method == 'GET':
        return json.dumps([])
    else:
        return json.dumps({'status': 'okay'})


@app.route('/')
def show_listings():
    """ Shows a page allowing the user to search for listings. """

    return render_template('listings.html')


@app.route('/listing/<int:listing_id>')
def show_listing(listing_id):
    """ Shows a page providing details about a specific listing. """

    return render_template('listing.html', listing=listing_id)


@app.route('/messages')
def show_messages():
    """ Shows a list of conversations and provides the ability to reply. """

    return render_template('messages.html')


@app.route('/modal/compose')
def modal_compose():
    """ Modal dialog fragment for composing a message. """

    return render_template('modal/compose.html')


@app.route('/modal/editprofile')
def modal_editprofile():
    """ Modal dialog fragment for editing the current user's profile. """

    return render_template('modal/editprofile.html')


@app.route('/modal/login')
def modal_login():
    """ Modal dialog fragment for authenticating a user. """

    return render_template('modal/login.html')


@app.route('/modal/newuser')
def modal_newuser():
    """ Modal dialog fragment for creating a user. """

    return render_template('modal/newuser.html')


@app.route('/user/<int:user_id>')
def show_user(user_id):
    """ Shows the profile and listings associated with a specific user. """

    return render_template('user.html', user=user_id)
