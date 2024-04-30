clear all;
close all;
mse=[];
N=1000;
sysorder=20;
x=randn(N,1);
b=fir1 (sysorder-1,0.5);
n=0.1*randn(N,1);
d=filter(b,1,x)-+n;
steps=[0.008,0.02,0.05];
for i=1:length(steps)
temp=0;
w=zeros(sysorder,1);
for n=sysorder:N
u=x(n:-1:n-sysorder+1);
y(n)=w'*u;
e(n)=d(n)-y(n);
w=w+steps(i)*u*e(n);
temp=temp+(e(n)^2);
mse(i,n)=temp/n;
end;
end;
plot(1:n,mse(1,:),-b,1:n,mse(2,:),'-m',1:n,mse(3,:),'-r');
axis([1 N -0.2 0.5]);
title(OUTPUT);
xlabel('NO of itertion');
ylabel('Mean square Error');
legend('stepsiz=0.008', 'step size=0.02','step size=0.05');
