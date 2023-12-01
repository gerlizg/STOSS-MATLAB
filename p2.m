   
T = 40;
values = [2, 40, 80];
%factor = [1, 0.3, 0.0035];
filename = string(T) + 'K_exp.csv';


table_0 = readtable(filename)
x_real = table_0 (:,1);
y_real = table_0 (:,2);

y =  (2 * y_relaxation) - N_ex;
rmin = min(y);                       % value
rmax = max(y);
tmax = max(y_real);                  % target
tmin = min(y_real);

y = (((y - rmin) / (rmax - rmin)) * (tmax-tmin))+ tmin;





   