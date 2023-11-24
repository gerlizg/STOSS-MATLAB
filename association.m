%-------------------------------------------------

function [V_1_1_t,  V_1_0_t, V_0_1_t, V_0_0_t, phi_t] = association (number, state_1, state_2, step_association)
    
    vector_iter = 1: step_association: number;
    size_vector = length(vector_iter);

    V_1_1_t = single(zeros(1, size_vector));
    V_1_0_t = single(zeros(1, size_vector));
    V_0_1_t = single(zeros(1, size_vector));
    V_0_0_t = single(zeros(1, size_vector));
    phi_t = single(zeros(1, size_vector));
        
    for i = 1: step_association: number
        
        [V_1_1, V_1_0, V_0_1, V_0_0, association_phi] =  td (i, state_1, state_2);
        
        V_1_1_t (i) = V_1_1;
        V_1_0_t (i) = V_1_0;
        V_0_1_t (i) = V_0_1;
        V_0_0_t (i) = V_0_0;
        phi_t (i) = association_phi;
        
    end
    
    
end
    
    