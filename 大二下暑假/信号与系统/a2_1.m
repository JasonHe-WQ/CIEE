clc;
clear;
close all;
a = [-2,0,1,-1,3];
b = [1,2,0,-1];
c = conv(a,b);
n = 0:1:4;
m = 0:1:3;
M = length(c)-1;
p = 0:1:M;
subplot(3,1,1),stem(n,a);
axis([-1,5,-6,6]);
title("A[n]");
subplot(3,1,2),stem(m,b);
axis([-1,5,-6,6])
title("B[n]");
subplot(3,1,3),stem(p,c);
axis([-1,8,-6,6])
title("卷积和");