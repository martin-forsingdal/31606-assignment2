%% init
clc
clear
close all

%% running sum filter of order 3
order=3;
nuller=roots(ones(1,order+1))';
poler=roots([1,zeros(1,order)])';
poles_and_zeros(poler,nuller);

%% running sum filter of order 3
order=5;
nuller=roots(ones(1,order+1))';
poler=roots([1,zeros(1,order)])';
poles_and_zeros(poler,nuller);

%% amplify attenuated signals
%this is done by switching zeros and poles
poles_and_zeros(nuller,poler);
%% blocking 0.1 normalized frequency 
nuller=[exp(j*0.1*2*pi),exp(-j*0.1*2*pi)];
nuller=[nuller,nuller];

%% adding poles
r=0.1
poler=r*[exp(j*0.1*2*pi),exp(-j*0.1*2*pi)];
poler=[poler,poler];
poles_and_zeros(poler,nuller);

%% 1.2
%generating low pass
order=9;
nuller_low=(1/(order+1))*roots(ones(1,order+1))';
poler_low=roots([1,zeros(1,order)])';
poles_and_zeros(poler_low,nuller_low);

%% generating high pass
nuller_high=poler_low;
poler_high=nuller_low;
poles_and_zeros(poler_high,nuller_high);

%% all pass
nuller_pass = ones(1,5);
poler_pass=nuller_pass;
poles_and_zeros(nuller_pass,poler_pass);

%% generate sinussoid
Fs=1000;
freq=400;
[t,sig]=gen_sinus(1,freq,0,Fs,1);
sig_low=filter(poly(nuller_low),poly(poler_low),sig);
sig_high=filter(poly(nuller_high),poly(poler_high),sig);
figure('Position',[100 300 1000 600],'Color','white');
plot(t,sig);
hold on;
plot(t,sig_low);
plot(t,sig_high);
hold off;
xlim([0 1/freq*4]);
legend('Original signal','Lowpass filer','Highpass filter');
