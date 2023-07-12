s=tf('s');
Gs_no_dis = 12000/(s^3+30*s^2+200*s+12000); %%closed-loop TF with 0 disturbance
Gs_dis = (11960*s-400)/(s^4+30*s^3+200*s^2+11960*s-400); %% closed-loop TF with step disturbance

figure(1)
step(Gs_no_dis)
grid

figure(2)
step(Gs_dis)
grid