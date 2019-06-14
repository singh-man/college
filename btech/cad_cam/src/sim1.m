clc;
clear all;
n=input(' enter the total no. of readings = ');
s=input(' enter the no. of readings in each subgroup = ');
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

xdbar=mean(x(:,s+1));
sigmabar=mean(x(:,s+2));
rbar=mean(x(:,s+3));

fr=[0;0;0;0;0;0;0;0;0;0;0];     % fr(11,1)
fr1=[0;6;12;18;24;30;36;42;48;54;60];
for i=1:n/s                     % frequency calculations
    for j=1:s
        for k=1:11
            if fr1(k,1)<x(i,j) & fr1(k+1,1)>=x(i,j)
                fr(k,1)=fr(k,1)+1;
                break;
            end
        end
    end
end
         
q=0:6:60;
qi=0:0.1:60;
fri=interp1(q,fr,qi,'cubic');
plot(qi,fri,'r',q,fr,'o');
hold on;
bar(q,fr,1,'y');
grid on;      

disp('% error in the sample mean w.r.t the univ. avg. is =');
((xdbar-30)/30)*100

disp('% error in the calculated sigma prime w.r.t the univ. =');
if s==4
    (((rbar/2.059)-9.954)/9.954)*100
elseif s==5
    (((rbar/2.326)-9.954)/9.954)*100
end
disp('std. deviation of the expected frequency');
if s==4
    9.954/sqrt(s)
elseif s==5
    9.9540/sqrt(s)
end