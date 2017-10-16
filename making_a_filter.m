%%init
clc
clear
close all

%% design filter
% specify the attenuations. These are Gp=-2 dB and Gs=-11 dB, but
% they are defined positive because the buttord function
% only take positive numbers.
Gp = 2;    
Gs = 11;

% specify the frequencies for which the attenuations must be present
w_p = 10;    
w_s = 15;

% specify the highest frequency to process (Nyquist frequency!)
w_max = 35; 

% normalize the frequencies:
w_p_norm = w_p/w_max;
w_s_norm = w_s/w_max;

% now we can get the filter order N and the cut-off Wn!
[N, Wn] = buttord(w_p_norm, w_s_norm, Gp, Gs);

% get the filter coefficients:
[B, A] = butter(N, Wn);

%% Plot z-plane and spectrum of the filter
% Choose sampling frequency as four times the highest frequency w_max
fs=4*pi*35; %omega_n = 35
figure(1);
freqz(B, A);
zeros=roots(B);
poler=roots(A);
figure(2);
zplane(zeros,poler);

%% 1.2
%% generate signal
f=10;
[t, s] = generate_sinusoid(1,f,0,fs,1);

s_filt1=filter(B,A,s);
s_filt2=filter(B,A,fliplr(s_filt1));
%% Plot signal
% Create time vector
fig1 = figure(1);
plot(t,fliplr(s_filt2),'r','LineWidth',3);
xlabel('Time [t]','FontSize',15);
ylabel('Signal [a.u.]','FontSize',15);
grid on;
hold on;
plot(t,s,'b','LineWidth',1);
set(gcf,'Position',[100 100 800 500]);
set(gca,'Fontsize',12)
hold off;
legend('Processed signal','Original signal');
xlim([0 1/f*5]);
ylim([-1.1 1.1]);

%% higher order filter
%% generate signal
f=100;
[t, signal] = generate_sinusoid(1,f,0,fs,1);
%filter the signal 3 times
signal_filt1=filter(B,A,signal);
signal_filt2=filter(B,A,signal_filt1);
signal_filt3=filter(B,A,signal_filt2);

%% Plot signal
% Create time vector
fig2 = figure(2);
plot(t,signal,'b');
xlabel('Time [t]','FontSize',15);
ylabel('Signal [a.u.]','FontSize',15);
grid on;
hold on;
plot(t,signal_filt1,'c');
plot(t,signal_filt2,'m');
plot(t,signal_filt3,'r');
set(gcf,'Position',[100 100 800 500]);
set(gca,'Fontsize',12)
hold off;
xlim([0 (1/f)*5]);
ylim([-1.1 1.1]);
legend('Original signal','Signal filtered 1 time','Signal filtered 2 times','Signal filtered 3 times');

%% cascading filters
[h,w]=freqz(B,A);
%using convolution as polynomial multiplication
B_cas1=conv(B,B);
A_cas1=conv(A,A);
[h1,w1]=freqz(B_cas1,A_cas1);
B_cas2=conv(B_cas1,B);
A_cas2=conv(A_cas1,A);
[h2,w2]=freqz(B_cas2,A_cas2);
B_cas3=conv(B_cas2,B);
A_cas3=conv(A_cas2,A);
[h3,w3]=freqz(B_cas3,A_cas3);
fig3=figure(3);
subplot(2,1,1);
plot(w/pi,20*log10(abs(h)))
hold on
plot(w1/pi,20*log10(abs(h1)))
plot(w2/pi,20*log10(abs(h2)))
plot(w3/pi,20*log10(abs(h3)))
grid on
ax = gca;
ax.YLim = [-100 20];
ax.XTick = 0:.2:2;
xlabel('Normalized Frequency (\times\pi rad/sample)')
ylabel('Magnitude (dB)')
legend('Original filter','2 cascaded filters','3 cascaded filters','4 cascaded filters');
hold off
subplot(2,1,2);
plot(w/pi,angle(h));
hold on
plot(w1/pi,angle(h1));
plot(w2/pi,angle(h2));
plot(w3/pi,angle(h3));
grid on
ax = gca;
ax.YLim = [-pi pi];
ax.XTick = 0:.2:2;
xlabel('Normalized Frequency (\times\pi rad/sample)')
ylabel('Phase (degrees)')
legend('Original filter','2 cascaded filters','3 cascaded filters','4 cascaded filters');
hold off