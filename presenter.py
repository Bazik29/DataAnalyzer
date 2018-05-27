import os

from datetime import datetime

class Presenter():

    def __init__(self, view, model):
        if not os.path.exists("plots"):
            os.makedirs("plots")
        if not os.path.exists("Reports"):
            os.makedirs("Reports")
        self._view = view
        self._model = model

        self._view.openFileClick.connect(self._view_openFileClick)

        self._view.loadCharact.connect(self._view_loadCharact)
        self._view.loadX.connect(self._view_loadX)
        self._view.loadY.connect(self._view_loadY)
        self._view.loadXY.connect(self._view_loadXY)

        self._view.loadRegress.connect(self._view_loadRegress)
        self._view.loadCrits.connect(self._view_loadCrits)
        self._view.loadDisper.connect(self._view_loadDisper)
        self._view.loadReport.connect(self._view_loadReport)

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

        # load_str = '''Загружается файл:
        # Путь к файлу: %s
        # Название: %s
        # Есть ли заголок в файле: %s
        # Новые заголовки (если заданы):
        #     Заголовок 1: %s
        #     Заголовок 2: %s
        # Разделитель: %s
        # Десятичный разделитель: %s
        # ''' % (path, title, str(header == 0 or "none"), str(titleX), str(titleY), sep, decimal)

        # print(load_str)

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

    def _view_loadRegress(self):
        if (not self._model.infoReg['ready']): 
                self._model.genInfoRegress()
        source = "../" + self._model.savefig(self._model.infoReg['graph'], self._model.title + "-regress", "plots/")
        self._view.preg_setgraphsource(source)

        urav = "y = {:.2f}*x{:+.2f}".format(self._model.infoReg['coef'], self._model.infoReg['intercept'])
        self._view.preg_insertvalues(urav, round(self._model.infoReg['R'], 4), round(self._model.infoReg['R2'], 4), round(self._model.infoReg['std'], 4), round(self._model.infoReg['coef'], 4), self._model.infoReg['count'])

    def _view_loadCrits(self):
        if (not self._model.infoCrit['ready']): 
                self._model.genInfoCrit()
        D1 = self._model.infoCrit['kolm']['k']
        pvl1 = self._model.infoCrit['kolm']['p']
        D2 = self._model.infoCrit['pirs']['k']
        pvl2 = self._model.infoCrit['pirs']['p']
        self._view.pcr_insertvalues(D1, pvl1, D2, pvl2)

    def _view_loadDisper(self):
        if (not self._model.infoDisp['ready']): 
            self._model.genInfoDisp()
        pass

    def _view_loadReport(self):
        self._view.prp_setlabels(self._model.nameX, self._model.nameY)

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
        # 'crits': False,
        # # Регрессия
        # 'regGraph': False,
        # 'regStat': False,
        # # Дисперсия
        # 'dispers': False
        # }
        # print(elements)
        content = []
        if elements['graphXY'] :
            if (not self._model.infoXY['ready']): 
                self._model.genInfoXY()
            source = self._model.savefig(self._model.infoXY['graph'], self._model.title + "-scatter", "plots/")
            src = self._model.encodePNG(source)
            img = self._model.genImg("График выборки", src)
            content.append(img)

        if elements['graphX'] :
            if (not self._model.infoX['ready']): 
                self._model.genInfoX()
            source = self._model.savefig(self._model.infoX['graph'], self._model.title + "-histX", "plots/")
            src = self._model.encodePNG(source)
            img = self._model.genImg("Гистограмма " + self._model.nameX, src)
            content.append(img)

        if elements['charX'] :
            if (not self._model.infoX['ready']): 
                self._model.genInfoX()
            table = self._model.genTableChar("Характеристики величины: " + self._model.nameX, self._model.infoX['mean'], self._model.infoX['mode'], self._model.infoX['median'],
                                    self._model.infoX['std'], self._model.infoX['dis'], self._model.infoX['var'],
                                    self._model.infoX['skew'], self._model.infoX['kurt'])
            content.append(table)

        if elements['graphY'] :
            if (not self._model.infoY['ready']): 
                self._model.genInfoY()
            source = self._model.savefig(self._model.infoY['graph'], self._model.title + "-histY", "plots/")
            src = self._model.encodePNG(source)
            img = self._model.genImg("Гистограмма " + self._model.nameY, src)
            content.append(img)

        if elements['charY'] :
            if (not self._model.infoY['ready']): 
                self._model.genInfoY()
            table = self._model.genTableChar("Характеристики величины: " + self._model.nameY, self._model.infoY['mean'], self._model.infoY['mode'], self._model.infoY['median'],
                        self._model.infoY['std'], self._model.infoY['dis'], self._model.infoY['var'],
                        self._model.infoY['skew'], self._model.infoY['kurt'])
            content.append(table)


        if elements['crits'] :
            if (not self._model.infoCrit['ready']): 
                self._model.genInfoCrit()
            D1 = self._model.infoCrit['kolm']['k']
            pvl1 = self._model.infoCrit['kolm']['p']
            D2 = self._model.infoCrit['pirs']['k']
            pvl2 = self._model.infoCrit['pirs']['p']

            table = self._model.genTableCrits("Нормальность распределения величины " + self._model.nameX, D1, pvl1, D2, pvl2)
            content.append(table)

        if elements['regGraph'] :
            if (not self._model.infoReg['ready']): 
                self._model.genInfoRegress()
            source = "../" + self._model.savefig(self._model.infoReg['graph'], self._model.title + "-regress", "plots/")
            src = self._model.encodePNG(source)
            img = self._model.genImg("График регрессии", src)
            content.append(img)

        if elements['regStat'] :
            if (not self._model.infoReg['ready']): 
                self._model.genInfoRegress()

            self.infoReg['coef']
            self.infoReg['intercept']
            self.infoReg['R2']
            self.infoReg['R']
            equation = "y = {k}*x + {b}".format(k=self.infoReg['coef'], b = self.infoReg['intercept'])
            table = self._model.genTableRegress(self, "Регрессионный анализ", equation, self.infoReg['coef'], self.infoReg['R2'], self.infoReg['R'], round(self._model.infoReg['std'], 4), self._model.infoReg['count'])
            content.append(table)

        if elements['dispers'] :
            # f =
            # p =
            # self._model.genTableDisp(f, p)
            pass

        # html_file = "Reports/" + self._model.title + '-' + datetime.today().isoformat() + '.html'
        html_file = "Reports/" + self._model.title + '.html'
        self._model.genReport(content, html_file)
