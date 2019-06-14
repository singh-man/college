clc
clear all
clear
hold on
tspan=[0 .1];
z0=[0];
[t,z]=ode23('rlcircuit',tspan,z0);
x=z(:,1);
plot(t,x)
[t,z]=ode45('rlcircuit',tspan,z0);
x=z(:,1);
plot(t,x,'r')
t=linspace(0,0.1);
x=(1.5/2)*(1-exp((-t*2)/2e-3));
plot(t,x,'g')
xlabel('time(t)')
ylabel('current(i)')
title('plot for rl circuit')