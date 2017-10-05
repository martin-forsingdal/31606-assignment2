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
nuller=(1/(order+1))*roots(ones(1,order+1))';
poler=roots([1,zeros(1,order)])';
poles_and_zeros(poler,nuller);

%% generating high pass
poles_and_zeros(nuller,poler);

%% all pass
nuller = ones(1,5);
poler=nuller;
poles_and_zeros(nuller,poler);