function state = mean_matrix_state (difference, N_ex, time_steps, factor)
    
    %---------------------------------------------------------------    
    % Obtaining the collective behaviour through the threshold
    %---------------------------------------------------------------
    
    state = single(zeros(1,time_steps)); 
    
    for i = 1 :time_steps
       if (difference (i) >= round(N_ex/factor))
            state (i) = 1;
       end
       
    end