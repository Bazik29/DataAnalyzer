from PyQt5.QtQml import QQmlApplicationEngine
from PyQt5.QtCore import QObject, QUrl, pyqtSignal
import os

class View(QQmlApplicationEngine):

    def __init__(self):
        super().__init__()
        self.load(QUrl('qml/main.qml'))
        self._root = self.rootObjects()[0]

        # Страницы
        self.pageLoadFile = self._root.findChild(QObject, 'pageFileLoad')
        self.pageCharact = self._root.findChild(QObject, 'pageCharact')
        self.pageCrits = self._root.findChild(QObject, 'pageCrits')
        self.pageRegress = self._root.findChild(QObject, 'pageRegress')
        self.pageDisp = self._root.findChild(QObject, 'pageDisp')
        self.pageReport = self._root.findChild(QObject, 'pageReport')

        # Проброс сигналов из qml в python
        self.pageLoadFile.openFileClick.connect(self.openFileClick.emit)

        self._root.loadCharact.connect(self.loadCharact.emit)
        self._root.loadRegress.connect(self.loadRegress.emit)
        self._root.loadCrits.connect(self.loadCrits.emit)
        self._root.loadDisper.connect(self.loadDisper.emit)
        self._root.loadReport.connect(self.loadReport.emit)

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
    loadRegress = pyqtSignal()
    loadCrits = pyqtSignal()
    loadDisper = pyqtSignal()
    loadReport = pyqtSignal()
    reportClick = pyqtSignal()


    def showError(self, message):
        self._root.showMessage(message)

    def showMessage(self, message):
        self._root.showUved(message)

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


    def preg_setgraphsource(self, source):
        self.pageRegress.setgraphsource(source)

    def preg_insertvalues(self, urav, mnR, R2, stdR, coef, count):
        self.pageRegress.insertvalues(urav, mnR, R2, stdR, coef, count)


    def pcr_insertvalues(self, D1, pvl1, D2, pvl2):
        self.pageCrits.insertvalues(D1, pvl1, D2, pvl2)


    def pdis_insertvalues(self, fstv, pvlv):
        self.pageDisp.insertvalues(fstv, pvlv)


    def prp_getList(self):
        return self.pageReport.getArrayOfReport().toVariant()

    def prp_setlabels(self, lx, ly):
        return self.pageReport.setlabels(lx, ly)

    def prp_getFile(self):
        return self.pageReport.getFilePath()
