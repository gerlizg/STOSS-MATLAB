function [Matrix, y_relaxation] = iteration_process (state_vector, x, y, N_ex, final_step, B, part) 

    if (part==1)
        
        temp = single(zeros (N_ex, final_step));
        Matrix = [state_vector, temp];
    else
        Matrix = single(zeros (N_ex, final_step));
    end

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