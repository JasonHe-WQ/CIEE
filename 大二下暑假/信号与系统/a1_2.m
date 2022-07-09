clc;
clear;
close all;
Ts = 0.01;
t = 0:Ts:5;
x1 = 2*rectpuls(t-2.5,2);
x2 = tripuls(t-2.5,2);
subplot(2,1,1),plot(t,x1);
axis([0,5,-1,3]);
subplot(2,1,2),plot(t,x2);
axis([0,5,-1,3]);