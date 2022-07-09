clc;
clear;
close all;
Freq = 25;
fs = 1000;
Ts = 1/fs;
TT = 0.15;
t = 0:Ts:(TT-Ts);
N = length(t);
x1 = sin(2*pi*Freq*t);
x2 = x1.*bartlett(N)';
y1 = fft(x1)/N;
y2 = fft(x2)/N;
Z1 = abs(y1);
Z2 = abs(y2);
k = -N/2:N/2-1;
f = k*fs/N;
M = 10000;
y3 = fft(x1,M)*Ts;
y4 = fft(x2,M)*Ts;
f2 = (-M/2:(M/2-1))*fs/M;
figure(1)
subplot(2,1,1),plot(Z1)
title('幅度谱')
subplot(2,1,2)
plot(Z2)
title('加三角窗幅度谱')
figure(2),subplot(2,1,1)
plot(f2,fftshift(abs(y3)));
title(sprintf('矩形窗截断， 幅频特性，总点数=%0.0f',M))
xlim([-200, 200])
subplot(2,1,2)
plot(f2,2*fftshift(abs(y4)));
title(sprintf('三角窗截断， 幅频特性，总点数=%0.0f',M))
xlim([-200 200]);