function [Matrix, y_relaxation] = iteration_process (state_vector, x, y, N_ex, final_step, B, part, save, time_steps, flag) 
  
    temp = single(zeros (N_ex, final_step-1));
    Matrix = [state_vector, temp];  
    
% For each spin:
    
    for i = 1:N_ex
                 
        random_n = rand(final_step,1);
                
        % For each step:
                     
        for j = 2:final_step
         
            if (B(j)>=0)  % Positive Magnetic Field
            
                % Changing the state from 1 to 0:
                
                if (random_n (j)<x(j) && Matrix(i, j-1) == 1)
                    Matrix(i,j) = 0;
                                        
                % Changing the state from 0 to 1:
                
                elseif (random_n (j)<y(j) && Matrix(i, j-1) == 0)  
                    Matrix(i,j) = 1;
                                        
                else 
                    Matrix(i,j) = Matrix(i, j-1);
                end
                    
            else       % Negative Magnetic Field
            
                % Changing the state from 1 to 0:
                
                if (random_n (j)<y(j) && Matrix(i, j-1) == 1)    
                    Matrix(i,j) = 0;
                                      
                % Changing the state from 0 to 1:
                
                elseif (random_n (j)<x(j) && Matrix(i, j-1) == 0)  
                    Matrix(i,j) = 1;
                                        
                else
                    Matrix(i,j) = Matrix(i, j-1);
                end
            end
            
        end
        
    end
    
    %-------------------------------------------------    
    %   Relaxation curve:
    %-------------------------------------------------
    
    column = sum(Matrix);
    y_relaxation = single(N_ex - column);
    y_relaxation = y_relaxation(1:final_step);
    
    if (flag == 2)
            extension = "_2.csv";
    else 
            extension = "_1.csv";
    end
     
    if (save == 1 && time_steps <= 4500)   
               
        
        name = "Matrix" + extension;
        csvwrite(name, Matrix);
        %{    
        varNames = {'TIME (S)','MAGNETIC FIELD (T)','MU (A.U.)'};
        table_new = table (t, B, y_relaxation, 'VariableNames', varNames);
        name_table = "Simulation_Results" + extension;
        xlswrite(name_table, table_new);
        %}     
    elseif (save == 1 && time_steps > 4500) 
        
        %Matrix_copy_1 = table(Matrix_1);
        name = "Matrix" + string (part) + extension;
        csvwrite(name, Matrix);
                %{     
        varNames = {'TIME (S)','MAGNETIC FIELD (T)','MU (A.U.)'};
        table_new = table (t, B, y_relaxation, 'VariableNames', varNames);
        xlswrite('Simulation_Results'+ extension, table_new);
        %}
    end
    
    Matrix = Matrix(:,end);
    temp = 0;


