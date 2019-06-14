clc;
clear all;
n=input('enter the total no. of readings "n" < 240 >=');
if n==[]                         % assigning the default n = 240
    n=240;
end
s=input('enter the no. of readings in each subgroup "s" < 4 >=');
if s==[]                         % assigning the default s = 4
    s=4;
end
disp('************************************************');
disp('Enter 1 -> To use the default values');
disp('Enter 2 -> To manually enter the data');
disp('************************************************');
ch=input('Enter your choice = ');
if ch==1
    y=[10;30;17;30;37;45;14;18;28;45;25;10;32;28;30;31;16;34;8;32;
       39;41;21;25;28;33;17;42;49;37;30;23;30;29;12;32;34;26;33;29;
       34;18;43;56;27;22;19;49;48;28;20;30;18;27;20;23;18;40;31;58;
       19;47;19;30;29;44;24;29;40;24;22;33;23;35;42;29;47;50;34;26;
       45;23;26;26;27;24;38;55;19;34;18;43;37;18;30;7;28;18;16;28;
       35;51;44;35;29;41;37;26;55;27;23;29;27;14;39;29;48;42;37;26;
       41;21;27;14;20;28;14;40;37;36;18;49;28;34;31;32;39;42;27;33;
       32;35;30;19;35;32;31;26;36;19;25;48;6;19;17;7;27;31;44;24;34;
       28;38;40;17;5;23;17;12;22;51;4;16;24;29;21;22;28;35;41;24;16;
       37;25;30;45;26;35;40;31;21;36;13;20;57;19;40;32;31;30;46;13;
       31;35;30;15;21;30;52;27;36;20;41;34;36;26;18;30;34;32;8;45;17;
       39;32;16;42;55;20;27;14;15;44;25;23;40;29;50;56;33];
    
    k=1;
    for i=1:n/s          % n*s matrix making
        for j=1:s
            x(i,j)=y(k,1);
            k=k+1;
        end
    end
end
if ch==2            % manual entering of the data
    disp('Enter the data rowwise');
    for i=1:n/s
        for j=1:s
            x(i,j)=input('data : ');
        end
    end
end
t(:,1)=mean(x,2);   % mean of the data row wise (mean(x) gives column wise)
t(:,2)=std(x,1,2);  % std(x,0,1) calculates std. for (sigma n-1)
t(:,3)=(range(x'))';
x(:,s+1)=t(:,1);    % preparing the table
x(:,s+2)=t(:,2);
x(:,s+3)=t(:,3);
xdbar=mean(x(:,s+1));   % x double bar
sigmabar=mean(x(:,s+2));    %sigma bar
rbar=mean(x(:,s+3));    % r bar
disp('the Xdbar is =');
disp(xdbar);
disp('the Rbar is =');
disp(rbar);
disp('the sigmabar is =');
disp(sigmabar);

p=1:n/s;
% calculating data for the x bar-chart
a2=input('enter the data for "A2" from table C < s=4 > =');
if a2==[]                         % assigning the default a2 = 0.73
    a2=0.73;
end
uclx=xdbar+a2*rbar;
lclx=xdbar-a2*rbar;
% calculating data for the range r-chart
d4=input('enter the data for "D4" from table C < s=4 > =');
if d4==[]                         % assigning the default d4 = 2.28
    d4=2.28;
end
d3=input('enter the data for "D3" from table C < s<=6 > =');
if d3==[]                         % assigning the default d3 = 0
    d3=0;
end
uclr=d4*rbar;
lclr=d3*rbar;
%calculating the data for the sigma bar chart
b4=input('enter the data for "B4" from table D < s=4 > =');
if b4==[]                         % assigning the default b4 = 2.57
    b4=2.57;
end
b3=input('enter the data for "B3" from table D < s<=5 > =');
if b3==[]                         % assigning the default b3 = 0
    b3=0;
end
uclsigma=b4*sigmabar;
lclsigma=b3*sigmabar;
% ploting all the three graphs
subplot(2,2,1);
plot(p,x(:,s+1),'r',p,xdbar,'+',p,lclx,'g',p,uclx,'g');
xlabel('subgroups');
ylabel('average');
title('XBAR CHART');

subplot(2,2,2);
plot(p,x(:,s+3),'r',p,rbar,'+',p,lclr,'g',p,uclr,'g');
xlabel('subgroups');
ylabel('range');
title('R-CHART');

subplot(2,2,3);
plot(p,x(:,s+2),'r',p,sigmabar,'+',p,lclsigma,'g',p,uclsigma,'g');
xlabel('subgroups');
ylabel('sigma');
title('SIGMA CHART');

% fr=[0;0;0;0;0;0;0;0;0;0;0];     % fr(11,1)
% fr(1,1)=0;              % 0-60 in steps 0f 6, 11 divisions hence fr(1,1)=0
% for i=1:240                 % frequency counting
%     if y(i,1)>=1 & y(i,1)<=6
%         fr(2,1)=fr(2,1)+1;
%     end
%     if y(i,1)>6 & y(i,1)<=12
%         fr(3,1)=fr(3,1)+1;
%     end
%     if y(i,1)>12 & y(i,1)<=18
%         fr(4,1)=fr(4,1)+1;
%     end
%     if y(i,1)>18 & y(i,1)<=24
%         fr(5,1)=fr(5,1)+1;
%     end
%     if y(i,1)>24 & y(i,1)<=30
%         fr(6,1)=fr(6,1)+1;
%     end
%     if y(i,1)>30 & y(i,1)<=36
%         fr(7,1)=fr(7,1)+1;
%     end
%     if y(i,1)>36 & y(i,1)<=42
%         fr(8,1)=fr(8,1)+1;
%     end
%     if y(i,1)>42 & y(i,1)<=48
%         fr(9,1)=fr(9,1)+1;
%     end
%     if y(i,1)>48 & y(i,1)<=54
%         fr(10,1)=fr(10,1)+1;
%     end
%     if y(i,1)>54 & y(i,1)<=60
%         fr(11,1)=fr(11,1)+1;
%     end
% end
% q=0:6:60;
% qi=0:0.1:60;
% fri=interp1(q,fr,qi,'cubic');
% subplot(2,2,4);
% plot(qi,fri,q,fr,'o');
% hold on;
% bar(q,fr);
% grid on;
disp('                     data                    Xdbar   sigmabar    range');
disp(x);