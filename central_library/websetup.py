"""Setup the central_library application"""
import logging

import datetime

from central_library.config.environment import load_environment

log = logging.getLogger(__name__)

def setup_app(command, conf, vars):
    """Place any commands to setup central_library here"""
    load_environment(conf.global_conf, conf.local_conf)

    # Load the models
    from central_library.model import meta
    meta.metadata.bind = meta.engine

    # Create the tables if they aren't there already
    meta.metadata.create_all(checkfirst=True)
    
    from central_library.model import User, Copy, Item

    quentin = User(u"Quentin McUserpants", u"123 E. Main St.\nBoondocksville, XY, 12345")
    
    book1 = Item(u"A Million Random Digits with 100,000 Normal Deviates", u"RAND Corporation", 9780833030474, datetime.date(2002, 12, 25), "book")
    book2 = Item(u"Watchmen", u"Alan Moore and Dave Gibbons", 9780930289232, datetime.date(1995, 4, 1), "book")
    copy1 = Copy(book1, datetime.date(2005, 1, 1), u"dogeared")
    copy2 = Copy(book1, datetime.date.today(), u"brand new")
    copy3 = Copy(book2, datetime.date.today(), u"brand new")
    sess = meta.Session()
    sess.add_all([quentin, book1, book2, copy1, copy2, copy3])
    sess.commit()
