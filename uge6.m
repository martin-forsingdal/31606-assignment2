%%init
clc
clear
close all

%% design filter
% specify the attenuations (positive numbers!)
Gp = 2;    
Gs = 11;

% specify the frequencies
w_p = 8;    
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
freqz(B, A);