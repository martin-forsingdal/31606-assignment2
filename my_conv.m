function [y] = my_conv(h,x)
%FCONV Summary of this function goes here
%   Detailed explanation goes here

len=length([h,x])-1;
h=[h,zeros(1,len-length(h))];
x=[x,zeros(1,len-length(x))];
H=fft(h);
X=fft(x);
y=real(ifft(H*X));
end

