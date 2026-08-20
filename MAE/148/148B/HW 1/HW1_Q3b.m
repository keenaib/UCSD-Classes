F=RR_LPF_inv_chebyshev(4,0.001,980)
close all
RR_bode(F)
figure(2)
RR_bode_linear(F)