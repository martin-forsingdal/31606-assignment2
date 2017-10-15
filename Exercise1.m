%% Exercise 1.2
% Clear variables and command window
clear all;
clc;
close all;

%% Sampling frequency used for filtering of sinusoid
fs = 1000;

%% Define filters
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
close all;
f = 20;
% Create a sinusoid with frequency of 20 Hz
[t, sinusoid] = generate_sinusoid(1,f,0,fs,1);

% Lowpass filter sinusoid
sinusoid_low = real(filter(B_low,A_low,sinusoid));
% Plot the low pass filtered sinusoid
figure(1);
plot(t,sinusoid,'r');
hold on;
plot(t,sinusoid_low,'b');
legend('Signal','Filtered signal');
hold off;
xlim([0 1/f*4]);
grid on;
%hgexport(gcf,'sin_low');

% Highpass filter sinusoid
sinusoid_high = real(filter(B_high,A_high,sinusoid));
% Plot the high pass filtered sinusoid
figure(2);
plot(t,sinusoid,'r');
hold on;
plot(t,sinusoid_high,'b');
legend('Signal','Filtered signal');
hold off;
xlim([0 1/f*4]);
grid on;
%hgexport(gcf,'sin_high');

% Allpass filter sinusoid
sinusoid_allpass = real(filter(B_allpass,A_allpass,sinusoid));
% Plot the all pass filtered sinusoid
figure(3);
plot(t,sinusoid,'r');
hold on;
plot(t,sinusoid_allpass,'b');
legend('Signal','Filtered signal');
hold off;
xlim([0 1/f*4]);
grid on;
%hgexport(gcf,'sin_all');

%% Read sound file
close all;
filename = 'x.wav';
[soundsignal, fs] = audioread(filename);
dur = length(soundsignal)/fs;
t = 0:1/fs:dur-1/fs;
% Play the sound file
sound(soundsignal,fs);
pause(dur);

%% Filter soundsignal
% NOTE: the filter are the same, since they scale with the sampling
% frequency!
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
grid on;
%hgexport(gcf,'sound_low');

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
grid on;
%hgexport(gcf,'sound_high');

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
grid on;
%hgexport(gcf,'sound_all');

%% Play the lowpass filtered soundsignal
sound(soundsignal_low,fs);
pause(dur);

%% Play the highpass filtered soundsignal
sound(soundsignal_high,fs);
pause(dur);

%% Play the allpass filtered soundsignal
sound(soundsignal_allpass,fs);
pause(dur);
