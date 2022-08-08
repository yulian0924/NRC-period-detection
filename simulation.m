
%% simulation_demo: Noise resistant correlation for period detection
% Example illustrating the period detection of a periodic signal with
% strong background noise without any prior information
% If the background noise is stronger,you can extend the signal length to
% get a better detection result.
%
% Reference:
% Wei Fan, Yongxiang Li, K.L. Tsui, et al. A Noise Resistant Correlation
% Method for Period Detection of Noisy Signals, IEEE Transactions on Signal
% Processing, 2018, 66 (10): 2700-2710. 

% Copyright from Wei Fan, when you use this code, please cite the above
% reference, contact via weifan@ujs.edu.cn
%%
clear all
close all
clc
%%
fs = 500;   N =200000; % N is the signal length
f0 = 20;    T = 2; % T is the true period 
zeta0=0.01;     sigma =2; % sigma of the noise
[orginSignal, t] = get_signal(N, f0, zeta0, T,fs); % noise free simulated signal 
figure;plot(t,orginSignal)
noise = sigma*randn(size(orginSignal)); % background noise
SNR=10*log10(sum((orginSignal).^2)/sum((noise).^2)); % signal to noise ratio
noiseSignal = orginSignal +noise;
%% Detection of the period
period = (1:1:5000)';
C = zeros(size(period));
V = zeros(size(period));
C2 = zeros(size(period));
for i = 1 : length(period)
    % cut signal
    Y =  cut_signal(period(i),noiseSignal);
    Yhat = mean(Y,2)';
    l = numel(Y);   m = size(Y,2);
    C(i) = Yhat*Yhat'/length(Yhat);
    V(i) = noiseSignal(1:l)*noiseSignal(1:l)'/l - C(i);
    C2(i) = C(i) - V(i)/(m-1);
end
figure; plot(period/fs, C2); 
