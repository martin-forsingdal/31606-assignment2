function [Y, freq] = spectrum_maker(signal, fs)
% Function computes complex-valued Fourier-spectrum of signal "signal" with
% sampling frequency fs.
% Input: signal to transform, "signal", sampling frequency of signal, fs:
% (signal, fs).
% Output: Complex-valued spectrum, Y, frequency vector: (Y, freq):

% Compute spectrum
Y = fft(signal);

% Perform scaling of spectrum
Y = Y/length(Y);

% Delete elements for which the amplitude is less than 60 dB
Ydb = 20*log10(abs(Y));
Y(Ydb<-60) = 0;

% Frequency vector
F_0 = fs/length(Y);
freq = 0:F_0:fs-F_0;

end