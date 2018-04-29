import random

def modern_lab(sep=';', decimal=','):
    with open("test.csv", 'w') as file:
        with open("lab.csv", 'r') as lab:
            file.write(lab.readline())
            for line in lab:
                l = line.split(';')
                s = l[0] + decimal + str(random.randint(1, 99)) + sep + l[1].strip(
                    '\n') + decimal + str(random.randint(1, 99)) + '\n'
                file.write(s)

# modern_lab()

from model import Model
import os

model = Model()

FILE_PATH = "/home/bazik/Projects/DataAnalyzer/test.csv"
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

model.loadfile(FILE_PATH, TITLE, HEADER, NAMES, SEP, DECIMAL)

inf_file = model.getInfoFile()
s_inf_file = '''Путь к файлу: %s
Название: %s
Заголовок X: %s
Заголовок Y: %s
Размер: %s
''' % inf_file

print(s_inf_file)

# inf_data = model.getСharacteristics()

# s_inf_data = '''X max: %f
# X min: %f
# Матем ожидание: %f
# Медиана: %f
# Мода: %f
# Дисперсия: %f
# Ср кв отклонение: %f
# Асимметрия: %f
# Коэф асимметрии: %f
# Коэффициент вариации: %f
# Эксцесс: %f
# Коэф эксцесса: %f''' inf_data

print(model.getMean())
print(model.getMedian())
# print(model.getModes())
print(model.getStd())
print(model.getVar())
print(model.getVariation())

if not os.path.exists("plots"):
    os.makedirs("plots")

print(model.createScatter("plots/"))

