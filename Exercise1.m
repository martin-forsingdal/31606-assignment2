% Exercise 1.1
clear all;
clc
close all;

%% Filter of order 3
zero3 = roots([1,1,1,1]);
pole3 = roots([1,0,0,0]);

%% Filter of order 5
zero5 = roots([1,1,1,1,1,1]);
pole5 = roots([1,0,0,0,0,0]);

%% Plot zplane
% First for order 3
figure(1);
zplane(zero3,pole3)
figure(2);
B3 = poly(zero3);
A3 = poly(pole3);
freqz(B3, A3);
% Then for order 5
figure(3);
zplane(zero5,pole5);
figure(4);
B5 = poly(zero5);
A5 = poly(pole5);
freqz(B5, A5);

%% Moving average order 3
close all;
zero3 = roots(1/(3+1)*[1,1,1,1]);
pole3 = roots([1,0,0,0]);

%% Moving average order 5
zero5 = roots(1/(5+1)*[1,1,1,1,1,1]);
pole5 = roots([1,0,0,0,0,0]);

%% Plot zplane
% First for order 3
figure(1);
zplane(zero3,pole3)
figure(2);
B3 = poly(zero3);
A3 = poly(pole3);
freqz(B3, A3);
% Then for order 5
figure(3);
zplane(zero5,pole5);
figure(4);
B5 = poly(zero5);
A5 = poly(pole5);
freqz(B5, A5);
% Interchange poles and zeros

%% Place zeros
zero = [exp(j*0.1*pi) exp(-j*0.1*pi) exp(j*0.1*pi) exp(-j*0.1*pi)]';
B = poly(zero);
A = 1;
figure(1);
zplane(zero);
figure(2);
freqz(B, A);

%% Place poles with a distance R
R = 0.99;
pole = R*zero;
A = poly(pole);
figure(3);
zplane(zero,pole);
figure(4);
freqz(B, A);

%% Exercise 1.2
% Clear variables and command window
%clear all;
clc;
close all;
%% sample frequency used for filters
fs = 1000;
%%
% For lowpass set zero = -1 and pole = 0;
zero = -1;
pole = 0;
A_low = poly(pole);
B_low = poly(zero);
% Plot the zplane and frequency
figure(1);
zplane(zero,pole);
figure(2);
freqz(B_low, A_low);
% For highpass set zero = 1 and pole = 0;
zero = 1;
pole = 0;
A_high = poly(pole);
B_high = poly(zero);
% Plot the zplane and frequency
figure(3);
zplane(zero,pole);
figure(4);
freqz(B_high, A_high);
% Choose to put poles and zeros on top of each other or same distance from
% the unit circle
r = 1.1;
q = 1/r;
order=5;
phi=(0:1/order:1-1/order)*2*pi;
zero5=r*exp(1i*phi);
pole5=q*exp(1i*phi);
A_allpass = poly(pole5);
B_allpass = poly(zero5);
% Plot the zplane and frequency
figure(5);
zplane(zero5',pole5');
figure(6);
freqz(B_allpass, A_allpass);
ylim([-20 5]);

%% Create sinusoid:
f = 20;
[t, sinusoid] = generate_sinusoid(1,f,0,fs,1);
% Lowpass filter sinusoid
sinusoid_low = real(filter(B_low,A_low,sinusoid));
% Plot the alpass filtered sinusoid
figure(1);
plot(t,sinusoid,'r');
hold on;
plot(t,sinusoid_low,'b');
legend('Signal','Filtered signal');
hold off;
xlim([0 1/f*4]);

% Highpass filter sinusoid
sinusoid_high = real(filter(B_high,A_high,sinusoid));
% Plot the alpass filtered sinusoid
figure(2);
plot(t,sinusoid,'r');
hold on;
plot(t,sinusoid_high,'b');
legend('Signal','Filtered signal');
hold off;
xlim([0 1/f*4]);

% Allpass filter sinusoid
sinusoid_allpass = real(filter(B_allpass,A_allpass,sinusoid));
% Plot the alpass filtered sinusoid
figure(3);
plot(t,sinusoid,'r');
hold on;
plot(t,sinusoid_allpass,'b');
legend('Signal','Filtered signal');
hold off;
xlim([0 1/f*4]);
%% Read sound file
filename = 'x.wav';
[soundsignal, fs] = audioread(filename);
dur = length(soundsignal)/fs;
t = 0:1/fs:dur-1/fs;
% Play the sound file
sound(soundsignal,fs);
pause(dur);


%% Filter soundsignal
%NOTE: the filter are the same, since they scale with the sampling
%frequency!
% Lowpass filter soundsignal
soundsignal_low = real(filter(B_low,A_low,soundsignal));
% Plot the alpass filtered soundsignal
figure(1);
plot(t,soundsignal_low,'b');
hold on;
plot(t,soundsignal,'r');
legend('Filtered signal','Signal');
hold off;
xlim([0 dur]);

% Highpass filter soundsignal
soundsignal_high = real(filter(B_high,A_high,soundsignal));
% Plot the alpass filtered soundsignal
figure(2);
plot(t,soundsignal,'r');
hold on;
plot(t,soundsignal_high,'b');
legend('Signal','Filtered signal');
hold off;
xlim([0 dur]);

% Allpass filter soundsignal
soundsignal_allpass = real(filter(B_allpass,A_allpass,soundsignal));
% Plot the alpass filtered soundsignal
figure(3);
plot(t,soundsignal_allpass,'b');
hold on;
plot(t,soundsignal,'r');
legend('Filtered signal','Signal');
hold off;
xlim([0 dur]);

%% Play the lowpass filtered soundsignal
sound(soundsignal_low,fs);
pause(dur);

%% Play the highpass filtered soundsignal
sound(soundsignal_high,fs);
pause(dur);

%% Play the allpass filtered soundsignal
sound(soundsignal_allpass,fs);
pause(dur);
