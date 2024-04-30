%%copy and paster different sections as needed
snr = [-20:1:20];
##n = 7; k = 4;
%%section 1
##for p=1:length(snr)
##  msg = randi([0 1], 10000, 1);
##  msg_enc = encode(msg, n, k, 'cyclic/binary');
##  msg_tx = pskmod(msg_enc, 2);
##  msg_channel = awgn(msg_tx, snr(p));
##  msg_rx = pskdemod(msg_channel, 2);
##  msg_dec = decode(msg_rx, n, k, 'cyclic/binary');
##  [error, ratio_bit] = biterr(msg, msg_dec);
##  ber(p) = ratio_bit;
##end

%%section 2
##n=3; g1=5; g2=7;
##for p=1:length(snr)
##  t = poly2trellis(n, [g1 g2]);
##  msg = randi([0 1], 10000, 1);
##  msg_enc = convenc(msg, t);
##  msg_tx = pskmod(msg_enc, 2);
##  msg_channel = awgn(msg_tx, snr(p));
##  msg_rx = pskdemod(msg_channel, 2);
##  tblen = length(msg);
##  msg_dec = vitdec(msg_rx, t, tblen, 'trunk', 'hard');
##  [error ratio_bit] = biterr(msg, msg_dec);
##  ber(p) = ratio_bit
##end
##
##semilogy(snr, ber);

%% ADAPTIVE EQUALIZER
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
