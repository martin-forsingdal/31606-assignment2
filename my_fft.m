function [F] = my_fft(even,odd)
%FFT_OWM Summary of this function goes here
%   Detailed explanation goes here

len=length([even,odd]);
if bitand(len,len-1) ~= 0
    error('Length of the input signal is not a power of 2');
end
k=0:len/2-1;
twid=exp(-1i*2*pi*k/len);
F=[even+twid.*odd,even-twid.*odd];
end

