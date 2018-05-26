from PyQt5.QtQml import QQmlApplicationEngine
from PyQt5.QtCore import QObject, QUrl, pyqtSignal
import os

class View(QQmlApplicationEngine):

    def __init__(self):
        super().__init__()
        self.load(QUrl('qml/main.qml'))
        self._root = self.rootObjects()[0]

        # Страница загрузки файла
        self.pageLoadFile = self._root.findChild(QObject, 'pageFileLoad')
        self.pageCharact = self._root.findChild(QObject, 'pageCharact')
        self.pageReport = self._root.findChild(QObject, 'pageReport')

        # Проброс сигналов из qml в python
        self.pageLoadFile.openFileClick.connect(self.openFileClick.emit)

        self._root.loadCharact.connect(self.loadCharact.emit)
        self.pageCharact.loadX.connect(self.loadX.emit)
        self.pageCharact.loadY.connect(self.loadY.emit)
        self.pageCharact.loadXY.connect(self.loadXY.emit)

        self.pageReport.reportClick.connect(self.reportClick.emit)

    # Сигналы
    openFileClick = pyqtSignal()
    loadCharact = pyqtSignal()
    loadX = pyqtSignal()
    loadY = pyqtSignal()
    loadXY = pyqtSignal()
    reportClick = pyqtSignal()


    def showMessage(self, message):
        self._root.showMessage(message)

    def lock(self):
        self._root.lock()

    def unlock(self):
        self._root.unlock()

    def pfl_getFilePath(self):
        path = self.pageLoadFile.getFilePath()
        if os.name == "nt": return path
        else: return '/' + path

    def pfl_getSeparator(self):
        return self.pageLoadFile.getSeparator()

    def pfl_haveTitle(self):
        return self.pageLoadFile.haveTitle()

    def pfl_getTitle(self):
        return self.pageLoadFile.getTitle()

    def pfl_haveNames(self):
        return self.pageLoadFile.haveNames()

    def pfl_getNames(self):
        X = self.pageLoadFile.getNameX()
        Y = self.pageLoadFile.getNameY()
        return [X, Y]

    def pfl_getDecimalSym(self):
        return self.pageLoadFile.getDecimalSym()


    def pch_insertlabels(self, nameX, nameY):
        self.pageCharact.insertlabels(nameX, nameY)

    def pch_insertvalues(self, mean, mode, median, std, dis, var, skew, kurt):
        self.pageCharact.insertvalues(mean, mode, median, std, dis, var, skew, kurt)

    def pch_setgraphsource(self, source):
        self.pageCharact.setgraphsource(source)


    def prp_getList(self):
        self.pageReport.getArrayOfReport().toVariant()
