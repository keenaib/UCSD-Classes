s = tf('s');

z = 0.88;
p = 0.0088;

Dlag = (s + z)/(s + p);

fprintf('z = %.6f rad/s\n',z);
fprintf('p = %.6f rad/s\n',p);

figure;
bode(Dlag);
grid on;
title('Bode Plot of D_{lag}(s)');