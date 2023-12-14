# -*- coding: utf-8 -*-
"""
Created on Tue Dec 12 16:34:30 2023

@author: Principal
"""

import scipy.io
import pandas as pd

Matrix = scipy.io.loadmat('Matrix.mat')  
Matrix = Matrix.get("Matrix")
Matrix_copy = pd.DataFrame(Matrix)
Matrix_copy.to_csv('Matrix.csv', index=False)
  
