clc;
clear;
close all;
fs = 100;
ts = 1/fs;
Freq = 5;
TT = 1;
t1 = 0:ts:TT-ts;
y1 = (square(2*pi*Freq*t1)+1)/2;
N = length(t1);
if mod(N,2)==0
    f = (-N/2:N/2-1)*fs/N;
else
    f = (-(N-1)/2:(N-1)/2)*fs/N;
end
y2 = fft(y1)/N;
Z1 = abs(y2);
figure(1)
subplot(2,1,1),plot(t1,y1);
ylim([-0.5, 1.5]);
title(sprintf('方波信号 %0.1f个周期',TT*Freq));
xlabel('t(s)','FontSize',13);
ylabel('x(t)','FontSize',13);
subplot(2,1,2),stem(f,fftshift(Z1));
axis([-50,50,0,1]);
xlabel('f(Hz)','FontSize',13);
ylabel('|ak|','FontSize',13);