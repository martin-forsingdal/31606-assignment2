%% Exercise 3.1
% Clear workspace and command window
clear all;
clc;
set(0,'DefaultFigureVisible','off');

%% Read sound file
filename = 'piano.wav';
[y fs] = audioread(filename);
sound(y,fs);

%% Plot sound signal
% Create time vector
duration = length(y)/fs;
t = 0:1/fs:1-1/fs;
fig1 = figure(1);
plot(t,y(1:length(t)),'b');
xlabel('Time [t]','FontSize',15);
ylabel('Signal [a.u.]','FontSize',15);
title('Plot of sound signal','FontSize',20);
grid on;
set(gcf,'Position',[0 0 1920 1080]);

%% Compute spectrum
[Y, freq] = spectrum_maker(y,fs);
Y_db = 20*log10(abs(Y))';
% Pick out positive frequencies
freqpos = freq(1:length(freq)/2);
Ypos = Y(1:length(Y)/2);
Y_dbpos = Y_db(1:length(Y_db)/2);

%% Plot spectrum
fig2 = figure(2);
subplot(2,1,1);
plot(freqpos,Y_dbpos,'b');
grid on;
xlabel('Frequency [Hz]','FontSize',15);
ylabel('Amplitude [a.u.]','FontSize',15);
title('Amplitude spectrum','FontSize',20);
set(gcf,'Position',[0 0 1920 1080]);
subplot(2,1,2);
plot(freqpos,angle(Ypos)*180/pi,'b');
xlabel('Frequency [Hz]','FontSize',15);
ylabel('Phase [Degrees]','FontSize',15);
title('Phase spectrum','FontSize',20);
grid on;

%% Create frequency vector
durationNew = 2;
F_0 = 1/durationNew;
f_0 = 130;
freq = 0:F_0:fs-F_0;
Ynew = ones(1,length(freq))*1e-4;
for i = 1:15
    Ynew(i*f_0+1) = 0.5*exp(-0.5*i)*100;
end
Ynew(length(Ynew)/2+2:end) = fliplr(Ynew(2:length(Ynew)/2));
Ynew_db = 20*log10(Ynew);

%% Plot new spectrum
fig3 = figure(3);
subplot(2,1,1);
plot(freq-fs/2,fftshift(Ynew_db),'b');
xlabel('Frequency [Hz]','FontSize',15);
ylabel('Amplitude [a.u.]','FontSize',15);
title('Amplitude spectrum','FontSize',20);
xlim([-fs/2 fs/2]);
grid on;
ylim([min(Ynew_db) 0]);
subplot(2,1,2);
plot(freq,angle(Ynew)*180/pi,'b');
xlabel('Frequency [Hz]','FontSize',15);
ylabel('Phase [Deg]','FontSize',15);
title('Phase spectrum','FontSize',20);
grid on;
set(gcf,'Position',[0 0 1920 1080]);

%% Compute inverse Fourier transform and obtain time signal
ynew = real(ifft(Ynew));
% Normalize signal
ynew = ynew/max(ynew)*.9;
t = 0:1/fs:durationNew-1/fs;
fig4 = figure(4);
plot(t,ynew,'b');
xlabel('Time [s]','FontSize',15);
ylabel('Signal value [a.u.]','FontSize',15);
title('Plot of created time signal','FontSize',20);
grid on;
set(gcf,'Position',[0 0 1920 1080]);
xlim([0 2]);

%% Export figures and close them
hgexport(fig1,'time_plot_piano');
saveas(fig1,'time_plot_piano.png');
hgexport(fig2,'spectrum_piano');
saveas(fig2,'spectrum_piano.png');
hgexport(fig3,'spectrum_selfmade');
saveas(fig3,'spectrum_selfmade.png');
hgexport(fig4,'time_selfmade');
saveas(fig4,'time_selfmade.png');
close all;

%% Play sounds
sound(ynew,fs)
pause(3)
sound(y,fs)
