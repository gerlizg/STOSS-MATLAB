addpath('C:\Users\Principal\Documents\STOSS-MATLAB');
clear all
clc

%   STOSS - FIRST VERSION

%{
Ueff = 2217.2;
tau_0 = 4.20E-12;
C = 3.11E-08;
n = 3.01;
tau_QTM = 2.52E+04;
g_Dy = 1.33;
%}

%{
Ueff = 167.87;
tau_0 = 2.830E-09;
C = 0.078;
n = 4.9;
tau_QTM = 0.067;
g_Dy = 1.33;
%}

Ueff = 30.24;
tau_0 = 1.2E-07;
C = 0;
n = 0;
tau_QTM = 0;
g_Dy = 1.33;

% GENERAL CONFIGURATIONS:
%-------------------------------------
N_ex = 50000;                                      % Number of Spins of each p-bit
T = 4;                                               % Temperature, K
save = 1;                                            % 1: for saving results; 0: no
flag = 25;                                           % System to be studied from SIMDAVIS database
starting_mode = 0.5;                                 % Starting mode for all spins (0.5 = 50% spins in the lower state of energy)
time_steps = 6000;                                  % Total time steps
option = 0;                                          % 1: changeable field; 0: constant field 
option_2spin = 1;                                    % 1: yes; 0: no for the study of a p-bit network

% CONSTANT MAGNETIC FIELD:
%-------------------------------------
B_constant = 0;                                      % Applied magnetic field, Tesla. If only "option" = 0

% CHANGEABLE MAGNETIC FIELD:
%-------------------------------------
B_max = 0.00025;                                     % Maximum value for Magnetic Field, Tesla. If only "option" = 1
cycles = 4;                                          % Changeable field applied. If only "option" = 1 

% TWO P-BIT NETWORK:
%-------------------------------------
B_pbit2 = 0.02;                                         % Applied magnetic field, Tesla. If only "option_2spin" = 1
factor = 1000;                                          % Threshold for the definition of the collective state of each p-bit. If only "option_2spin" = 1
association_factor = 60;                        % How many delays the program will take into account
step_association = 1;                                   % How many steps of delay the program will take into account to reach the value of the previous variable
B_2pbit =(zeros(1,time_steps));

%-----------------------------------------------------------

%------------------
%   Timer:
%------------------

tic

%--------------------------------------------------------------------------
% Relaxation time of magnetization, (s):
%--------------------------------------------------------------------------
[steps, tau_mag, probability, total_time, time_vector] = mag_relaxation (Ueff, tau_0, C, n, tau_QTM, T, time_steps);

[B_1, P_ij_1, x_1, y_1, E_1, vao_1] = Bolztmann_distribution (B_max, B_2pbit, g_Dy, T, time_steps, option, B_constant, cycles, probability);

[y_relaxation_1, Matrix_1, B_2pbit_1, up_1, down_1, difference_1, conditional] = changeable_field (B_2pbit, N_ex, time_steps, B_1, x_1, y_1, starting_mode, B_pbit2, 1, factor, option_2spin);

%plotting (option, N_ex, B_1, y_relaxation_1, time_vector)  

disp ('-------------------------------------------------')
disp ('First p-bit has finished')
disp ('-------------------------------------------------')
disp ('*************************************************')

%--------------------------------------------------------------------
%   For p-bit network:
%--------------------------------------------------------------------

if (option_2spin == 1)
          
    [B_2, P_ij_2, x_2, y_2, E_2, vao_2] = Bolztmann_distribution (B_max, B_2pbit_1, g_Dy, T, time_steps, 2, B_constant, cycles, probability);
                                                                                                        
    [y_relaxation_2, Matrix_2, B_2pbit_2, up_2, down_2, difference_2, conditional] = changeable_field (B_2pbit, N_ex, time_steps, B_2, x_2, y_2, starting_mode, B_pbit2, 2, factor, option_2spin);
   
    disp ('-------------------------------------------------')
    disp ('Second p-bit has finished')
    disp ('-------------------------------------------------')
    disp ('*************************************************')

    
    state_1 = mean_matrix_state (difference_1, N_ex, time_steps, factor);
    state_2 = mean_matrix_state (difference_2, N_ex, time_steps, factor);

    disp ('-------------------------------------------------')
    disp ('Starting association analysis between both p-bits:')
    disp ('-------------------------------------------------')
    disp ('*************************************************')

    [V_1_1_t,  V_1_0_t, V_0_1_t, V_0_0_t, phi_t] = association (association_factor, state_1, state_2, step_association);
    disp ('-------------------------------------------------')
    disp ('Association analysis:')
    disp ('-------------------------------------------------')
    disp ('*************************************************')
    %disp (results)
    disp ('*************************************************')

else
    
    x_vector = 0; 
    association_results = 0;
    B_2 = 0;
    y_relaxation_2 = 0;
    state_1 = 0;
    state_2 = 0;

end

plotting (option, N_ex, B_1, B_2, y_relaxation_1, y_relaxation_2, time_vector, option_2spin, T, state_1, state_2, phi_t) ;
toc

%final = ['Execution time:', (time2-time1), ' seconds'];

%disp (final)