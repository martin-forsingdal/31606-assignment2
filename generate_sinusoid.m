function [time_vector, signal] = generate_sinusoid(amp, f, phase, fs, Ts)
% Generates a sine function.
% Input: amplitude, frequency in Hz, phase in deg, sampling frequency in
% Hz, duration in s: (amp, f, phase, fs, Ts).
% Output: vector containing time, vector containing signal: (time_vector,
% signal)

% Generate time vector from sampling frequency and duration
time_vector = 0:1/fs:Ts-1/fs;

% Synthesize sinusoid with frequency f and phase "phase"
signal = amp.*sin(2*pi*f.*time_vector + phase);

end