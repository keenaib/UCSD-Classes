clear
close all
clc

% Lead compensator
Dlead = RR_tf([1 2.58],[1 38.73]);

% Double-lag compensator
Dlag1 = RR_tf([1 0.48],[1 0.048]);
Ddoublelag = Dlag1 * Dlag1;

% 4th-order Inverse Chebyshev
Dcheb = RR_LPF_inv_chebyshev(4,0.001,980);

Ds = Dlead * Ddoublelag * Dcheb;
disp('CONTINUOUS-TIME CONTROLLER:')
Ds

h = 0.001;
omegac = 10;
Dz = RR_C2D_tustin(Ds,h,omegac);
disp('DISCRETE-TIME CONTROLLER:')
Dz