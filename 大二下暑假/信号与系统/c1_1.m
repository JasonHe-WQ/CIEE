clc;clear;close all;
wp = pi/4;ws = pi/2;Bt = ws -wp;
N0 = ceil(6.2*pi/Bt);
N = N0+mod(N0+1,2);
wc = (wp+ws)/2/pi;
hn = fir1(N-1,wc,'high',hanning(N));
freqz(hn,1);
