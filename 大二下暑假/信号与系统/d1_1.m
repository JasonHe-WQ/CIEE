clc;
clear;
close all;
[Y1, Fs] = audioread('gotothemoon.wav');
[Y2, Fs] = audioread('goToTheMoon.wav');
Y11 = Y1(:,1);
Y12 = Y1(:,2);
Y21 = Y2(:,1);
Y22 = Y2(:,2);
sound(Y1,Fs);
f1 = 12000;
Freq = 48000;
TT = 8.17;
Ts = 1/Freq;
t = 0:Ts:TT-Ts;
n = 0.005*sin(2*pi*f1*t);
X11 = Y11 + n';
X12 = Y12 + n';
X1 = [X11, X12];

N = length(t);
if mod(N,2)==0
    f = (-N/2:N/2-1)*Freq/N;
else
    f = (-(N-1)/2:(N-1)/2)*Freq/N;
end
figure(1)
subplot(6,1,1);plot(t,abs(Y1));title('原始音频');
subplot(6,1,2);plot(f,fftshift(abs(fft(Y1)*Ts)))
subplot(6,1,3);plot(t,abs(X1));title('增加噪音后');
subplot(6,1,4);plot(f,fftshift(abs(fft(X1)*Ts)))
pause(7);
sound(X1,Fs);



Fs = 96000;

fs = 11600;
fp = 10800;
ws = 2*pi*fs/Fs;
wp = 2*pi*fp/Fs;
Bt = ws-wp;
N0 = ceil(6.2*pi/Bt);
N1 = 1025;
wc = (ws + wp) / 2;



%采用fir1函数设计FIR滤波器
hn=fir1(N1-1,wc/pi,'low',hanning(N1));
figure(2)
freqz(hn,1);


%求幅频响应
m_lpf=20*log(abs(fft(hn)))/log(10);

% 设置频率响应的横坐标单位为hz
x_f=0:(Fs/length(m_lpf)):Fs/2;

figure(3)
% 单位脉冲响应
subplot(2,1,1);stem(hn);xlabel('n');ylabel('h(n)');


% 幅频响应
subplot(2,1,2);plot(x_f,m_lpf(1:length(x_f)));xlabel('频率(hz)');ylabel('幅度(db)','fontsize',8);


figure(1)
YY1=filtfilt(hn,1,X1);
z1=abs(fft(YY1)*Ts);
subplot(6,1,5);plot(t,abs(YY1));title('过滤噪音后');
subplot(6,1,6);plot(f,fftshift(z1));
pause(7);
sound(YY1,48000);
figure(4)
subplot(2,1,1);
plot(t,abs(YY1-X1));
subplot(2,1,2);
plot(f,abs(fftshift(z1)-fftshift(abs(fft(Y1)*Ts))));