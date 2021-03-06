clc;
clear;
close all;
A = 2;
f = 4;
b = pi/6;
w0 = 2*pi*f;
t = 0:0.001:2;
x1 = A*sin(w0*t+b);
x2 = A*square(w0*t+b);
subplot(2,1,1),plot(t,x1);
ylim([-6,6]);
subplot(2,1,2),plot(t,x2);
ylim([-6,6]);