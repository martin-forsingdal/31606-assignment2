function [] = poles_and_zeros(poles,zeros)
%POLES_AND_ZEROS creates poles/zeros diagram and the spectrum of the system
%   poles=vector containing poles of the system
%   zeros=vector containing zeros of the system

figure('Position',[100 300 800 600],'Color','white');
zplane(zeros,poles);
figure('Position',[1000 300 800 600],'Color','white');
freqz(poly(zeros),poly(poles));
end

