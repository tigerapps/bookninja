import dataset


class Db ():
    def __init__(self):
        self._connect()

    def _connect(self):
        """ Establish db connection """

        if self._conn is None:
            self._conn = datatset.connect('mysql://root@localhost/bookninja')


class Listing(Db):
    def __init__(self):
        super(Db, self).__init__()

    def get_listings(self):
        """ Returns a dictionary of listings. """

        return self._conn['postings'].all()
    
    def create_listing(self, book, condition, desc, price, seller, status,
                       zipcode):
        """ Creates a listing. """

        self._conn['postings'].insert(dict(book=book, book_condition=condition,
                          description=desc, price=price, seller=seller,
                          status=status, zipcode=zipcode))

class Message(Db):
    #TODO(drewwalters96): Implement sessions with this class
    def __init__(self): pass


class User(Db):
    def __init__(self):
        super(Db, self).__init__()

    def get_users(self):
        """ Returns a list of Users. """

        return self._conn['users'].all()

    def create_user(self, email, name, password, school, username, zipcode):
        """ Creates a user. """

        self._conn['users'].insert(dict(email, name, password, school,
                                        username, zipcode)
