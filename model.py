import pandas as pd
import numpy as np
from scipy import stats
import matplotlib.pyplot as plt

from datetime import datetime


class Model():

    def __init__(self):
        self.data = None
        self.nameX = "X"
        self.nameY = "Y"
        self.title = "Data"
        self.filepath = ""
        self.lenght = 0

    def loadfile(self, filepath, title, header, names, sep=',', decimal='.', index_col=False, usecols=[0, 1], encoding='utf_8'):
        self.data = pd.read_csv(filepath_or_buffer=filepath, header=header, names=names, sep=sep,
                                decimal=decimal, index_col=index_col, usecols=usecols, encoding=encoding)
        self.nameX = self.data.columns[0]
        self.nameY = self.data.columns[1]
        self.title = title
        self.filepath = filepath
        self.lenght = len(self.data)

    def setNames(self, nameX, nameY):
        self.nameX = nameX
        self.data.columns[0] = nameX
        self.nameY = nameY
        self.data.columns[1] = nameY

    def getInfoFile(self):
        """
        Возвращает информацию о выборке:
                -путь к файлу
                -название выборки
                -название Х
                -название Н
                -размер выборки
        """
        return self.filepath, self.title, self.nameX, self.nameY, self.lenght

    def getMean(self, n=2):
        """
        Возвращает среднее значение в зависимости от n
        n = 0 - для X
        n = 1 - для Y
        n = 2 - для X, Y
        """
        if n == 2:
            return np.mean(self.data[self.nameX]), np.mean(self.data[self.nameY])
        if n == 0:
            return np.mean(self.data[self.nameX])
        if n == 1:
            return np.mean(self.data[self.nameY])

    def getMedian(self, n=2):
        """
        Возвращает медиану в зависимости от n
        n = 0 - для X
        n = 1 - для Y
        n = 2 - для X, Y
        """
        if n == 2:
            return np.median(self.data[self.nameX]), np.median(self.data[self.nameY])
        if n == 0:
            return np.median(self.data[self.nameX])
        if n == 1:
            return np.median(self.data[self.nameY])

    #!!!!!!!!
    def getMode(self, n=2):
        """
        Возвращает моду в зависимости от n
        n = 0 - для X
        n = 1 - для Y
        n = 2 - для X, Y
        """
        if n == 2:
            return stats.mode(self.data[self.nameX]), stats.mode(self.data[self.nameY])
        if n == 0:
            return stats.mode(self.data[self.nameX])
        if n == 1:
            return stats.mode(self.data[self.nameY])

    def getStd(self, n=2):
        """
        Возвращает стандартное отклонение в зависимости от n
        n = 0 - для X
        n = 1 - для Y
        n = 2 - для X, Y
        """
        if n == 2:
            return np.std(self.data[self.nameX]), np.std(self.data[self.nameY])
        if n == 0:
            return np.std(self.data[self.nameX])
        if n == 1:
            return np.std(self.data[self.nameY])

    def getVar(self, n=2):
        """
        Возвращает дисперсию в зависимости от n
        n = 0 - для X
        n = 1 - для Y
        n = 2 - для X, Y
        """
        if n == 2:
            return np.var(self.data[self.nameX]), np.var(self.data[self.nameY])
        if n == 0:
            return np.var(self.data[self.nameX])
        if n == 1:
            return np.var(self.data[self.nameY])

    def getVariation(self, n=2):
        """
        Возвращает коэфф вариации в зависимости от n
        n = 0 - для X
        n = 1 - для Y
        n = 2 - для X, Y
        """
        if n == 2:
            return stats.variation(self.data[self.nameX]), stats.variation(self.data[self.nameY])
        if n == 0:
            return stats.variation(self.data[self.nameX])
        if n == 1:
            return stats.variation(self.data[self.nameY])

    def getSkew(self, n=2):
        """
        Возвращает коэфф ассимитрии в зависимости от n
        n = 0 - для X
        n = 1 - для Y
        n = 2 - для X, Y
        """
        if n == 2:
            return stats.skew(self.data[self.nameX]), stats.skew(self.data[self.nameY])
        if n == 0:
            return stats.skew(self.data[self.nameX])
        if n == 1:
            return stats.skew(self.data[self.nameY])

    def getSkew(self, n=2):
        """
        Возвращает эксцесс в зависимости от n
        n = 0 - для X
        n = 1 - для Y
        n = 2 - для X, Y
        """
        if n == 2:
            return stats.kurtosis(self.data[self.nameX]), stats.kurtosis(self.data[self.nameY])
        if n == 0:
            return stats.kurtosis(self.data[self.nameX])
        if n == 1:
            return stats.kurtosis(self.data[self.nameY])

    def createScatter(self, prefix=""):
        """
        Рисует график выборки, сохраняет его и возвращает путь до графика
        """
        path_plot = prefix + self.title + '-' + datetime.today().isoformat() + '.png'

        fig, ax = plt.subplots(figsize=(8, 6))
        colors = np.random.rand(50)
        ax.scatter(self.data[self.nameX], self.data[self.nameY], marker='o', color='red')
        # шрифт цифр осей
        ax.tick_params(axis='both', which='major', labelsize=12)

        plt.grid(ls=':')
        plt.xlabel(self.nameX, fontsize=13)
        plt.ylabel(self.nameY, fontsize=13)
        plt.title(self.title, fontsize=20)
        fig.savefig(path_plot)
        return path_plot
