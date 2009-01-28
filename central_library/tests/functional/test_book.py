from central_library.tests import *

class TestBookController(TestController):

    def test_index(self):
        response = self.app.get(url(controller='book', action='index'))
        # Test response...
