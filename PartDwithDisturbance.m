s=tf('s');
Gscl= (40*(299*s-10))/(s^4+30*s^3+200*s^2+11960*s-400); %% closed-loop TF
Gs = (300/(s+10)-1/s)*(40/(s*(s+20))); %% open-loop TF

figure(1)
margin(Gscl)

[Gm,Pm,Wcg,Wcp] = margin(Gscl);
phi = 55-Pm+5;
alpha = ((1+sind(phi))/(1-sind(phi)));
M = 20*log10(1/sqrt(alpha));


[mag,phase,wout] = bode(Gscl);
mag = squeeze(mag);
phase = squeeze(phase);
wm = interp1(20*log10(mag), wout, M);  

T_lead = 1/(wm*sqrt(alpha))
Gcs = (T_lead*alpha*s+1)/(T_lead*s+1)


Gs_new = feedback(Gs*0.7*Gcs,1); %% Compensated closed-loop TF

figure(2)
margin(Gs_new)

[Gm,Pm,Wcg,Wcp] = margin(Gs_new);
phi = 50-Pm+5;
alpha = ((1+sind(phi))/(1-sind(phi)));
M = 20*log10(1/sqrt(alpha));


[mag,phase,wout] = bode(Gs_new);
mag = squeeze(mag);
phase = squeeze(phase);
wm = interp1(20*log10(mag), wout, M);  

T_lead = 1/(wm*sqrt(alpha));
Gcs_new = (T_lead*alpha*s+1)/(T_lead*s+1);
GG= feedback(Gs*Gcs*0.83*Gcs_new, 1); %% Two-stage compensator TF

figure(3)
margin(GG)

figure(4)
step(GG)

stepinfo(GG)

bw = bandwidth(GG)% bandwidth