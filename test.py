# import random

# def modern_lab(sep=';', decimal=','):
#     with open("test.csv", 'w') as file:
#         with open("lab.csv", 'r') as lab:
#             file.write(lab.readline())
#             for line in lab:
#                 l = line.split(';')
#                 s = l[0] + decimal + str(random.randint(1, 99)) + sep + l[1].strip(
#                     '\n') + decimal + str(random.randint(1, 99)) + '\n'
#                 file.write(s)

# # modern_lab()

# from model import Model
# import os

# model = Model()

# FILE_PATH = "/home/bazik/Projects/DataAnalyzer/lab.csv"
# HEADER = 0
# NAMES = ['Height', 'Weight']
# SEP = ';'
# DECIMAL = ','
# TITLE = ""

# if TITLE == '' or TITLE is None:
#     TITLE = os.path.basename(FILE_PATH)

# if FILE_PATH == "":
#     print("Выберите файл!")

# if not os.path.isfile(FILE_PATH):
#     print("Файл \"{}\" не найден!".format(FILE_PATH))

# model.loadfile(FILE_PATH, TITLE, HEADER, NAMES, SEP, DECIMAL)

# inf_file = model.getInfoFile()
# s_inf_file = '''Путь к файлу: %s
# Название: %s
# Заголовок X: %s
# Заголовок Y: %s
# Размер: %s
# ''' % inf_file

# print(s_inf_file)

# # inf_data = model.getСharacteristics()

# # s_inf_data = '''X max: %f
# # X min: %f
# # Матем ожидание: %f
# # Медиана: %f
# # Мода: %f
# # Дисперсия: %f
# # Ср кв отклонение: %f
# # Асимметрия: %f
# # Коэф асимметрии: %f
# # Коэффициент вариации: %f
# # Эксцесс: %f
# # Коэф эксцесса: %f''' inf_data

# # print(model.getMean(model.nameX))
# # print(model.getMedian(model.nameX))
# print(model.getMode(model.nameX))
# # print(model.getStd(model.nameX))
# # print(model.getDispersion(model.nameX))
# # print(model.getVariation(model.nameX))

# if not os.path.exists("plots"):
#     os.makedirs("plots")

# model.savefig(model.scatter(), "scatter", "plots/")
# model.savefig(model.histogram(model.nameX), "histogram-X", "plots/")
# # print(model.createScatter("plots/"))

# # import pandas as pd 
# # import matplotlib
# # import matplotlib.pyplot as plt

# # font = {'family' : 'Roboto',
# #         'size'   : 20}

# # matplotlib.rc('font', **font)
# # data = pd.read_csv('data.csv')
# # print(data)
# # fig = plt.figure(facecolor = '#e9403d') #fd930b') #54ad58')
# # ax  = fig.add_subplot(1, 1, 1)
# # ax.grid(color='white', linestyle='--', linewidth=1, alpha = 0.3)
# # ax.set_axisbelow(True)
# # #ax.hist(data['X'], 50, normed='True', color = 'white', edgecolor = 'white')
# # #ax.hist(data['Y'], 50, normed='True', color = 'white', edgecolor = 'white')
# # ax.scatter(data['X'],data['Y'], color = 'white')
# # ax.spines['bottom'].set_visible(False)
# # ax.spines['top'].set_visible(False)
# # ax.spines['left'].set_visible(False)
# # ax.spines['right'].set_visible(False)
# # ax.xaxis.label.set_color('white')
# # ax.tick_params(axis='x', colors='white')
# # ax.tick_params(axis='y', colors='white')
# # ax.set_facecolor( '#e9403d') #'#fd930b') #54ad58')
# # plt.show()

from jinja2 import Template

tmpl_file = open("templates/template.html")
tmpl_html = tmpl_file.read()
tmpl_file.close()

template = Template(tmpl_html)


def tmpl_img(label, src):
	img = {
		'type': "image",
		'label': label,
		'src': src
		}
	return img

def tml_char(label, mean, mode, median, std, dis, var, skew, kurt):
	tbl = {
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
	return tbl

def tml_regress(label, equation, k_reg, R2, R, param1, param2):
	tbl = {
		'type': "table-regress",
		'label': label,
		'k_reg': k_reg,
		'R2': R2,
		'R': R,
		'param1': param1,
		'param2': param2
	}
	return tbl

def tml_content(params=None):
	content = [ 
		tmpl_img("Ghb", "x.png"),
		tml_char("uysff", 1, 2, 3, 4, 5, 6, 7, 8),
		tml_char("!!!!!", 1, 2 ,3, 4, 5, 6, 7, 8),
		tmpl_img("Ghb", "x.png")
	]
	return content

# html = template.render(name="TEST", content=tml_content())

# print(html)


import base64

def encodePNG(self, img_file):
	file = open(img_file, 'rb')
	b64 = base64.b64encode(file.read())
	file.close()
	return b64.decode("utf-8")

def decodePNG(self, bs64_str, img_file):
	file = open(img_file, 'wb')
	file.write(base64.b64decode(bs64_str))
	file.close()

# html_file = open("file.html", 'w') 
# html_file.write(html)
# html_file.close()


from jinja2 import Template
import base64

class ReportConstructor():

	def __init__(self, model):
		self.template = ""
		self._model = model

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

	def genImg(label, src):
		return {
			'type': "image",
			'label': label,
			'src': src
			}

	def genTableChar(label, mean, mode, median, std, dis, var, skew, kurt):
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

	def genTableRegress(label, equation, k_reg, R2, R, param1, param2):
		return {
			'type': "table-regress",
			'label': label,
			'k_reg': k_reg,
			'R2': R2,
			'R': R,
			'param1': param1,
			'param2': param2
		}

	def genContent(params=None):
		content = []
		content = [ 
			tmpl_img("Ghb", "x.png"),
			tml_char("uysff", 1, 2, 3, 4, 5, 6, 7, 8),
			tml_char("!!!!!", 1, 2 ,3, 4, 5, 6, 7, 8),
			tmpl_img("Ghb", "x.png")
		]
		return content

	def genReport(self, name, elements, html_file):
		content = genContent(elements)
		html = template.render(name=name, content=content)
		with open(html_file, 'w') as file:
			file.write(html)
