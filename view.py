from PyQt5.QtQml import QQmlApplicationEngine
from PyQt5.QtCore import QObject, QUrl, pyqtSignal

class View(QQmlApplicationEngine):

    def __init__(self):
        super().__init__()
        self.load(QUrl('qml/main.qml'))
        self._root = self.rootObjects()[0]


        # Страница загрузки файла
        self.pageLoadFile = self._root.findChild(QObject, "pageFileLoad")


        # Проброс сигналов из qml в python
        self.pageLoadFile.openFileClick.connect(self.openFileClick.emit)

    # Сигналы
    openFileClick = pyqtSignal()

    def showMessage(self, message):
        #self.pageLoadFile.showMessage(message)
        print(message)

    def getFilePath(self):
        pathFile = self.pageLoadFile.findChild(QObject, "pathFile")
        path = pathFile.property("text")
        return path

