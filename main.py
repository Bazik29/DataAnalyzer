from PyQt5.QtWidgets import QApplication
import os


class Presenter():

    def __init__(self, view, model):
        if not os.path.exists("plots"):
            os.makedirs("plots")
        self._view = view
        self._model = model

        self._view.openFileClick.connect(self._view_openFileClick)

        self._view.loadCharact.connect(self._view_loadCharact)
        self._view.loadX.connect(self._view_loadX)
        self._view.loadY.connect(self._view_loadY)
        self._view.loadXY.connect(self._view_loadXY)

    def _view_openFileClick(self):
        path = self._view.pfl_getFilePath()

        if path == "":
            self._view.showMessage("Выберите файл!")
            return

        if not self._model.fileExist(path):
            self._view.showMessage("Файл '{}' не найден!".format(path))
            return

        sep = self._view.pfl_getSeparator()
        decimal = self._view.pfl_getDecimalSym()
        names = None
        header = None
        titleX = "none"
        titleY = "none"
        if not self._view.pfl_haveTitle():
            names = self._view.pfl_getNames()
            titleX = names[0]
            titleY = names[1]
        else:
            header = 0
        title = os.path.basename(path)

        load_str = '''Загружается файл:
    Путь к файлу: %s
    Название: %s
    Есть ли заголок в файле: %s
    Новые заголовки (если заданы):
        Заголовок 1: %s
        Заголовок 2: %s
    Разделитель: %s
    Десятичный разделитель: %s
        ''' % (path, title, str(header == 0 or "none"), str(titleX), str(titleY), sep, decimal)

        print(load_str)

        try:
            self._model.loadFile(path, title, header, names, sep, decimal)
        except Exception as e:
            self._view.showMessage("Не получилось загрузить данные из файла!")
            self._view.lock()
        else:
            self._view.unlock()

        # FILE_PATH = "/home/bazik/Projects/DataAnalyzer/lab.csv"
        # HEADER = 0
        # NAMES = ['Height', 'Weight']
        # SEP = ';'
        # DECIMAL = ','
        # TITLE = "TEST"
        # if TITLE == '' or TITLE is None:
        #     TITLE = os.path.basename(FILE_PATH)
        # if FILE_PATH == "":
        #     print("Выберите файл!")
        # if not os.path.isfile(FILE_PATH):
        #     print("Файл \"{}\" не найден!".format(FILE_PATH))
        # self._model.loadFile(FILE_PATH, TITLE, HEADER, NAMES, SEP, DECIMAL)


    def _view_loadCharact(self):
        self._view.pch_insertlabels(self._model.nameX, self._model.nameY)
        if (not self._model.infoX['ready']): self._model.genInfoX()
        if (not self._model.infoY['ready']): self._model.genInfoY()
        if (not self._model.infoXY['ready']): self._model.genInfoXY()
        
        self._view_loadX()

    def _view_loadX(self):
        if (not self._model.infoX['ready']): self._model.genInfoX()

        source = "../" + self._model.savefig(self._model.infoX['graph'], self._model.title + "-histX", "plots/")
        self._view.pch_setgraphsource(source)

        self._view.pch_insertvalues(self._model.infoX['mean'], self._model.infoX['mode'], self._model.infoX['median'],
                                    self._model.infoX['std'], self._model.infoX['dis'], self._model.infoX['var'],
                                    self._model.infoX['skew'], self._model.infoX['kurt'])

    def _view_loadY(self):
        if (not self._model.infoY['ready']): self._model.genInfoY()

        source = "../" + self._model.savefig(self._model.infoY['graph'], self._model.title + "-histY", "plots/")
        self._view.pch_setgraphsource(source)

        self._view.pch_insertvalues(self._model.infoY['mean'], self._model.infoY['mode'], self._model.infoY['median'],
                                    self._model.infoY['std'], self._model.infoY['dis'], self._model.infoY['var'],
                                    self._model.infoY['skew'], self._model.infoY['kurt'])

    def _view_loadXY(self):
        if (not self._model.infoXY['ready']): self._model.genInfoXY()

        source = "../" + self._model.savefig(self._model.infoXY['graph'], self._model.title + "-scatter", "plots/")
        self._view.pch_setgraphsource(source)


import sys
from view import View
from model import Model

if __name__ == '__main__':
    app = QApplication(sys.argv)
    
    view = View()
    model = Model()
    presenter = Presenter(view, model)

    sys.exit(app.exec_())
