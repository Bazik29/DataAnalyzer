import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from scipy import stats
from jinja2 import Template
from sklearn.linear_model import LinearRegression

import os
import base64

class Model():

    def __init__(self):
        self.template = None
        self.data = None
        self.nameX = "X"
        self.nameY = "Y"
        self.title = "Data"
        self.filepath = ""
        self.infoX = {
            'ready': False,
            'graph': None,
            'mean': None,
            'mode': None,
            'median': None,
            'std': None,
            'dis': None,
            'var': None,
            'skew': None,
            'kurt': None
        }
        self.infoY = {
            'ready': False,
            'graph': None,
            'mean': None,
            'mode': None,
            'median': None,
            'std': None,
            'dis': None,
            'var': None,
            'skew': None,
            'kurt': None
        }
        self.infoXY = {
            'ready': False,
            'graph': None
        }
        self.infoReg = {
            'coef': None,
            'intercept': None,
            'R2': None,
            'R': None,
            'graph': None,
            'ready': False
        }
        self.infoCrit = {
            'kolm': {
                'k': 0,
                'p': 0
                },
            'pirs': {
                'k': 0,
                'p': 0
                },
            'ready': False
        }
        self.infoDisp = {
            'ready': False,
            'f': 0,
            'p': 0
        }

    def clean(self):
        self.data = None
        self.nameX = "X"
        self.nameY = "Y"
        self.title = "Data"
        self.filepath = ""

        self.infoX = {
            'ready': False,
            'graph': None,
            'mean': None,
            'mode': None,
            'median': None,
            'std': None,
            'dis': None,
            'var': None,
            'skew': None,
            'kurt': None
        }
        self.infoY = {
            'ready': False,
            'graph': None,
            'mean': None,
            'mode': None,
            'median': None,
            'std': None,
            'dis': None,
            'var': None,
            'skew': None,
            'kurt': None
        }
        self.infoXY = {
            'ready': False,
            'graph': None
        }
        self.infoReg = {
            'coef': None,
            'intercept': None,
            'R2': None,
            'R': None,
            'graph': None,
            'ready': False
        }
        self.infoCrit = {
            'kolm': {
                'k': 0,
                'p': 0
                },
            'pirs': {
                'k': 0,
                'p': 0
                },
            'ready': False
        }

    def fileExist(self, path):
        return os.path.isfile(path)

    def loadFile(self, filepath, title, header, names, sep=',', decimal='.', index_col=False, usecols=[0, 1], encoding='utf_8', engine='python'):
        if (self.data is None or not self.data.empty):
            self.clean()
        self.data = pd.read_csv(filepath_or_buffer=filepath, header=header, names=names, sep=sep, decimal=decimal, index_col=index_col, usecols=usecols, encoding=encoding, engine=engine)
        self.nameX = self.data.columns[0]
        self.nameY = self.data.columns[1]
        self.title = title
        self.filepath = filepath
        # self.lenght = len(self.data)

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
        return self.filepath, self.title, self.nameX, self.nameY #, self.lenght

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
        mod = stats.mode(self.data[name])
        return str(mod.mode[0]) + ':' + str(mod.count[0])

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
        plt.tight_layout()
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
        plt.tight_layout()
        return fig

    def genInfoX(self, n=4):
        self.infoX['graph'] = self.histogram(self.nameX)
        self.infoX['mean'] = round(float(self.getMean(self.nameX)), n)
        self.infoX['mode'] = self.getMode(self.nameX)
        self.infoX['median'] = round(float(self.getMedian(self.nameX)), n)
        self.infoX['std'] = round(float(self.getStd(self.nameX)), n)
        self.infoX['dis'] = round(float(self.getDispersion(self.nameX)), n)
        self.infoX['var'] = round(float(self.getVariation(self.nameX)), n)
        self.infoX['skew'] = round(float(self.getSkew(self.nameX)), n)
        self.infoX['kurt'] = round(float(self.getKurtosis(self.nameX)), n)
        self.infoX['ready'] = True

    def genInfoY(self, n=4):
        self.infoY['graph'] = self.histogram(self.nameY)
        self.infoY['mean'] = round(float(self.getMean(self.nameY)), n)
        self.infoY['mode'] = self.getMode(self.nameY)
        self.infoY['median'] = round(float(self.getMedian(self.nameY)), n)
        self.infoY['std'] = round(float(self.getStd(self.nameY)), n)
        self.infoY['dis'] = round(float(self.getDispersion(self.nameY)), n)
        self.infoY['var'] = round(float(self.getVariation(self.nameY)), n)
        self.infoY['skew'] = round(float(self.getSkew(self.nameY)), n)
        self.infoY['kurt'] = round(float(self.getKurtosis(self.nameY)), n)
        self.infoY['ready'] = True

    def genInfoXY(self, n=4):
        self.infoXY['graph'] = self.scatter()
        self.infoXY['ready'] = True

    def genInfoRegress(self):
        lr = LinearRegression()
        lr.fit(self.data[[self.nameX]], self.data[[self.nameY]])
        self.infoReg['coef'] = float(lr.coef_[0][0])
        self.infoReg['intercept'] = float(lr.intercept_)
        self.infoReg['R2'] = float(lr.score(self.data[[self.nameX]], self.data[[self.nameY]]))
        self.infoReg['R'] = float(self.infoReg['R2'] ** 0.5)
        self.infoReg['std'] = float(self.getStd(self.nameX))
        self.infoReg['count'] =self.data.shape[0]
        urav = "y = {:.2f}*x{:+.2f}".format(self.infoReg['coef'], self.infoReg['intercept'])

        fig, ax = plt.subplots(figsize=(7.3, 3.8))
        ax.scatter(self.data[self.nameX],
                   self.data[self.nameY], marker='o', color='red')
        plt.plot(self.data[self.nameX], lr.predict(self.data[[self.nameX]]), color='green')
        # шрифт цифр осей
        ax.tick_params(axis='both', which='major', labelsize=12)

        plt.grid(ls=':')
        plt.xlabel(self.nameX, fontsize=13)
        plt.ylabel(self.nameY, fontsize=13)
        plt.title(urav, fontsize=20)
        plt.tight_layout()
        self.infoReg['graph'] = fig
        self.infoReg['ready'] = True

    def genInfoCrit(self, n=4):
        h = sorted(self.data[self.nameX])
        fit = stats.norm.pdf(h, np.mean(h), np.std(h))
        pir_k, pir_p = stats.pearsonr(h, fit)
        kol_k, kol_p = stats.kstest(self.data[self.nameX], 'norm')
        self.infoCrit['kolm']['k'] = round(float(kol_k), n)
        self.infoCrit['kolm']['p'] = round(float(kol_p), n)
        self.infoCrit['pirs']['k'] = round(float(pir_k), n)
        self.infoCrit['pirs']['p'] = round(float(pir_p), n)
        self.infoCrit['ready'] = True

    def genInfoDisp(self):

        # self.infoDisp['f'] =
        # self.infoDisp['p'] =
        self.infoDisp['ready'] = True

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


    # REPORT
    def encodePNG(self, img_file):
        with open(img_file, 'rb') as file:
            encode_str = base64.b64encode(file.read())
            return encode_str.decode("utf-8")

    def decodePNG(self, bs64_str, img_file):
        with open(img_file, 'wb') as file:
            file.write(base64.b64decode(bs64_str))

    def loadTemplateFile(self, template_file):
        with open(template_file, 'r') as file:
            self.template = Template(file.read())

    def genImg(self, label, src):
        return {
            'type': "image",
            'label': label,
            'src': src
            }

    def genTableChar(self, label, mean, mode, median, std, dis, var, skew, kurt):
        return {
            'type': "table-charact",
            'label': label,
            'mean': mean,
            'mode': mode,
            'median': median,
            'std': std,
            'dis': dis,
            'var': var,
            'skew': skew,
            'kurt': kurt
        }

    def genTableRegress(self, label, equation, k_reg, R2, R, std, count):
        return {
            'type': "table-regress",
            'label': label,
            'coef': k_reg,
            'R2': R2,
            'R': R,
            'std': std,
            'count': count
        }

    def genTableCrits(self, label, D1, pvl1, D2, pvl2):
        return {
            'type': "table-crits",
            'label': label,
            'kolm': {
                'k': D1,
                'p': pvl1
                },
            'pirs': {
                'k': D2,
                'p': pvl2
                }
        }

    def genTableDisp(self, label, f, p):
        return {
            'type': "table-dispers",
            'label': label,
            'name': self.title,
            'f': f,
            'p': p
        }

    def genReport(self, content, html_file):
        self.loadTemplateFile("templates/template.html")
        html = self.template.render(name=self.title, content=content)
        with open(html_file, 'w') as file:
            file.write(html)

