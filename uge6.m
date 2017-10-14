%%init
clc
clear
close all

%% design filter
% specify the attenuations (positive numbers!)
Gp = 2;    
Gs = 11;

% specify the frequencies
w_p = 10;    
w_s = 15;

% specify the highest frequency to process (Nyquist!)
w_max = 35; 

% normalize the frequencies:
w_p_norm = w_p/w_max;
w_s_norm = w_s/w_max;

% now we can get the filter order N and the cut-off Wn!
[N, Wn] = buttord(w_p_norm, w_s_norm, Gp, Gs);

% get the filter coefficients:
[B, A] = butter(N, Wn);

%%
fs=4*pi*35; %omega_n = 35
figure(1);
freqz(B, A);
nuller=roots(B);
poler=roots(A);
figure(2);
zplane(nuller,poler);

%% 1.2
%% generate signal
[t, s] = generate_sinusoid(1,100,0,fs,0.1);

s_filt1=filter(B,A,s);
s_filt2=filter(B,A,fliplr(s_filt1));
%% Plot sound signal
% Create time vector
fig1 = figure(1);
plot(t,fliplr(s_filt2),'r');
xlabel('Time [t]','FontSize',15);
ylabel('Signal [a.u.]','FontSize',15);
grid on;
hold on;
plot(t,s,'b');
set(gcf,'Position',[100 100 800 500]);
set(gca,'Fontsize',12)
hold off;