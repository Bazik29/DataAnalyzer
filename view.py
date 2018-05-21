from PyQt5.QtQml import QQmlApplicationEngine
from PyQt5.QtCore import QObject, QUrl, pyqtSignal

class View(QQmlApplicationEngine):

    def __init__(self):
        super().__init__()
        self.load(QUrl('qml/main.qml'))
        self._root = self.rootObjects()[0]

        # Страница загрузки файла
        self.pageLoadFile = self._root.findChild(QObject, 'pageFileLoad')

        self.pageCharact = self._root.findChild(QObject, 'pageCharact')

        # Проброс сигналов из qml в python
        self.pageLoadFile.openFileClick.connect(self.openFileClick.emit)

        self._root.loadCharact.connect(self.loadCharact.emit)
        self.pageCharact.loadX.connect(self.loadX.emit)
        self.pageCharact.loadY.connect(self.loadY.emit)
        self.pageCharact.loadXY.connect(self.loadXY.emit)

    # Сигналы
    openFileClick = pyqtSignal()
    loadCharact = pyqtSignal()
    loadX = pyqtSignal()
    loadY = pyqtSignal()
    loadXY = pyqtSignal()


    def showMessage(self, message):
        self._root.showMessage(message)

    def lock(self):
        self._root.lock()

    def unlock(self):
        self._root.unlock()

    def pfl_getFilePath(self):
        return self.pageLoadFile.getFilePath()

    def pfl_getSeparator(self):
        return self.pageLoadFile.getSeparator()

    def pfl_haveTitle(self):
        return self.pageLoadFile.haveTitle()

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
