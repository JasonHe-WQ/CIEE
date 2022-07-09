clc;
clear;
close all;
%方法(1)
n = -3:12;
x1 = [zeros(1,5),1,zeros(1,10)];
y1 = [zeros(1,5),ones(1,11)];
subplot(2,2,1),stem(n,x1);
axis([-3,12,-0.1,1.2]);
title("delta([n-2]");
subplot(2,2,2),stem(n,y1);
axis([-3,12,-0.1,1.2]);
title('u[n-2]');

%方法(2)
x2 = rectpuls(n-2,0);
y2 = stepfun(n,2);
subplot(2,2,3),stem(n,x2);
axis([-3,12,-0.1,1.2]);
title("delta([n-2]");
subplot(2,2,4),stem(n,y2);
axis([-3,12,-0.1,1.2]);
title('u[n-2]');