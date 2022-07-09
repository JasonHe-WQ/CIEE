clc;
clear;
close all;
fs = 100;
ts = 1/fs;
TT = 100;
t = 0:ts:TT-ts;
x = exp(-t);

N = length(t);
y = fft(x)*ts;
if mod(N,2)==0
    f = (-N/2:N/2-1)*fs/N;
else
    f = (-(N-1)/2:(N-1)/2)*fs/N;
end
Z1=abs(y);
Z2=angle(y);
Z3=abs(1./(1+1i*2*pi*f));
Z4=angle(1./(1+1i*2*pi*f));

figure(1)
subplot(3,1,1),plot(t,x);
title(sprintf('采样频率:%0.0f Hz(蓝)vs理论值(红)',fs));
subplot(3,1,2),
plot(f,fftshift(Z1))
xlabel('f(Hz)','FontSize',13);
ylabel('|X(jw)|','FontSize',13);
subplot(3,1,3),
plot(f,fftshift(Z2))
xlabel('f(Hz)','FontSize',13);
ylabel('|X(jw)|','FontSize',13);


figure(2);
subplot(2,1,1);plot(f,fftshift(Z1),'b');xlabel('f(Hz)');ylabel('|X(jw)|');hold on;
subplot(2,1,1);plot(f,Z3,'r');xlim([-5,5]);
subplot(2,1,2);plot(f,fftshift(Z2),'b');xlabel('f(Hz)');ylabel('∠X(jw)');hold on;
subplot(2,1,2);plot(f,Z4,'r');xlim([-5,5]);