clc;
clear;
close all;
x = [2 1 2 1];
y = [1 2 3];
clin = conv(x,y);
xpad = [x zeros(1,6-length(x)) zeros(1,6)];
ypad = [y zeros(1,6-length(y)) y zeros(1,6-length(y)) ];
ccirc = conv(xpad,ypad);
figure(1)
subplot(2,1,1)
stem(clin,'filled')
xlim([-0.5 6.5])
ylim([-0.5 11])
title('线性卷积')

subplot(2,1,2)
stem(ccirc,'filled')
ylim([-0.5 11])
xlim([-0.5 6.5])
title('周期卷积')
figure(2)
plot(xpad);
plot(ypad);