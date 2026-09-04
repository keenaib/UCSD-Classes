clear;
close all;
clc;

%%
d = 0.1;
a = 1;

%%
G = RR_pade(d,2,2)*RR_tf(1,[1 a]);

%%
Kcrit = -30 + sqrt(2161);

%%
Khalf  = Kcrit/2;
Ktwice = 2*Kcrit;

fprintf('Kcrit  = %.6f\n',Kcrit)
fprintf('Khalf  = %.6f\n',Khalf)
fprintf('Ktwice = %.6f\n',Ktwice)

%%
wpos = logspace(-4,4,30000);
w = [-fliplr(wpos), 0, wpos];

%% NYQUIST PLOT: K = Kcrit/2
L1 = Khalf*G;

resp1 = zeros(size(w));

for ii = 1:length(w)
    resp1(ii) = RR_evaluate(L1,1i*w(ii));
end

figure(1)

plot(real(resp1),imag(resp1),'LineWidth',1.5)
hold on

plot(-1,0,'rx','MarkerSize',12,'LineWidth',2)

xline(0)
yline(0)

grid on

xlabel('Real[L(j\omega)]')
ylabel('Imag[L(j\omega)]')

title(sprintf('Nyquist Plot: K = Kcrit/2 = %.3f',Khalf))

xlim([-4 3])
ylim([-4 4])


%% NYQUIST PLOT: K = 2*Kcrit
L2 = Ktwice*G;

resp2 = zeros(size(w));

for ii = 1:length(w)
    resp2(ii) = RR_evaluate(L2,1i*w(ii));
end

figure(2)

plot(real(resp2),imag(resp2),'LineWidth',1.5)
hold on

plot(-1,0,'rx','MarkerSize',12,'LineWidth',2)

xline(0)
yline(0)

grid on

xlabel('Real[L(j\omega)]')
ylabel('Imag[L(j\omega)]')

title(sprintf('Nyquist Plot: K = 2Kcrit = %.3f',Ktwice))

xlim([-6 4])
ylim([-6 6])