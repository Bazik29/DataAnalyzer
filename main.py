from PyQt5.QtWidgets import QApplication


class Presenter():

    def __init__(self, view, model):
        self._view = view
        self._model = model

        self._view.openFileClick.connect(self._view_openFileClick)

    def _view_openFileClick(self):
        print("_view_openFileClick")
        path = self._view.getFilePath()

        if path == "":
            self._view.showMessage("Выберите файл!")
            return

        if not self._model.fileExist(path):
            self._view.showMessage("Файл '{}' не найден!".format(path))
            return

        sep = self._view.getSeparator()
        decimal = self._view.getDecimalSym()
        names = None
        header = None
        if not self._view.haveTitle():
            names = self._view.getNames()
        else:
            header = 0

        load_str =  '''Загружается файл.../n
            Путь к файлу: %s\n
            Название: %s\n
            Есть ли заголок в файле: %s\n
            Новые заголовки (если заданы):
            Заголовок 1: %s\n
            Заголовок 2: %s\n
            Разделитель: %s\n
            Десятичный разделитель: %s\n
        '''% (filepath, title, str(header), str(titleX), str(titleY), sep, decimal)

        print(load_str)

        self._model.loadFile(path, sep, decimal, header, names)


import sys
from view import View
from model import Model

if __name__ == '__main__':
    app = QApplication(sys.argv)
	#this MVP
    view = View()
    model = Model()

    presenter = Presenter(view, model)

    sys.exit(app.exec_())
