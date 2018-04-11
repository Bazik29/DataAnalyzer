import sys
from PyQt5.QtWidgets import QApplication

class Presenter():

    def __init__(self, view, model):
        self._view = view
        self._model = model

        self._view.openFileClick.connect(self._view_openFileClick)


    def _view_openFileClick(self):
        path = self._view.getFilePath()

        if path == "":
            self._view.showMessage("Выберите файл!")
            return

        if not self._model.fileExist(path):
            self._view.showMessage("Файл '{}' не найден!".format(path))
            return

        print("FilePath:", path)

        self._model.loadFile(path)



from view import View
from model import Model

if __name__ == '__main__':
    app = QApplication(sys.argv)

    view = View()
    model = Model()

    presenter = Presenter(view, model)

    sys.exit(app.exec_())
