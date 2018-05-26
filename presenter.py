import os

class Presenter():

    def __init__(self, view, model):
        if not os.path.exists("plots"):
            os.makedirs("plots")
        self._view = view
        self._model = model

        self._view.openFileClick.connect(self._view_openFileClick)

        self._view.loadCharact.connect(self._view_loadCharact)
        self._view.loadX.connect(self._view_loadX)
        self._view.loadY.connect(self._view_loadY)
        self._view.loadXY.connect(self._view_loadXY)

        self._view.reportClick.connect(self._view_reportClick)


    def _view_openFileClick(self):
        path = self._view.pfl_getFilePath()

        sep = self._view.pfl_getSeparator()
        decimal = self._view.pfl_getDecimalSym()
        names = None
        header = None
        titleX = "none"
        titleY = "none"
        title = "none"
        if not self._view.pfl_haveNames():
            names = self._view.pfl_getNames()
            titleX = names[0]
            titleY = names[1]
        else:
            header = 0

        if not self._view.pfl_haveTitle():
            title = os.path.basename(path)
        else:
            title = self._view.pfl_getTitle()

        load_str = '''Загружается файл:
        Путь к файлу: %s
        Название: %s
        Есть ли заголок в файле: %s
        Новые заголовки (если заданы):
            Заголовок 1: %s
            Заголовок 2: %s
        Разделитель: %s
        Десятичный разделитель: %s
        ''' % (path, title, str(header == 0 or "none"), str(titleX), str(titleY), sep, decimal)

        print(load_str)

        try:
            self._model.loadFile(path, title, header, names, sep, decimal)
        except Exception as e:
            self._view.showMessage("Не удалось загрузить данные из файла!")
            print(str(e))
            self._view.lock()
        else:
            self._view.unlock()


    def _view_loadCharact(self):
        if (not self._model.infoX['ready']): 
            self._model.genInfoX()
        if (not self._model.infoY['ready']): 
            self._model.genInfoY()
        if (not self._model.infoXY['ready']): 
            self._model.genInfoXY()
        self._view.pch_insertlabels(self._model.nameX, self._model.nameY)
        self._view_loadXY()

    def _view_loadX(self):
        if (not self._model.infoX['ready']): 
            self._model.genInfoX()
        source = "../" + self._model.savefig(self._model.infoX['graph'], self._model.title + "-histX", "plots/")
        self._view.pch_setgraphsource(source)
        self._view.pch_insertvalues(self._model.infoX['mean'], self._model.infoX['mode'], self._model.infoX['median'],
                                    self._model.infoX['std'], self._model.infoX['dis'], self._model.infoX['var'],
                                    self._model.infoX['skew'], self._model.infoX['kurt'])

    def _view_loadY(self):
        if (not self._model.infoY['ready']): 
            self._model.genInfoY()
        source = "../" + self._model.savefig(self._model.infoY['graph'], self._model.title + "-histY", "plots/")
        self._view.pch_setgraphsource(source)
        self._view.pch_insertvalues(self._model.infoY['mean'], self._model.infoY['mode'], self._model.infoY['median'],
                                    self._model.infoY['std'], self._model.infoY['dis'], self._model.infoY['var'],
                                    self._model.infoY['skew'], self._model.infoY['kurt'])

    def _view_loadXY(self):
        if (not self._model.infoXY['ready']): 
            self._model.genInfoXY()
        source = "../" + self._model.savefig(self._model.infoXY['graph'], self._model.title + "-scatter", "plots/")
        self._view.pch_setgraphsource(source)

    def _view_reportClick(self):
        elements = self._view.prp_getList()
        # elements = {
        # # Графики
        # 'graphX': False,
        # 'graphY': False,
        # 'graphXY': False,
        # # Числовые хар-ки
        # 'charX': False,
        # 'charY': False,
        # # Критерии
        # 'critPir': False,
        # 'critKol': False,
        # # Регрессия
        # 'regGraph': False,
        # 'regStat': False,
        # # Дисперсия
        # 'dispers': False
        # }
        content = []

        if elements['graphXY'] :
            if (not self._model.infoXY['ready']): 
                self._model.genInfoXY()
            source = "../" + self._model.savefig(self._model.infoXY['graph'], self._model.title + "-scatter", "plots/")
            src = self._model.encodePNG(source)
            img = genImg("График выборки", src)
            content.append(img)

        if elements['graphX'] :
            if (not self._model.infoX['ready']): 
                self._model.genInfoX()
            source = "../" + self._model.savefig(self._model.infoX['graph'], self._model.title + "-histX", "plots/")
            src = self._model.encodePNG(source)
            img = genImg("Гистограмма " + self._model.nameX, src)
            content.append(img)

        if elements['charX'] :
            if (not self._model.infoX['ready']): 
                self._model.genInfoX()
            table = self._model.genTableChar(self._model.infoX['mean'], self._model.infoX['mode'], self._model.infoX['median'],
                                    self._model.infoX['std'], self._model.infoX['dis'], self._model.infoX['var'],
                                    self._model.infoX['skew'], self._model.infoX['kurt'])
            content.append(table)

        if elements['graphY'] :
            if (not self._model.infoY['ready']): 
                self._model.genInfoY()
            source = "../" + self._model.savefig(self._model.infoY['graph'], self._model.title + "-histY", "plots/")
            src = self._model.encodePNG(source)
            img = genImg("Гистограмма " + self._model.nameY, src)
            content.append(img)

        if elements['charY'] :
            if (not self._model.infoY['ready']): 
                self._model.genInfoY()
            table = self._model.genTableChar(self._model.infoY['mean'], self._model.infoY['mode'], self._model.infoY['median'],
                        self._model.infoY['std'], self._model.infoY['dis'], self._model.infoY['var'],
                        self._model.infoY['skew'], self._model.infoY['kurt'])
            content.append(table)


        if elements['critPir'] :
            pass
        if elements['critKol'] :
            pass
        if elements['regGraph'] :
            pass
        if elements['regStat'] :
            pass
        if elements['dispers'] :
            pass

        self._model.genReport(content, html_file)
