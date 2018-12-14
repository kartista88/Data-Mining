import numpy as np
import pandas as pd
from pandas import read_csv
from numpy import transpose as tp
from numpy import matmul as mul

x = read_csv('./NN_Datasets/face_x.txt', header=None, delimiter=' ').values
y = read_csv('./NN_Datasets/face_y.txt', header=None, delimiter=' ').values

w = tp(2*np.random.rand(x.shape[1],1) - 1)
b = 2*np.random.rand(1,1) - 1

f = tp(mul(w,tp(x)))-b

err = np.sum(y*f <= 0)
print(err)
