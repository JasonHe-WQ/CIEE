clc;
clear;
close all;
fs = 100;
ts = 1/fs;
TT = 100;
t = 0:ts:TT-ts;
x = stepfun(t,0)-stepfun(t,1);
N = length(t);
y = fft(x)/N;
z1 = abs(y);
z2 = angle(y);
if mod(N,2)==0
    f = (-N/2:N/2-1)*fs/N;
else
    f = (-(N-1)/2:(N-1)/2)*fs/N;
end
tl = 0;
tr = 1-ts;
t0 = (tl+tr)/2;
z = 2*0.5*sinc(2*f*0.5).*exp(-1i*2*pi*f*t0);
z3 = abs(z);
z4 = angle(z);

figure(1)
subplot(3,1,1);plot(t,x);xlim([0 4]);
subplot(3,1,2);plot(f,fftshift(z1));xlabel('f(Hz)');ylabel('|X(jw)|');xlim([-5 5]);
subplot(3,1,3);plot(f,fftshift(z2));xlabel('f(Hz)');ylabel('∠X(jw)');xlim([-5 5]);

figure(2)
subplot(2,1,1);plot(f,fftshift(z1));xlabel('f(Hz)');ylabel('|X(jw)|');hold on;
subplot(2,1,1);plot(f,z3);xlim([-5 5]);
subplot(2,1,2);plot(f,fftshift(z2));xlabel('f(Hz)');ylabel('∠X(jw)');hold on;
subplot(2,1,2);plot(f,z4);xlim([-5 5]);
