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

%%
L = G*D;

%%
figure(1)
RR_rlocus(G*D)
grid on
title('Root Locus: 2,2 Pade Approximation')

%%
Kcrit = -30 + sqrt(2161);

fprintf('Critical gain K = %.6f\n',Kcrit)