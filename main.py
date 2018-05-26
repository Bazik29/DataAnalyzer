import sys

from PyQt5.QtWidgets import QApplication

from view import View
from model import Model
from presenter import Presenter

if __name__ == '__main__':
    app = QApplication(sys.argv)
    
    view = View()
    model = Model()
    presenter = Presenter(view, model)

    sys.exit(app.exec_())
