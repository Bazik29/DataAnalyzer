from model import Model
import os
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from scipy import stats
from itertools import combinations

class A():
    """docstatsring for ClassName"""
    def __init__(self, arg):
        pass

    def anova_ext(self, *args, **kwargs):

        def _arcsine_trans(*args):
            maxel = max(map(lambda x: np.max(np.abs(x)), args))
            return map(lambda x: np.arcsin(np.asarray(x)/maxel), args)
        
        def _log_trans(*args):
            minel = min(map(lambda x: np.min(x), args))
            return map(lambda x: np.log(np.asarray(x) - minel + 1.0), args)
            
        def _sqrt_trans(*args):
            minel = min(map(lambda x: np.min(x), args))
            return map(lambda x: np.sqrt(np.asarray(x) - minel + 1.0), args)
        
        def _identity_trans(*args): return args
            
        if 'alpha' not in kwargs:
            alpha = 0.05
        else: 
            alpha = kwargs['alpha']
        if 'transformations' not in kwargs:
            transformations = [('identity', _identity_trans),
                             ('arcsine', _arcsine_trans),
                             ('log', _log_trans),
                             ('sqrt', _sqrt_trans)]
        else:
            if 'identity' not in map(lambda x:x[1], transformations):
                transformations = [('identity', lambda x: x)] + kwargs['transformations']
            else:
                transformations = kwargs['transformations']
        
        def _check_normality(*args):
            for arg in args:
                if stats.shapiro(arg)[1] < alpha:
                    return False
            return True

        def _check_variance_equality_normal(*args):
            return stats.bartlett(*args)[1] > alpha
        
        def _check_variance_equality_nonnormal(*args):
            return stats.levene(*args)[1] > alpha

        dtuple = []
        priorities = []
        for tname, tfun in transformations:
            transformed = tfun(*args)
            if _check_normality(*transformed):
                if _check_variance_equality_normal(*transformed):
                    dtuple += [(tname, transformed, 'normal', 'equal')]
                    priorities.append(1)
                    break
                else:
                    if 1 in priorities: break
                    dtuple += [('identity', args, 'normal', 'unequal')]
                    priorities.append(2)
            else:
                if _check_variance_equality_nonnormal(*transformed):
                    if 2 in priorities: break
                    dtuple += [(tname, transformed, 'nonnormal', 'equal')]
                    priorities.append(3)
                else:
                    if 3 in priorities: break
                    dtuple += [('identity', args, 'nonnormal', 'unequal')]
                    priorities.append(4)
        if 1 in priorities:
            data = dtuple[priorities.index(1)]
            fstatsat, pval = stats.f_oneway(*data[1])
            return (fstatsat, pval, 'fisher', 'normal', 'equal', data[0])
        elif 2 in priorities:
            data = dtuple[priorities.index(2)]
            _pval = 1.0
            _fstatsat = 0.0
            for a, b in combinations(data[1], 2):
                fstatsat, pval = stats.ttestats_ind(a, b, equal_var=False)
                if _pval > pval:
                    _pval = pval
                    _fstatsat = fstatsat
            return (_fstatsat, _pval, 'welch-paired', 'normal', 'unequal', 'identity')
        elif 3 in priorities:
            data = dtuple[priorities.index(3)]
            fstatsat, pval = stats.f_oneway(*data[1])
            return (fstatsat, pval, 'fisher', 'nonnormal', 'equal', data[0])
        elif 4 in priorities:
            data = dtuple[priorities.index(4)]
            fstatsat, pval = stats.kruskal(*data[1])
            return (fstatsat, pval, 'kruskal', 'nonnormal', 'unequal', data[0])


model = Model()

model.loadFile('lab.csv', "TITLE", 0, None, ',')

a = model.data[model.nameX].values
b = model.data[model.nameY].values

D, F, _, _, _, _ = A.anova_ext(a, b)
