import logging

from pylons import request, response, session, tmpl_context as c
from pylons.controllers.util import abort, redirect_to

from central_library.lib.base import BaseController, render
from central_library import model

log = logging.getLogger(__name__)

class BookController(BaseController):

    def index(self):
        # Return a rendered template
        #   return render('/template.mako')
        # or, Return a response
        c.items = model.Item.query()
        return render("books/index.mako")
    def show(self, id):
        c.item = model.Item.query().get(id)
        if c.item is None:
            abort(404)
        c.users = [(user.user_id, user.name) for user in model.User.query()]
        return render("books/show.mako")
