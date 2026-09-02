%% Parameters
d = 12;
a0 = 0.02;

T0 = 35;
T1 = 45;

Tmin = 10;
Tmax = 50;

%% Lead compensator parameters
K = 0.44;
z = 0.030;
p = 0.031;

%% F2,2 Plant
G22 = RR_pade(d,2,2)*RR_tf(1,[1/a0 1]);

%% Lead Compensator
Dlead = RR_tf([1 z],[1 p]);
D = K*Dlead;

%% Open Loop
L22 = G22*D;

%% DC Gain and Prefilter
D0 = K*z/p;
P = (1+D0)/D0;

fprintf('CONTROLLER PARAMETERS\n')
fprintf('K    = %.6f\n',K)
fprintf('z    = %.6f\n',z)
fprintf('p    = %.6f\n',p)
fprintf('D(0) = %.6f\n',D0)
fprintf('P    = %.6f\n',P)

%% Time Settings
g.T = 250;
tplot = linspace(0,250,2501);

%% Root Locus Plot
figure(1)

RR_rlocus(G22*Dlead);

grid on
axis([-2 1 -1 1])

xlabel('Real Axis')
ylabel('Imaginary Axis')
title('Root Locus with Lead Compensator')

%% Temperature Response Plot - F2,2
T22 = P*L22/(1+L22);

figure(2)

RR_step(T0 + (T1-T0)*T22,g);

hold on

xlabel('Time [s]')
ylabel('Temperature [deg C]')

title(sprintf( ...
    'Temperature Response F_{2,2}: K = %.3f, z = %.4f, p = %.4f', ...
    K,z,p))

grid on
axis([0 250 5 55])

%% Valve Command Plot - F2,2
Su22 = P*D/(1+L22);

figure(3)

RR_step(T0 + (T1-T0)*Su22,g);

xlabel('Time [s]')
ylabel('Valve Temperature [deg C]')
title('Valve Command - F_{2,2}')

grid on
axis([0 200 5 55])

%% Higher-Order Pade Approximation
G1613 = RR_pade(d,16,13)*RR_tf(1,[1/a0 1]);

L1613 = G1613*D;

%% Temperature Response Plot - F16,13
T1613 = P*L1613/(1+L1613);

figure(4)

RR_step(T0 + (T1-T0)*T1613,g);

hold on

xlabel('Time [s]')
ylabel('Temperature [deg C]')

title('Temperature Response using F_{16,13} Pade Approximation')

grid on
axis([0 200 32 55])

%% Valve Command Plot - F16,13
Su1613 = P*D/(1+L1613);

figure(5)

RR_step(T0 + (T1-T0)*Su1613,g);

xlabel('Time [s]')
ylabel('Valve Temperature [deg C]')

title('Valve Command using F_{16,13} Pade Approximation')

grid on
axis([0 200 5 55])