clear;
clc;
close all;

%%
s = tf('s');

G = 100/(s^2 - 100);

%%
D_simple = 3*(s+10)/(s+20);

L_simple = G*D_simple;

T_simple = feedback(L_simple,1);

%%
D1 = (s+2.58)/(s+38.73);

D2 = ((s+0.48)/(s+0.048))^2;

N4 = 0.001*s^4 + ...
     7683.2*s^2 + ...
     7.37895e9;

P4 = s^4 + ...
     758.932*s^3 + ...
     2.87995e5*s^2 + ...
     6.41382e7*s + ...
     7.37895e9;

D4 = N4/P4;

D0 = D1*D2*D4;

K_loop = 7.7286;

D_loop = K_loop*D0;

L_loop = G*D_loop;

T_loop = feedback(L_loop,1);

%%
fprintf('\n============================================\n');
fprintf('SIMPLE CONTROLLER\n');
fprintf('============================================\n');

D_simple

fprintf('\n============================================\n');
fprintf('LOOP-SHAPING CONTROLLER\n');
fprintf('============================================\n');

D_loop

%%
D_simple_0 = (s+10)/(s+20);

figure;

rlocus(G*D_simple_0);

grid on;

title('Root Locus - Simple Lead Design');

xlabel('Real Axis');
ylabel('Imaginary Axis');

hold on;

poles_simple = pole(T_simple);

plot(real(poles_simple), ...
     imag(poles_simple), ...
     'rx', ...
     'MarkerSize',10, ...
     'LineWidth',2);

legend('Root Locus','Selected Closed-Loop Poles');

%%
figure;

rlocus(G*D0);

grid on;

title('Root Locus - Loop-Shaping Design');

xlabel('Real Axis');
ylabel('Imaginary Axis');

hold on;

poles_loop = pole(T_loop);

plot(real(poles_loop), ...
     imag(poles_loop), ...
     'rx', ...
     'MarkerSize',10, ...
     'LineWidth',2);

legend('Root Locus','Selected Closed-Loop Poles');

%%
figure;

margin(L_simple);

grid on;

title('Bode Plot - Simple Lead Design');

%%
figure;

margin(L_loop);

grid on;

title('Bode Plot - Loop-Shaping Design');

%%
figure;

bode(L_simple,L_loop);

grid on;

legend('Simple Lead','Loop-Shaping');

title('Open-Loop Bode Plot Comparison');

%%
wg = 10;

mag_loop = abs(evalfr(L_loop,1i*wg));

mag_loop_dB = 20*log10(mag_loop);

fprintf('\n============================================\n');
fprintf('LOOP-SHAPING CROSSOVER CHECK\n');
fprintf('============================================\n');

fprintf('Desired crossover frequency = %.2f rad/s\n',wg);

fprintf('|L_loop(j10)| = %.8f\n',mag_loop);

fprintf('Magnitude at 10 rad/s = %.6f dB\n',mag_loop_dB);

%%
figure;

step(T_simple);

grid on;

title('Closed-Loop Step Response - Simple Lead Design');

xlabel('Time (seconds)');
ylabel('Output');

%%
figure;

step(T_loop);

grid on;

title('Closed-Loop Step Response - Loop-Shaping Design');

xlabel('Time (seconds)');
ylabel('Output');

%%
figure;

step(T_simple,T_loop);

grid on;

title('Closed-Loop Step Response Comparison');

xlabel('Time (seconds)');
ylabel('Output');

legend('Simple Lead','Loop-Shaping');

%%
info_simple = stepinfo(T_simple);
info_loop = stepinfo(T_loop);

fprintf('\n============================================\n');
fprintf('SIMPLE DESIGN STEP RESPONSE\n');
fprintf('============================================\n');

fprintf('Rise Time = %.6f s\n',info_simple.RiseTime);
fprintf('Settling Time = %.6f s\n',info_simple.SettlingTime);
fprintf('Overshoot = %.4f %%\n',info_simple.Overshoot);
fprintf('Peak = %.6f\n',info_simple.Peak);
fprintf('Peak Time = %.6f s\n',info_simple.PeakTime);


fprintf('\n============================================\n');
fprintf('LOOP-SHAPING DESIGN STEP RESPONSE\n');
fprintf('============================================\n');

fprintf('Rise Time = %.6f s\n',info_loop.RiseTime);
fprintf('Settling Time = %.6f s\n',info_loop.SettlingTime);
fprintf('Overshoot = %.4f %%\n',info_loop.Overshoot);
fprintf('Peak = %.6f\n',info_loop.Peak);
fprintf('Peak Time = %.6f s\n',info_loop.PeakTime);

%%
fprintf('\n============================================\n');
fprintf('SIMPLE CLOSED-LOOP POLES\n');
fprintf('============================================\n');

poles_simple


fprintf('\n============================================\n');
fprintf('LOOP-SHAPING CLOSED-LOOP POLES\n');
fprintf('============================================\n');

poles_loop

%%
fprintf('\n============================================\n');
fprintf('STABILITY CHECK\n');
fprintf('============================================\n');

if isstable(T_simple)
    fprintf('Simple design: STABLE\n');
else
    fprintf('Simple design: UNSTABLE\n');
end

if isstable(T_loop)
    fprintf('Loop-shaping design: STABLE\n');
else
    fprintf('Loop-shaping design: UNSTABLE\n');
end