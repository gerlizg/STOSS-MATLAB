function [B, P_ij, x, y, E, vao] = Bolztmann_distribution (B_max, B_2pbit, g_Dy, T, time_steps, option, B_constant, cycles, probability)

    %--------------------------------------------------------------------
    %   Defining the parameters:
    %--------------------------------------------------------------------
    
    miu_B = 0.67167;                                             % Bohr magneton                      
    Mj = 7.5;                                                    % Spin Projection       
  
    % Vector that will contain the probability for spin flipping
    vao = single(ones(1, 2));               
    vao(1) = probability;
    
    %--------------------------------------------------------------------    
    %   Creating vectors:
    %--------------------------------------------------------------------
    
    B = single(ones(1,time_steps));                          % Magnetic field
    x = single(ones(1,time_steps));                           % Probability of changing to state 1
    y = single(ones(1,time_steps));                         % Probability of changing to state 0
      
    if (option ~= 0)  % Changeable field or two pbits network
    
        P_ij = single(ones(1,time_steps));         % Bolztman distribution 
        E = single(ones(1,time_steps));            % Energy
            
        for i = 1: time_steps
        
            if (option == 1)
                
                % Calculating the field using the cosine function:
                % Where B = Bmax (amplitude) * cos (time[i]*360/time_steps )
                B(i) = B_max * cos (((pi/2))+ (i * cycles * 2 * (pi) / time_steps));
                %B(i) = B_max * cos ((deg2rad(pi/2))+ (i * cycles * 2 * deg2rad(pi) / time_steps));
                
            else
                
                % Calculating the field using the result for the pbit1:
                B(i) = B_2pbit(i);
            end
            
            % Calculating the energy through the equation 1:
            E(i) = abs(2 * Mj * g_Dy * miu_B * B(i));
            
            
            % Calculating the Bolztmann distribution:       
            P_ij(i) = 1 / (exp(E(i)/T));
            vao (2) = P_ij(i);
                  
            % Calculating the ratio between the two states for changing:
            [x(i), y(i)] =  solve_single_p(vao);

         end
       
        
    else  %Constant field                             
    
        % Calculating the energy through the equation 1:
        E = 2 * Mj * g_Dy * miu_B * B_constant;

        % Calculating the Bolztmann distribution:       
        P_ij = 1/(exp(E/T));
        vao(2) = P_ij;

        % Calculating the ratio between the two states for changing:
        [xx, yy] =  solve_single_p(vao);
  
        x = xx * x;
        y = yy * y;
        B = B * B_constant;
        
        %for i = 1: time_steps
            
         %   [x(i), y(i), B(i)] = [xx, yy, B_constant];
        
        %end
            
    end
    
end
            
        