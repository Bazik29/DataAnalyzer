import os
import pandas


class Model():

    def __init__(self):
        pass

    def fileExist(self, path):
        return os.path.isfile(path)

    def loadFile(self, path):
        self.data = pd.read_csv(path,
                                sep=';', encoding='latin1',
                                parse_dates=['Date'], dayfirst=True,
                                index_col='Date')



