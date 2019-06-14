% %BODE ; NYQUIST ; RLOCUS
% clc
% clear all
% n=input('enter the no. of variable for the numerator');
% for i=1:n+1
%         n(1,i)=input('enter the variable'); 
% end
% disp(n)
% d=input('enter the no. of variable for the denominator');
% for i=1:d+1
%       d(1,i)=input('enter the value for the denominator variables');
%  
% end
% disp(d)
% sys=tf(n,d)
% subplot(2,2,1)
% rlocus(sys)
% subplot(2,2,2)
% bode(sys)
% [mag,phase]=bode(sys,30)
% subplot(2,2,3)
% nyquist(sys)
% % %--------------------------------------------------------------------
% % %--------------------------------------------------------------------
% % q_vs_n plot
clc
clear all
n=input('\n Enter the number of readings:');
disp('\n\n\nenter the readings of discharge');
for i=1:n
    q(1,i)=input('\n enter the discharge');
end
disp('enter the readings of speed');
for i=1:n
    n(1,i)=input('\n enter the speed');
end
ni=min(n)-50:50:max(n)+50;
qi=interp1(q,n,ni,'spline');
plot(qi,ni);
% % % %-----------------------------------------------------------------
% % % %-----------------------------------------------------------------
% % % % 3-d plots
% u=-5:2:5;
% [x,y]=meshgrid(u,u);
% z=cos(x).*cos(y).*exp(-sqrt(x.^2+y.^2)/4);
% subplot(2,2,1)
% surfl(z)
% shading interp
% colormap hot
% subplot(2,2,3)
% surfc(z)
% view(-37.5,20)
% axis('off')
% subplot(2,2,4)
% plot3(x,y,z)
% % %--------------------------------------------------------------------
% % %--------------------------------------------------------------------
% % % assi
% clc
% clear all
% t=1:0.1:10;
% x=sin(t);
% subplot(2,2,1)
% plot(t,x)
% xlabel('t')
% ylabel('sin(t)')
% x=cos(t);
% subplot(2,2,2)
% plot(t,x)
% xlabel('t')
% ylabel('cos(t)')
% x=exp(t);
% subplot(2,2,3)
% plot(t,x)
% xlabel('t')
% ylabel('exp(t)')
% x=log(t);
% subplot(2,2,4)
% plot(t,x)
% xlabel('t')
% ylabel('log(t)')
% % %---------------------------------------------------------------
% % %---------------------------------------------------------------
% % ordinary 2-d sine & cos plots + etc.
% clc
% clear all
% t=1:0.01:10;
% y=t.*sin(t);
% subplot(2,2,1)
% plot(t,y)
% xlabel('t')
% ylabel('t*sin(t)')
% y=sin(t)./t;
% subplot(2,2,2)
% plot(t,y)
% xlabel('t')
% ylabel('sin(t)/t')
% y=(t-1)./(t+1);
% subplot(2,2,3)
% plot(t,y)
% xlabel('t')
% ylabel('(t-1)/(t+1)')
% y=exp(t).*sin(t);
% subplot(2,2,4)
% plot(t,y)
% xlabel('t')
% ylabel('exp(t)/sin(t)')