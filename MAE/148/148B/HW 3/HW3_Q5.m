clear;
close all;
clc;

%%
d = 0.1;
a = 1;

%%
G = RR_pade(d,16,12)*RR_tf(1,[1 a]);

%%
D = 1;

%%
L = G*D;

%%
figure(1)
RR_rlocus(G)
grid on
title('Root Locus: 16,12 Pade Approximation')

%%
f = @(omega) imag(RR_evaluate(-1/L,1i*omega));

%%
omega = fzero(f,[15 18]);

%%
Kcrit = real(RR_evaluate(-1/L,1i*omega));

fprintf('Critical frequency = %.6f rad/s\n',omega)
fprintf('Critical gain K = %.6f\n',Kcrit)