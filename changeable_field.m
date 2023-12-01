function [y_relaxation, B_2pbit, up, down, difference, conditional] = changeable_field (B_2pbit, N_ex, time_steps, B, x, y, starting_mode, B_pbit2, flag, factor, option_2spin, save, t)

	%-------------------------------------------------
    %   Defining the parameters:
    %-------------------------------------------------
    conditional = uint8(N_ex/factor);
       
    %-------------------------------------------------
    %   Creating the lists:
    %-------------------------------------------------

    state_vector = single(zeros (N_ex, 1));                                  % Contains all the states (0, 1)  
    up = single(zeros (1,time_steps));                                           % Spins in the excited state 
    down = single(zeros (1,time_steps));                                         % Spins in the ground state 
    difference = single(zeros (1,time_steps));
       
    %-------------------------------------------------                
    %   Iteration over the Matrix
    %-------------------------------------------------
    
    % Initializating spins in a specific state:
    
    if (starting_mode ~= 0)
        for i = 1:N_ex * starting_mode
            state_vector (i) =  1;
        end
    end
    
    if (time_steps <= 4500)
        
        [Matrix, y_relaxation] = iteration_process (state_vector, x, y, N_ex, time_steps, B, 1, save, time_steps, flag);
    else
        final_step = round (time_steps/3);
        [Matrix_1, y_relaxation_1] = iteration_process (state_vector, x(1:final_step), y(1:final_step), N_ex, final_step, B, 1, save, time_steps, flag);
        [Matrix_2, y_relaxation_2] = iteration_process (Matrix_1, x(final_step+1:final_step*2), y(final_step+1:final_step*2), N_ex, final_step, B, 2, save, time_steps, flag);
        [Matrix_3, y_relaxation_3] = iteration_process (Matrix_2, x(final_step*2+1:end), y(final_step*2+1:end), N_ex, final_step, B, 3, save, time_steps, flag);
        
        y_relaxation = [y_relaxation_1, y_relaxation_2, y_relaxation_3];
        
    end
        
    %-------------------------------------------------    
    %   Relaxation curve:
    %-------------------------------------------------
        
    if (option_2spin == 1)
        
        
        for i= 1:time_steps-1
            down (i) = y_relaxation (i); 
            up(i) = N_ex - down (i);
            difference (i) = up (i) - down (i);
            
            if (difference (i) >= conditional)                           
                B_2pbit (i) =  B_pbit2;
            end
                
        end
                   
        mean_value = mean (B_2pbit);
        B_2pbit = B_2pbit - mean_value;
    end
	
    %-------------------------------------------------
    %               Saving the data 
    %-------------------------------------------------
    %{
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
        csvwrite('Matrix1_'+ extension, Matrix_1);
        
        %Matrix_copy_2 = table(Matrix_2);
        csvwrite('Matrix2_'+ extension, Matrix_2);
        
        %Matrix_copy_3 = table(Matrix_3);
        csvwrite('Matrix3_'+ extension, Matrix_3);
        %{     
        varNames = {'TIME (S)','MAGNETIC FIELD (T)','MU (A.U.)'};
        table_new = table (t, B, y_relaxation, 'VariableNames', varNames);
        xlswrite('Simulation_Results'+ extension, table_new);
        %}
    end    
    %}
    
end


    