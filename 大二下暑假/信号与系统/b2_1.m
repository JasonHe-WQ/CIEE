clc;
clear;
close all;
fs1 = 400;
fs2 = 4000;
TT1 = 0.2;
TT2 = 0.2;
Freq = 5;
ts1 = 1/fs1;
ts2 = 1/fs2;
t1 = 0:ts1:TT1-ts1;
x1 = (square(2*pi*Freq*t1,50)+1)/2;
t2 = 0:ts2:TT2-ts2;
x2 = (square(2*pi*Freq*t2,50)+1)/2;
N = length(t1);
M = length(t2); 
y1 = fft(x1)/N;
y2 = fft(x2)/M;
k1 = -N/2:N/2-1;
k2 = -M/2:M/2-1;
k = [k1,0,k2];
ak1 = 2*Freq*0.05*sinc(2*k1*Freq*0.05).*exp(-1i*k1*2*pi*5*0.04875);
ak2 = 2*Freq*0.05*sinc(2*k2*Freq*0.05).*exp(-1i*k2*2*pi*5*0.049875);

ak=[ak1,0.5,ak2];
akabs = abs(ak);
subplot(3,1,1),plot(x1),hold on;plot(x2);
subplot(3,1,2),stem(fftshift(abs(y1))),hold on;stem(fftshift(abs(y2)));axis([10,70,0,1])
subplot(3,1,3),stem(akabs);axis([0,75,0,0.5])