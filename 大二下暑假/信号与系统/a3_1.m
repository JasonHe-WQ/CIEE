clc;
clear;
close all;
Ts = 0.01;

T1S = -2;
T1E = 5;
T2S=1;
T2E=6;

t1 = T1S:Ts:T1E;
x1=rectpuls(t1-2.5,3);
t2=T2S:Ts:T2E;
x2 = rectpuls(t2-3,2);
y = conv(x1,x2)*Ts;
t3=(T1S+T2S):Ts:(T1E+T2E);
subplot(3,1,1),plot(t1,x1);
axis([-2.5,5.5,-0.5,1.5]);
subplot(3,1,2),plot(t2,x2);
axis([0.5,6.5,-0.5,1.5]);
subplot(3,1,3),plot(t3,y);
axis([T1S+T2S-0.5,T1E+T2E+0.5,-0.5,2.5]);