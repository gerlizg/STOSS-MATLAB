function [V_1_1, V_1_0, V_0_1, V_0_0, association_phi] =  td (number, spin_1, spin_2)

    spin2 = spin_2 (number:end);
    spin1 = spin_1 (1:length(spin2));

    V_1_1 = 0;
    V_1_0 = 0;
    V_0_1 = 0;
    V_0_0 = 0;
    
    for i = 1:length (spin1)
        
        if (spin1(i) == 0 && spin2(i) == 0)
             V_0_0 = V_0_0 + 1;
             
        elseif (spin1(i) == 1 && spin2(i) == 0)
             V_1_0 = V_1_0 + 1;
             
        elseif (spin1(i) == 1 && spin2(i) == 1)
             V_1_1 = V_1_1 + 1;
        
        else
            V_0_1 =  V_0_1 + 1;
            
        end
        
        N1 = V_1_0 + V_1_1;
        N2 = V_0_0 + V_0_1;
        N3 = V_0_0 + V_1_0;
        N4 = V_0_1 + V_1_1;

        association_phi = ((V_0_0 * V_1_1) - (V_0_1 * V_1_0)) / ((N1 * N2 * N3 * N4)^0.5);
        
    end
    