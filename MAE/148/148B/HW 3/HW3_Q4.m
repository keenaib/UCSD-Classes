clear;
close all;
clc;

%%
d = 0.1;
a = 1;

%%
G = RR_pade(d,2,2)*RR_tf(1,[1 a]);

%%
D = 1;
L = G*D;

%% Critical gain Q3
Kcrit = -30 + sqrt(2161);

%% 
omega = sqrt(1200*(1 + Kcrit)/(61 + Kcrit));

fprintf('omega = %.6f rad/s\n',omega)

%%
D = real(RR_evaluate(-1/L,1i*omega));

fprintf('D = %.6f\n',D)

%% Root Locus Plot
figure(2)
RR_rlocus(G*D)
grid on
title('Root Locus at Critical Gain')