clc;
clear;
close all;
Ts = 0.01;
T = 7;
T1S = -1;
T2S = 2;

t1 = T1S:Ts:T1S+T;
t2 = T2S:Ts:T2S+T;

x1 = rectpuls(t1-1,3);
x2 = rectpuls(t2-4,2);

L= length(t1);
t3 = (T1S+T2S):Ts:((L-1)*Ts+(T1S+T2S));

F1 = fft(x1)*Ts;
F2 = fft(x2)*Ts;
y = ifft(F1.*F2)/Ts;
figure(1)
subplot(3,1,1),plot(t1,x1);
axis([T1S-1,T1S+T+1,-0.5,1.5]);
subplot(3,1,2),plot(t2,x2);
axis([T2S-1,T2S+T+1,-0.5,1.5]);
subplot(3,1,3),plot(t3,y);
axis([T1S+T2S-1,(L-1)*Ts+(T1S+T2S)+1,-0.5,4]);