import os
import pandas


class Model():

    def __init__(self):
        self.data = None

    def fileExist(self, path):
        return os.path.isfile(path)

    def loadFile(path, sep, decimal, header, names, encoding='utf_8'):
        self.data = pd.read_csv(filepath_or_buffer=path, header=header, names=names, sep=sep, encoding=encoding)



