function [steps, tau_mag, probability, total_time, time_vector] = mag_relaxation (Ueff, tau_0, C, n, tau_QTM, T, time_steps)

    %--------------------------------------------------------------------------
    % Relaxation time of magnetization, (s):
    %--------------------------------------------------------------------------

    if (tau_QTM == 0)
        tau_mag = ((((C)*(T^n)))+(((exp(-Ueff/T))/tau_0)))^-1;
    else
        tau_mag = ((((C)*(T^n)))+(tau_QTM^-1)+(((exp(-Ueff/T))/tau_0)))^-1;
    end

    total_time = (tau_mag * 20);

    %--------------------------------------------------------------------------
    % Steps calculated from the total time:
    %--------------------------------------------------------------------------

    steps = total_time/time_steps;
    tau_exp = tau_mag/steps;
    probability  = total_probability (tau_exp);
    time_vector = single(0:steps:total_time);

end