"""The application's model objects"""
import sqlalchemy as sa
from sqlalchemy import orm
import re, datetime
from central_library.model import meta

def init_model(engine):
    """Call me before using any of the tables or classes in the model"""

    sm = orm.sessionmaker(autoflush=True, autocommit=False, bind=engine)

    meta.engine = engine
    meta.Session = orm.scoped_session(sm)

    # Here we use the "contextual session": http://www.sqlalchemy.org/docs/05/session.html#contextual-thread-local-sessions
    meta.Session.mapper(User, users_table, properties = {"loans": orm.relation(Loan, backref='user')})
    meta.Session.mapper(Item, items_table, properties = {"copies": orm.relation(Copy, backref='item')})
    meta.Session.mapper(Copy, copies_table, properties = {"loans": orm.relation(Loan, backref='copy', order_by=loans_table.c.due_date.asc())})
    meta.Session.mapper(Loan, loans_table)

users_table = sa.Table("users", meta.metadata,
    sa.Column("user_id", sa.types.Integer, primary_key=True),
    sa.Column("name", sa.types.Unicode(200), nullable=False),
    sa.Column("address", sa.types.UnicodeText, nullable=False),
    sa.Column("is_staff", sa.types.Boolean, nullable=False, default=False),
)

items_table = sa.Table("items", meta.metadata,
    sa.Column("item_id", sa.types.Integer, primary_key=True),
    sa.Column("title", sa.types.Unicode(200), nullable=False),
    sa.Column("author", sa.types.Unicode(200), nullable=False),
    sa.Column("ean", sa.types.String(13), nullable=True, unique=True),
    sa.Column("pub_date", sa.types.Date, nullable=True),
    sa.Column("kind", sa.types.String(50), nullable=False),
)

copies_table = sa.Table("copies", meta.metadata,
    sa.Column("copy_id", sa.types.Integer, primary_key=True),
    sa.Column("item_id", sa.types.Integer, sa.ForeignKey("items.item_id"), nullable=False),
    sa.Column("acquired_date", sa.types.Date, nullable=False),
    sa.Column("condition_notes", sa.types.UnicodeText, nullable=True),
)

loans_table = sa.Table("loans", meta.metadata,
    sa.Column("loan_id", sa.types.Integer, primary_key=True),
    sa.Column("user_id", sa.types.Integer, sa.ForeignKey("users.user_id"), nullable=False),
    sa.Column("copy_id", sa.types.Integer, sa.ForeignKey("copies.copy_id"), nullable=False),
    sa.Column("checked_out", sa.types.Date, nullable=False),
    sa.Column("due_date", sa.types.Date, nullable=False),
    sa.Column("returned", sa.types.Boolean, nullable=False, default=False),
)

class User(object):
    def __init__(self, name, address, is_staff=False):
        self.name = name
        self.address = address
        self.is_staff = is_staff
    def __repr__(self):
        return "<User('%d', '%s', '%s', '%s')>" % ((self.user_id or -1), self.name, self.address, self.is_staff)

class Item(object):
    def __init__(self, title, author, ean=None, pub_date=None, kind="book"):
        self.title = title
        self.author = author
        self.ean = ean
        self.pub_date = pub_date
        self.kind = kind
    @orm.validates('kind')
    def _validate_kind(self, key, kind):
        assert kind in ['book', "video", "audio", "software"]
        return kind
    @orm.validates('ean')
    def _validate_ean(self, key, ean):
        if isinstance(ean, (int, long)):
            ean = str(ean)
        ean = re.sub(r"\D", "", ean)
        assert len(ean) == 13
        return ean
    def copies_owned(self):
        return len(self.copies)
    def copies_on_hand(self):
        return len([copy for copy in self.copies if not copy.is_out()])
    
class Copy(object):
    def __init__(self, item, acquired_date, condition_notes=None):
        self.item = item
        self.acquired_date = acquired_date
        self.condition_notes = condition_notes
    def is_out(self):
        return len(self.loans) > 0 and not all([loan.returned for loan in self.loans])
    def current_loan(self):
        if not self.is_out():
            return None
        return self.loans[-1]

class Loan(object):
    def __init__(self, user, copy, due_date):
        self.user = user
        self.copy = copy
        self.checked_out = datetime.date.today()
        self.due_date = due_date
        self.returned = False
