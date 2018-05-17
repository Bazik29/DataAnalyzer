from PyQt5.QtWidgets import QApplication


class Presenter():

    def __init__(self, view, model):
        self._view = view
        self._model = model

        self._view.openFileClick.connect(self._view_openFileClick)

        self._view.loadX.connect(self._view_loadX)
        self._view.loadY.connect(self._view_loadY)
        self._view.loadXY.connect(self._view_loadXY)

    def _view_openFileClick(self):
        print("_view_openFileClick")
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
        if not self._view.pfl_haveTitle():
            names = self._view.pfl_getNames()
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

        # self._model.loadFile(path, sep, decimal, header, names)


        FILE_PATH = "/home/bazik/Projects/DataAnalyzer/lab.csv"
        HEADER = 0
        NAMES = ['Height', 'Weight']
        SEP = ';'
        DECIMAL = ','
        TITLE = ""
        if TITLE == '' or TITLE is None:
            TITLE = os.path.basename(FILE_PATH)
        if FILE_PATH == "":
            print("Выберите файл!")
        if not os.path.isfile(FILE_PATH):
            print("Файл \"{}\" не найден!".format(FILE_PATH))
        self._model.loadFile(FILE_PATH, TITLE, HEADER, NAMES, SEP, DECIMAL)


        self._view.pch_insertlabels(self._model.nameX, self._model.nameY)
        self._view_loadX()


    def _view_loadX():
        source = self._model.savefig(self._model.histogram(self._model.nameX), self._model.title, "plots/")
        self._view.pch_setgraphsource(source)

        mean = self._model.getMean(self._model.nameX)
        mode = self._model.getMedian(self._model.nameX)
        median = self._model.getMode(self._model.nameX)
        std = self._model.getStd(self._model.nameX)
        dis = self._model.getDispersion(self._model.nameX)
        var = self._model.getVariation(self._model.nameX)
        skew = self._model.getSkew(self._model.nameX)
        kurt = self._model.getKurtosis(self._model.nameX)
        self._view.pch_insertvalues(mean, mode, median, std, dis, var, skew, kurt)

    def _view_loadY():
        source = self._model.savefig(self._model.histogram(self._model.nameY), self._model.title, "plots/")
        self._view.pch_setgraphsource(source)

        mean = self._model.getMean(self._model.nameY)
        mode = self._model.getMedian(self._model.nameY)
        median = self._model.getMode(self._model.nameY)
        std = self._model.getStd(self._model.nameY)
        dis = self._model.getDispersion(self._model.nameY)
        var = self._model.getVariation(self._model.nameY)
        skew = self._model.getSkew(self._model.nameY)
        kurt = self._model.getKurtosis(self._model.nameY)
        self._view.pch_insertvalues(mean, mode, median, std, dis, var, skew, kurt)

    def _view_loadXY():
        source = self._model.savefig(self._model.scatter(), self._model.title, "plots/")
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
