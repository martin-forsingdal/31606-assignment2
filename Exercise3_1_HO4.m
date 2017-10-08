%% Exercise 3.1
% Clear workspace and command window
clear all;
clc;
set(0,'DefaultFigureVisible','off');

%% Read sound file
filename = 'piano.wav';
[y fs] = audioread(filename);
sound(y,fs);
pause(length(y)/fs);
%% Plot sound signal
% Create time vector
duration = length(y)/fs;
t = 0:1/fs:1-1/fs;
fig1 = figure(1);
plot(t,y(1:length(t)),'b');
xlabel('Time [t]','FontSize',15);
ylabel('Signal [a.u.]','FontSize',15);
%title('Plot of sound signal','FontSize',20);
grid on;
set(gcf,'Position',[100 100 800 500]);

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
%title('Amplitude spectrum','FontSize',20);
xlim([0 fs/2]);
set(gcf,'Position',[100 100 1000 600]);
subplot(2,1,2);
plot(freqpos,angle(Ypos)*180/pi,'b');
xlabel('Frequency [Hz]','FontSize',15);
ylabel('Phase [Degrees]','FontSize',15);
%title('Phase spectrum','FontSize',20);
xlim([0 fs/2]);
grid on;

%% Create frequency vector and spectrum
durationNew = 2;
phase=-pi/5;
F_0 = 1/durationNew;
f_0 = 130.5;
freq = 0:F_0:fs-F_0;
Ynew = ones(1,length(freq))*1e-4;
Ynew2 = ones(1,length(freq))*1e-4;
rk=0;
for i = 1:20
    Ynew(int16(2*i*f_0)+1) = 1;
    Ynew2(int16(2*i*f_0)+1) = exp(-i/8)*exp(-j*phase*i);
end
Ynew(length(Ynew)/2+2:end) = fliplr(Ynew(2:length(Ynew)/2));
Ynew2(length(Ynew2)/2+2:end) = conj(fliplr(Ynew2(2:length(Ynew2)/2)));
Ynew_db = 20*log10(Ynew);
Ynew_db2 = 20*log10(abs(Ynew2));

%% Plot new spectrum with phase 0
fig3 = figure(3);
subplot(2,1,1);
plot(freq-fs/2,fftshift(Ynew_db),'b');
xlabel('Frequency [Hz]','FontSize',15);
ylabel('Amplitude [a.u.]','FontSize',15);
%title('Amplitude spectrum','FontSize',20);
xlim([-fs/8 fs/8]);
grid on;
ylim([min(Ynew_db)*1.1 10]);
subplot(2,1,2);
plot(freq-fs/2,fftshift(angle(Ynew))*180/pi,'b');
xlabel('Frequency [Hz]','FontSize',15);
ylabel('Phase [Deg]','FontSize',15);
%title('Phase spectrum','FontSize',20);
xlim([-fs/8 fs/8]);
ylim([-180 180]);
grid on;
set(gcf,'Position',[100 100 1000 600]);

%% Plot new spectrum with varied phase
fig4 = figure(4);
subplot(2,1,1);
plot(freq-fs/2,fftshift(Ynew_db2),'b');
xlabel('Frequency [Hz]','FontSize',15);
ylabel('Amplitude [a.u.]','FontSize',15);
%title('Amplitude spectrum','FontSize',20);
xlim([-fs/8 fs/8]);
grid on;
ylim([min(Ynew_db2)*1.1 10]);
subplot(2,1,2);
plot(freq-fs/2,fftshift(angle(Ynew2))*180/pi,'b');
xlabel('Frequency [Hz]','FontSize',15);
ylabel('Phase [Deg]','FontSize',15);
%title('Phase spectrum','FontSize',20);
xlim([-fs/8 fs/8]);
ylim([-180 180]);
grid on;
set(gcf,'Position',[100 100 1000 600]);

%% Compute inverse Fourier transform and obtain time signal
ynew = ifft(Ynew);
ynew2 = ifft(Ynew2);
% Normalize signal
ynew = ynew/max(ynew)*.9;
ynew2 = ynew2/max(ynew2)*.9;
t = 0:1/fs:durationNew-1/fs;
fig5 = figure(5);
plot(t,ynew,'b');
xlabel('Time [s]','FontSize',15);
ylabel('Signal value [a.u.]','FontSize',15);
%title('Plot of created time signal','FontSize',20);
grid on;
set(gcf,'Position',[100 100 1000 600]);
xlim([0 2]);
ylim([-0.4 1.1]);

fig6 = figure(6);
plot(t,ynew2,'b');
xlabel('Time [s]','FontSize',15);
ylabel('Signal value [a.u.]','FontSize',15);
%title('Plot of created time signal','FontSize',20);
grid on;
set(gcf,'Position',[100 100 1000 600]);
xlim([0 2]);
ylim([-0.4 1.1]);
%% Export figures and close them
hgexport(fig1,'pianoTone_time_orig');
saveas(fig1,'pianoTone_time_orig.png');
hgexport(fig2,'pianoTone_spec_orig');
saveas(fig2,'pianoTone_spec_orig.png');
hgexport(fig3,'pianoTone_spec_1');
saveas(fig3,'pianoTone_spec_1.png');
hgexport(fig4,'pianoTone_spec_2');
saveas(fig4,'pianoTone_spec_2.png');
hgexport(fig5,'pianoTone_time_1');
saveas(fig5,'pianoTone_time_1.png');
hgexport(fig6,'pianoTone_time_2');
saveas(fig6,'pianoTone_time_2.png');
close all;

%% Play sounds
sound(ynew,fs)
pause(length(ynew)/fs*1.2)
sound(ynew2,fs)
pause(length(ynew2)/fs*1.2)
sound(y,fs)

