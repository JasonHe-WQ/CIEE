clc;
clear;
close all;
fs=4000;%改变采样率
TT=0.2;
Freq=5;%周期为1/Freq
ts=1/fs;
t=0:ts:TT-ts;
x=(square(2*pi*Freq*t,50)+1)/2;
M=length(t);
y=fft(x)/M;
k=-M/2:M/2-1;
f=k*fs/M;%(-fs/2,fs/2)
ak=2*Freq*0.05*sinc(2*k*Freq*0.05).*exp(-1i*k*2*pi*5*0.04875);
subplot(3,1,1);plot(t,x);xlabel('t(s)');ylabel('x(t)');axis([0,0.6,-0.5,1.5]);
subplot(3,1,2);stem(f,fftshift(abs(y)));xlabel('f(Hz)');ylabel('|ak|');axis([-200,200,0,0.5]);
subplot(3,1,3);stem(f,abs(ak));xlabel('f(Hz)');ylabel('|ak|');axis([-200,200,0,0.5]);