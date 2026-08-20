s = tf('s');

z = 0.48;
p = 0.048;

Ddoublelag = ((s + z)/(s + p))^2;

fprintf('z = %.6f rad/s\n',z);
fprintf('p = %.6f rad/s\n',p);

figure;
bode(Ddoublelag);
grid on;
title('Bode Plot of D_{doublelag}(s)');