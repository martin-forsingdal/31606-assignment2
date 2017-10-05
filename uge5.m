%% init
clc
clear
close all

%% running sum filter of order 3
poles=[0,0];
zeros=[1/2+(sqrt(3)/2)*i,1/2+-(sqrt(3)/2)*i];
poles_and_zeros(poles,zeros);
