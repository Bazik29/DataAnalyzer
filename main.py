from PyQt5.QtWidgets import QApplication
import os

class Presenter():

    def __init__(self, view, model):
        self._view = view
        self._model = model

        self._view.openFileClick.connect(self._view_openFileClick)

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

        load_str =  '''Загружается файл:
    Путь к файлу: %s
    Название: %s
    Есть ли заголок в файле: %s
    Новые заголовки (если заданы):
        Заголовок 1: %s
        Заголовок 2: %s
    Разделитель: %s
    Десятичный разделитель: %s
        '''% (path, title, str(header == 0 or "none"), str(titleX), str(titleY), sep, decimal)

        print(load_str)

        self._model.loadFile(path, title, header, names, sep, decimal)

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


        self._view.pch_insertlabels(self._model.nameX, self._model.nameY)
        self._view_loadX()


    def _view_loadX(self):
        source = "../" + self._model.savefig(self._model.histogram(self._model.nameX), self._model.title + "-histX", "plots/")
        self._view.pch_setgraphsource(source)

        mean = round(float(self._model.getMean(self._model.nameX)), 4)
        mode = round(float(self._model.getMode(self._model.nameX).mode[0]), 4)
        median = round(float(self._model.getMedian(self._model.nameX)), 4)
        std = round(float(self._model.getStd(self._model.nameX)), 4)
        dis = round(float(self._model.getDispersion(self._model.nameX)), 4)
        var = round(float(self._model.getVariation(self._model.nameX)), 4)
        skew = round(float(self._model.getSkew(self._model.nameX)), 4)
        kurt = round(float(self._model.getKurtosis(self._model.nameX)), 4)
        self._view.pch_insertvalues(mean, mode, median, std, dis, var, skew, kurt)

    def _view_loadY(self):
        source = "../" + self._model.savefig(self._model.histogram(self._model.nameY), self._model.title + "-histY", "plots/")
        self._view.pch_setgraphsource(source)

        mean = round(float(self._model.getMean(self._model.nameY)), 4)
        mode = round(float(self._model.getMode(self._model.nameY).mode[0]), 4)
        median = round(float(self._model.getMedian(self._model.nameY)), 4)
        std = round(float(self._model.getStd(self._model.nameY)), 4)
        dis = round(float(self._model.getDispersion(self._model.nameY)), 4)
        var = round(float(self._model.getVariation(self._model.nameY)), 4)
        skew = round(float(self._model.getSkew(self._model.nameY)), 4)
        kurt = round(float(self._model.getKurtosis(self._model.nameY)), 4)
        self._view.pch_insertvalues(mean, mode, median, std, dis, var, skew, kurt)

    def _view_loadXY(self):
        source = "../" + self._model.savefig(self._model.scatter(), self._model.title + "-scatter", "plots/")
        self._view.pch_setgraphsource(source)


import sys
from view import View
from model import Model

if __name__ == '__main__':
    if not os.path.exists("plots"):
        os.makedirs("plots")

    app = QApplication(sys.argv)
	#this MVP
    view = View()
    model = Model()
    presenter = Presenter(view, model)

    sys.exit(app.exec_())
