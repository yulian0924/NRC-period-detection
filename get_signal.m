function [ signal, t, sig_one ] = get_signal( N, f0, zeta0, T, fs )         
    t = 1:N;
    A1=1;            
    t0=1;               
    Ws=fs*T;       
   
   
while (t0-T>0)
    t0=t0-T;
end
sig1=exp(-(zeta0/sqrt(1-zeta0^2))*(2*pi*f0*(t/fs-t0)).^2).*cos(2*pi*f0*(t/fs-t0));
signal=sig1;
for i=1:N/(T*fs)
    Wss=round(T*fs*i);
    for k=1:N
        if k>Wss            
            signal(k)=signal(k)+sig1(k-Wss);
        end
    end
end
 t = (1:N)/fs;
end

