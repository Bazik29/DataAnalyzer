import pandas as pd
import numpy as np
from scipy import stats
import matplotlib.pyplot as plt
from datetime import datetime
import os

class Model():

    def __init__(self):
        self.data = None
        self.nameX = "X"
        self.nameY = "Y"
        self.title = "Data"
        self.filepath = ""
        self.lenght = 0

    def fileExist(srlf, path):
        return os.path.isfile(path)

    def loadFile(self, filepath, title, header, names, sep=',', decimal='.', index_col=False, usecols=[0, 1], encoding='utf_8'):
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

    def getMean(self, name):
        """
        Возвращает среднее значение столбца name
        """
        return np.mean(self.data[name])

    def getMedian(self, name):
        """
        Возвращает медиану столбца name
        """
        return np.median(self.data[name])

    def getMode(self, name):
        """
        Возвращает моду столбца name
        """
        return stats.mode(self.data[name])

    def getStd(self, name):
        """
        Возвращает стандартное отклонение столбца name
        """
        return np.std(self.data[name])

    def getDispersion(self, name):
        """
        Возвращает дисперсию столбца name
        """
        return np.var(self.data[name])

    def getVariation(self, name):
        """
        Возвращает коэффициент вариации столбца name
        """
        return stats.variation(self.data[name])

    def getSkew(self, name):
        """
        Возвращает коэффициент ассимитрии столбца name
        """
        return stats.skew(self.data[name])

    def getKurtosis(self, name):
        """
        Возвращает коэффициент эксцесса столбца name
        """
        return stats.kurtosis(self.data[name])

    def savefig(self, fig, name, prefix=""):
        """
        Cохраняет фигуру в файл и возвращает путь до файла
        Добавляет к названию время создания файла
        prefix - путь до папки
        """
        # '-' + datetime.today().isoformat() + 
        path_plot = prefix + name + '.png'
        fig.savefig(path_plot)
        return path_plot

    def scatter(self):
        """
        Рисует график выборки, возвращает фигуру
        """
        fig, ax = plt.subplots(figsize=(7.3, 3.8))
        ax.scatter(self.data[self.nameX],
                   self.data[self.nameY], marker='o', color='red')
        # шрифт цифр осей
        ax.tick_params(axis='both', which='major', labelsize=12)

        plt.grid(ls=':')
        plt.xlabel(self.nameX, fontsize=13)
        plt.ylabel(self.nameY, fontsize=13)
        plt.title(self.title, fontsize=20)
        return fig

    def histogram(self, name):
        """
        Рисует гистаграмму столбца name, возвращает фигуру
        """
        fig, ax = plt.subplots(figsize=(7.3, 3.8))
        ax.hist(self.data[name], color='red')
        # шрифт цифр осей
        ax.tick_params(axis='both', which='major', labelsize=12)
        plt.grid(ls=':')
        plt.xlabel(name, fontsize=13)
        plt.title(self.title, fontsize=20)
        return fig
