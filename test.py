import pandas as pd 
import matplotlib
import matplotlib.pyplot as plt

font = {'family' : 'Roboto',
        'size'   : 20}

matplotlib.rc('font', **font)
data = pd.read_csv('data.csv')
print(data)
fig = plt.figure(facecolor = '#e9403d') #fd930b') #54ad58')
ax  = fig.add_subplot(1, 1, 1)
ax.grid(color='white', linestyle='--', linewidth=1, alpha = 0.3)
ax.set_axisbelow(True)
#ax.hist(data['X'], 50, normed='True', color = 'white', edgecolor = 'white')
#ax.hist(data['Y'], 50, normed='True', color = 'white', edgecolor = 'white')
ax.scatter(data['X'],data['Y'], color = 'white')
ax.spines['bottom'].set_visible(False)
ax.spines['top'].set_visible(False)
ax.spines['left'].set_visible(False)
ax.spines['right'].set_visible(False)
ax.xaxis.label.set_color('white')
ax.tick_params(axis='x', colors='white')
ax.tick_params(axis='y', colors='white')
ax.set_facecolor( '#e9403d') #'#fd930b') #54ad58')
plt.show()
