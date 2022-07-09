clear;close all; clc;
%处理对象
Freq1 = 4800;
Freq2 = 200;
TT1 = 0.24;
TT2 = 2;
Ts1 = 1/Freq1;
Ts2 = 1/Freq2;
t1 = 0:Ts1:TT1-Ts1;
t2 = 0:Ts2:TT2-Ts2;
x1=10*cos(2*100*pi*t1)+5*cos(300*2*pi*t1);
x2 =stepfun(t2,0)-stepfun(t2,1);
M = length(t2);
N = length(t1);
y1 = fft(x1)/N;
y2 = fft(x2)/M;
z11 = abs(y1);
z12 = angle(y1);
z21 = abs(y2);
z22 = angle(y2);

if mod(N,2)==0
    f1 = (-N/2:N/2-1)*Freq1/N;
else
    f1 = (-(N-1)/2:(N-1)/2)*Freq1/N;
end
if mod(M,2)==0
    f2 = (-M/2:M/2-1)*Freq2/M;
else
    f2 = (-(M-1)/2:(M-1)/2)*Freq2/M;
end

figure(1)
subplot(3,1,1),plot(t1,x1);
subplot(3,1,2),stem(f1,fftshift(z11));xlim([-500 500]);
subplot(3,1,3),stem(f1,z12);xlim([-500 500]);

figure(2)
subplot(2,1,1),plot(t2,x2);
subplot(2,1,2),stem(f2,fftshift(z21));
xlim([-5 5]);




%采样频率
Fs = 2400;

fs = 150;
fp = 120;
ws = 2*pi*fs/Fs;
wp = 2*pi*fp/Fs;
Bt = ws-wp;
N0 = ceil(6.2*pi/Bt);
N1 = N0 + mod(N0 + 1, 2);
wc = (ws + wp) / 2;



%采用fir1函数设计FIR滤波器
hn=fir1(N1-1,wc/pi,'low',hanning(N1));
figure(3)
freqz(hn,1);


%求幅频响应
m_lpf=20*log(abs(fft(hn)))/log(10);

% 设置频率响应的横坐标单位为hz
x_f=0:(Fs/length(m_lpf)):Fs/2;

figure(4)
% 单位脉冲响应
subplot(2,1,1);stem(hn);xlabel('n');ylabel('h(n)');


% 幅频响应
subplot(2,1,2);plot(x_f,m_lpf(1:length(x_f)));xlabel('频率(hz)');ylabel('幅度(db)','fontsize',8);


figure(5)
yy1=filtfilt(hn,1,x1);
z2=abs(fft(yy1)/N);
subplot(2,1,1);plot(t1,abs(yy1));
subplot(2,1,2);stem(f1,fftshift(z2));
