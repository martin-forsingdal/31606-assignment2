%%
clc
clear
close all
%%1.1
%% loading files
% read the impulse response and the signal to be convolved
ir_fname = 'ir.wav';
h_info = audioinfo(ir_fname);
x_fname = 'x.wav';
x_info = audioinfo(x_fname);

% read audiofiles - and select only one channel!
h = audioread(ir_fname);
h=h(:,1);
x = audioread(x_fname);
x = x(:,1);
%% testing written function
tic
sig=conv(h,x);
toc
tic
orig=conv(h,x);
toc
%% plotting
subplot(1,2,1);
plot(sig/max(sig),'b');
title('Homemade convolution');
subplot(1,2,2);
plot(orig,'r');
title('Built in convolution');
%% playing signals
%sound(h./max(h), x_info.SampleRate);
sound(sig/max(sig), x_info.SampleRate);
%% 2.1
test=fft_owm([1,2],[1,2]);
%% testing function
% Change the length below to test for other lengths.
N0=2^5;
f=randn(1,N0);
f_e=f(1:2:end-1);
f_o=f(2:2:end);
Even=fft(f_e);
Odd=fft(f_o);
Y=fft(f);
my_Y=fft_owm(Even,Odd);
norm(Y-my_Y)