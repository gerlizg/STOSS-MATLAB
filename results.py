import pandas as pd

def results (Matrix, y_relaxation, t, B, flag, time_steps, part):
    
    
    y_relaxation = y_relaxation.astype(int)
    Matrix = Matrix.astype(int)
    
    
    if flag == 2:
        extension = '_2.csv'
    else: 
        extension = '_1.csv'
        
    if time_steps <= 4500:
    
        Matrix_copy = pd.DataFrame(Matrix)
        Matrix_copy.to_csv('Matrix'+ extension, index=False)
      
        y_relaxation_copy = pd.DataFrame(y_relaxation)
        y_relaxation_copy.to_csv('y_relaxation' + extension, index=False)         
        
    else:
               
        y_relaxation_copy = pd.DataFrame(y_relaxation)
        y_relaxation_copy.to_csv('y_relaxation_part_' + str (int(part)) + extension, index=False)
          
    
    if part == 1:
        time_copy = pd.DataFrame(t)
        time_copy.to_csv('time' + extension, index=False)
              
        B_copy = pd.DataFrame(B)
        B_copy.to_csv('B' + extension, index=False)
      
    