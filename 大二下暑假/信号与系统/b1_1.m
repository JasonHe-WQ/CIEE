clc;
clear;
close all;
TT = 0.08;%总时长
Freq = 25;
F = 1000;
Ts = 1/F;
t1 = 0:Ts:(TT-Ts);%时序
N1 = length(t1);
x1 = sin(2*pi*Freq*t1);
y1 = fft(x1)/N1;
Z1 = abs(y1);
Z2 = (sign(Z1-1E-10)+1)/2.*angle(y1);
Z3 = atan(imag(y1)./real(y1));
fs = F;
k1 = -N1/2:N1/2-1;%为了在[-pi,pi]显示频谱，先设置序号，假定N1是偶数
f1 = k1*fs/N1;%[-Fs/2,Fs/2]
figure(1)
subplot(4,1,1),plot(t1,x1)
title(sprintf('信号：x(t)=sin(%0.0fpit);采样频率:%0.0f Hz',Freq*2,fs))
subplot(4,1,2),stem(f1,fftshift(Z1));
subplot(4,1,3),stem(f1,fftshift(Z2));
subplot(4,1,4),stem(f1,fftshift(Z3));