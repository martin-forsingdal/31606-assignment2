%% Exercise 3.1
% Clear workspace and command window
clear all;
clc;
set(0,'DefaultFigureVisible','off');

%% Read sound file
filename = 'piano.wav';
[y fs] = audioread(filename);
% Play the sound file
sound(y,fs);
pause(length(y)/fs);
%% Plot sound signal
% Create time vector
dur = length(y)/fs;
t = 0:1/fs:1-1/fs;
fig1 = figure(1);
plot(t,y(1:length(t)),'b');
xlabel('Time [t]','FontSize',15);
ylabel('Signal [a.u.]','FontSize',15);
grid on;
set(gcf,'Position',[100 100 800 500]);
set(gca,'Fontsize',12)
%% Compute spectrum of original signal
[Y, freq] = spectrum_maker(y,fs);
Y_db = 20*log10(abs(Y))';
% Pick out positive frequencies
freqpos = freq(1:length(freq)/2);
Ypos = Y(1:length(Y)/2);
Y_dbpos = Y_db(1:length(Y_db)/2);

%% Plot spectrum of origianl signal
fig2 = figure(2);
subplot(2,1,1);
plot(freqpos,Y_dbpos,'b');
grid on;
xlabel('Frequency [Hz]','FontSize',15);
ylabel('Amplitude [dB]','FontSize',15);
xlim([0 fs/2]);
set(gcf,'Position',[100 100 1000 600]);
set(gca,'Fontsize',12)
subplot(2,1,2);
plot(freqpos,angle(Ypos)*180/pi,'b');
xlabel('Frequency [Hz]','FontSize',15);
ylabel('Phase [Degrees]','FontSize',15);
xlim([0 fs/2]);
grid on;
set(gca,'Fontsize',12)
%% Create F_synth1[k] and F_synth2[k]
% N, the number of frequency components in synthetic spectrum is
N=20;
% Create frequency vector and synthezised spectrums
dur_synth = 2;
F_0 = 1/dur_synth;
% The fundamental frequency f_0 is
f_0 = 130.5;
% Define frequency vector (same for F_synth1[k] and F_synth2[k]
freq = 0:F_0:fs-F_0;
% Define spectrums
F_synth1 = ones(1,length(freq))*1e-4;
F_synth2 = ones(1,length(freq))*1e-4;
for i = 1:N
    % Define the i'th fundamental frequency component fo F_synth1
    F_synth1(dur_synth*i*f_0+1) = 1;
    % Use the phase at the magnitude peaks in the 
    % original spectrum as the i'th phase of F_synth2
    phase_Fsynth2=angle(Y(int16(dur*i*f_0)+1));
    % Define the i'th fundamental frequency component fo F_synth2
    F_synth2(dur_synth*i*f_0+1) = exp(-i/8)*exp(j*phase_Fsynth2);
end
% Ensure complex conjugate symmetry around Omega=0
F_synth1(length(F_synth1)/2+2:end) = fliplr(F_synth1(2:length(F_synth1)/2));
F_synth2(length(F_synth2)/2+2:end) = conj(fliplr(F_synth2(2:length(F_synth2)/2)));
F_synth1_db = 20*log10(F_synth1);
F_synth2_db = 20*log10(abs(F_synth2));

%% Plot new spectrum with phase 0
fig3 = figure(3);
subplot(2,1,1);
plot(freq-fs/2,fftshift(F_synth1_db),'g');
xlabel('Frequency [Hz]','FontSize',15);
ylabel('Amplitude [dB]','FontSize',15);
%title('Amplitude spectrum','FontSize',20);
xlim([-fs/8 fs/8]);
grid on;
ylim([min(F_synth1_db)*1.1 10]);
set(gca,'Fontsize',12)
subplot(2,1,2);
plot(freq-fs/2,fftshift(angle(F_synth1))*180/pi,'g');
xlabel('Frequency [Hz]','FontSize',15);
ylabel('Phase [Deg]','FontSize',15);
%title('Phase spectrum','FontSize',20);
xlim([-fs/8 fs/8]);
ylim([-180 180]);
grid on;
set(gcf,'Position',[100 100 1000 600]);
set(gca,'Fontsize',12)
%% Plot new spectrum with varied phase
fig4 = figure(4);
subplot(2,1,1);
plot(freq-fs/2,fftshift(F_synth2_db),'r');
xlabel('Frequency [Hz]','FontSize',15);
ylabel('Amplitude [dB]','FontSize',15);
%title('Amplitude spectrum','FontSize',20);
xlim([-fs/8 fs/8]);
grid on;
ylim([min(F_synth2_db)*1.1 10]);
set(gca,'Fontsize',12)
subplot(2,1,2);
plot(freq-fs/2,fftshift(angle(F_synth2))*180/pi,'r');
xlabel('Frequency [Hz]','FontSize',15);
ylabel('Phase [Deg]','FontSize',15);
%title('Phase spectrum','FontSize',20);
xlim([-fs/8 fs/8]);
ylim([-180 180]);
grid on;
set(gcf,'Position',[100 100 1000 600]);
set(gca,'Fontsize',12)
%% Compute inverse Fourier transform and obtain time signal
ynew = ifft(F_synth1);
ynew2 = ifft(F_synth2);
% Normalize signal
ynew = ynew/max(ynew)*.9;
ynew2 = ynew2/max(ynew2)*.9;
t = 0:1/fs:dur_synth-1/fs;
fig5 = figure(5);
plot(t,ynew,'g');
xlabel('Time [s]','FontSize',15);
ylabel('Signal value [a.u.]','FontSize',15);
%title('Plot of created time signal','FontSize',20);
grid on;
set(gcf,'Position',[100 100 1000 600]);
xlim([0 2]);
ylim([-0.4 1.1]);
set(gca,'Fontsize',12)
fig6 = figure(6);
plot(t,ynew2,'r');
xlabel('Time [s]','FontSize',15);
ylabel('Signal value [a.u.]','FontSize',15);
%title('Plot of created time signal','FontSize',20);
grid on;
set(gcf,'Position',[100 100 1000 600]);
xlim([0 2]);
ylim([-0.4 1.1]);
set(gca,'Fontsize',12)

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

