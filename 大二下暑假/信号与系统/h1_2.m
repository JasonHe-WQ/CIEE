clc;
clear;
close all;
Ts = 0.01;
T = 35;
T1S = -1;
T2S = 2;

t1 = T1S:Ts:T1S+T;
t2 = T2S:Ts:T2S+T;

x1 = rectpuls(t1-1,5)+rectpuls(t1-8,5)+rectpuls(t1-15,5)+rectpuls(t1-22,5)+rectpuls(t1-29,5)+rectpuls(t1-36,5);
x2 = rectpuls(t2-4,3)+rectpuls(t2-11,3)+rectpuls(t2-18,3)+rectpuls(t2-25,3)+rectpuls(t2-32,3)+rectpuls(t2-39,3);

L= length(t1);
t3 = (T1S+T2S):Ts:((L-1)*Ts+(T1S+T2S));

F1 = fft(x1)*Ts;
F2 = fft(x2)*Ts;
y1 = ifft(F1.*F2)/Ts;
figure(1)
subplot(4,1,1),plot(t1,x1);
axis([T1S-1,T1S+T+1,-0.5,1.5]);
subplot(4,1,2),plot(t2,x2);
axis([T2S-1,T2S+T+1,-0.5,1.5]);
subplot(4,1,3),plot(t3,y1);
axis([T1S+T2S-1,(L-1)*Ts+(T1S+T2S)+1,-0.5,15.5]);
subplot(4,1,4),plot(t3,y1);
axis([T1S+T2S-1,7+(T1S+T2S)+1,-0.5,15.5])

x3 = rectpuls(t1-1,5);
x4 = rectpuls(t2-4,3);
F3 = fft(x3)*Ts;
F4 = fft(x4)*Ts;
y2 = ifft(F3.*F4)/Ts;
figure(2)
subplot(3,1,1),plot(t1,x3);
axis([T1S-1,T1S+T+1,-0.5,1.5]);
subplot(3,1,2),plot(t2,x4);
axis([T2S-1,T2S+T+1,-0.5,1.5]);
subplot(3,1,3),plot(t3,y2);
axis([T1S+T2S-1,(L-1)*Ts+(T1S+T2S)+1,-0.5,15.5]);