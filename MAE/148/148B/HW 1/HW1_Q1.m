s = tf('s');

wg = 10;
alpha = 15;

z = wg/sqrt(alpha);
p = wg*sqrt(alpha);

Dlead = (s + z)/(s + p);

fprintf('z = %.6f rad/s\n',z);
fprintf('p = %.6f rad/s\n',p);

figure;
bode(Dlead);
grid on;
title('Bode Plot of D_{lead}(s)');