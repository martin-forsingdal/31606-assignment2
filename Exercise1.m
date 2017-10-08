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
% For lowpass set zero = -1 and pole = 0;
% For highpass set zero = 1 and pole = 0;
zero = -1;
pole = 0;
A = poly(pole);
B = poly(zero);
% Plot the zplane and frequency
figure(1);
zplane(zero,pole);
figure(2);
freqz(B, A);
% Choose to put poles and zeros on top of each other
r = 1.1;
q = 1/r;
fs = 1000;
zero5 = r*[exp(-j*0.4*pi) exp(-j*0.8*pi) exp(-j*1.2*pi) ...
    exp(-j*1.6*pi) exp(-j*2*pi)];
pole5 = q*[exp(-j*0.4*pi) exp(-j*0.8*pi) exp(-j*1.2*pi) ...
    exp(-j*1.6*pi) exp(-j*2*pi)];
A5 = poly(pole5);
B5 = poly(zero5);
% Plot the zplane and frequency
figure(3);
zplane(zero5',pole5');
figure(4);
freqz(B5, A5,512,fs);
ylim([-20 5]);

%% Create sinusoid:
f = 20;
[t signal] = generate_sinusoid(1,f,0,fs,1);
% Filter signal
signal_filtered = real(filter(B5,A5,signal));
% Plot the filtered signal
figure(1);
plot(t,signal,'r');
hold on;
plot(t,signal_filtered,'b');
legend('Signal','Filtered signal');
hold off;
xlim([0 1/f*4]);