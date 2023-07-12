s=tf('s');
Gscl= (11960*s-400)/(s^4+30*s^3+200*s^2+11960*s-400); %% closed-loop TF
Gs = (300/(s+10)-1/s)*(40/(s*(s+20))); %% open-loop TF
figure(1)
margin(Gscl)

[Gm,Pm,Wcg,Wcp] = margin(Gscl); %% current Margins
phi = 30-Pm+5; %% angle of compensation
alpha = ((1+sind(phi))/(1-sind(phi)));

M = 20*log10(1/sqrt(alpha)); 
[mag,phase,wout] = bode(Gscl);
mag = squeeze(mag);
phase = squeeze(phase);
wm = interp1(20*log10(mag), wout, M); %% corner frequency 

T_lead = 1/(wm*sqrt(alpha));

Gcs = (T_lead*alpha*s+1)/(T_lead*s+1); %% lead compensator

GG = feedback(0.75*Gcs*Gs,1); %% new closed-loop TF with compensator



figure(2)
margin(GG)

figure(3)
step(GG)

stepinfo(GG)

bw = bandwidth(GG)% bandwidth