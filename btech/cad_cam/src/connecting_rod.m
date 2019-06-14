clc
clear all
disp('==============================================================');
disp('************* PROGRAM TO DESIGN A CONNECTING ROD *************');
disp('==============================================================');
pause(1);
disp('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');
disp('=======  PLEASE ENTER ALL VALUES IN ----S.I.----- UNITS ======');
disp('~~~~~~~~~~~~~~~~~~~ OUTPUT IS IN S.I. UNITS ~~~~~~~~~~~~~~~~~~');
disp('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^');
disp('--------- ENTER THE GENERAL DATA FOR THE ENGINE ------');
d(1,1)=input('Enter the dia of piston:=');
d(1,2)=input('Enter the stroke length:=');
d(1,3)=input('Enter the length of connecting rod:=');
d(1,4)=input('Enter the engine/shaft speed in R.P.M:=');
d(1,5)=input('Give the compression ratio:=');
d(1,6)=input('Enter the maximum explosion pressure of gas:=');
a=1/7500;                          % for use in Rankine's Gordan equation
sigc=370e6;                        % MAX. compressive stress
sigtb=85e6;                        % MAX. tensile stress of bolts
area=pi*d(1,1)^2/4;
d(1,7)=1.25*(2*pi*d(1,4)/60);      % angular speed of engine*1.25 as F.O.S
d(1,8)=d(1,2)/2;                   % crank length
d(1,9)=d(1,3)/d(1,8);              % ratio of connecting rod by crank
vols=area*d(1,2);                  % total volume of engine
volc=vols/(d(1,5)-1);              % clearance volume
fgp=d(1,6)*area;                   % gas pressure
mr=0.0035e6*area/9.81;             % mass of reciprocating part in k.g.
j=1;
for i=0:15:180
    t(j,1)=j;                      % S.NO
    t(j,2)=i;                      % Angle theta
    t(j,3)=d(1,8)*(1-cos (i*pi/180)+d(1,9)-sqrt(d(1,9)^2-(sin (i*pi/180))^2)); % x
    t(j,4)=area*t(j,3)+volc;                  % vol at theta
    t(j,5)=d(1,6)*(volc/t(j,4))^1.33;         % press. at theta
    t(j,6)=t(j,5)*area;                       % gas press. theta
    t(j,7)=mr*d(1,7)^2*d(1,8)*(cos (i*pi/180)+(cos (2*i*pi/180))/d(1,9));  % inertia force
    t(j,8)=t(j,6)-t(j,7);                     % force
    t(j,9)=asin(d(1,8)*sin(i*pi/180)/d(1,3))*180/pi;  % angle psi
    t(j,10)=t(j,8)/cos(t(j,9));               % force on connecting rod
    j=j+1;
end
fos=input('Enter the value of F.O.S. <6>:=');
if fos==[]                         % assigning the default fos = 6
    fos=6;
end
wcr=input('Enter the wt. density of connecting rod <78000>:=');
if wcr==[]                         % assigning the default wcr = 78000
    wcr=78000;
end
for i=1:13
    t1=[sigc*11*3.18/fos,-t(i,8)*3.18,-t(i,8)*a*d(1,3)^2];
%   t1=[sigc*11*3.18/fos,0,-t(i,8)*3.18,0,-t(i,8)*a*d(1,3)^2];
    t(i,11)=max(roots(t1));        % thickness of the flange & web of connecting rod
    t(i,11)=sqrt(t(i,11));
end
% t1=max(real(t(:,11))); % calculating max. flange thickness considering real values only
t1=max(t(:,11));                   % calculating max. flange thickness
disp('           S.NO       THETA  LENGTH (X)   VOL.(THETA) PRESS.(THETA) FORCE (FGP)       FORCE(FI) FORCE  ANGLE(PSI)    FORCE(CONNECTING ROD)    THICKNESS(FLANGE)');
disp(t);                           % displaying the table
disp('press button to continue........');
pause;
t1=t1*1000;                        % convert into mm
% t1=abs(t1);
t12=round(t1);                     % rounding of thickness
if t12<t1                          % incrementing the thickness to next higher value
    t1=t12+1;
else
    t1=t12;
end
t1=t1/1000;                        % convert back to meter
disp('DIMENSIONS OF "I-section" CONNECTING ROD BEFORE CHECKING F.O.S.')
disp('The max. thickness of flange & web available in meters is:=');
disp(t1);
disp('For corresponding thickness of the "I" section ');
disp('Length:=');
disp(5*t1);
disp('Width:=');
disp(4*t1);
wcr=wcr*d(1,3)*11*t1^2;            % weight of connecting rod
fi=wcr*d(1,7)^2*d(1,8)/(2*9.81);   % inertia of connecting rod
mo=2*fi*d(1,3)/(9*sqrt(3));        % max. B.M. of connecting rod
sigb=mo/(419*t1^3/30);             % bending stress on connecting rod
sigcc=sigc/6+sigb;
fos=sigc/sigcc;
% disp('Default value of factor of safety is small');
while fos<=4.5 | fos>=5.5          % F.O.S. must lie b/w 4.5 & 5.5
    if fos<=4.5
        t1=t1+0.001;
    end
    if fos>=5.5                    % If F.O.S. is > 5.5
        t1=t1-0.001;
    end
    sigb=mo/(419*t1^3/30);         % bending stress on connecting rod
    sigcc=sigc/6+sigb;
    fos=sigc/sigcc;
end
disp('DIMENSION OF "I-section" CONNECTING ROD AFTER CHECKING F.O.S');
disp(' ');
disp('Maintaining the final F.O.S. between 4.5 to 5.5');
disp('press button to continue........');
pause;
disp(' ');
disp('FOR FINAL F.O.S = 5 "WE HAVE"');
disp(' ');
disp('The MAX. thickness of flange & web available in meteres is:=');
disp(t1);
disp('Length:=');
disp(5*t1);
disp('Width:=');
disp(4*t1);
disp('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');
disp('SOLVING FOR BOLTS');
disp('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');
disp('Press button to continue:::::________');
pause;
for i=1:13
    t(i,12)=sqrt((t(i,7)*4)/(2*sigtb*pi));  % bolt core dia.
    t(i,13)=1.2*t(i,12);                    % bolt outer dia.
end
t(:,13)=max(t(:,13));               % maximum outer dia
i=0;
if t(1,13)<=0.024                   % standardising bolt upto 24mm
    while t(1,13)~=i
        i=i+0.002;
        if t(1,13)<i
            t(:,13)=i;
        end
    end
end
i=0.024;
if t(1,13)>0.024                    % standardising bolt upto 39mm
    while t(1,13)~=i
        i=i+0.003;
        if t(1,13)<i
            t(:,13)=i;
        end
    end
end
disp('The bolt ot be used is = M');
disp(t(1,13));
disp('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');
disp('SOLVING FOR SMALL END');
disp('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');
disp('Press button to continue:::::________');
pause;
l1=0.45*d(1,1);                     % length of small end <= 0.45*piston dia.
d1=d(1,1)/3;                        % dia. of small end <= piston dia./3
while l1/d1<1.5 | l1/d1>2.0         % l1/d1 b/w 1.5 to 2.0
    if l1/d1<1.5
        d1=d1-0.001;
    end
    if l1/d1>2.0
        l1=l1-0.001;
    end
end
pb=fgp/(l1*d1);                     
while pb>39e6                       % pb (bearing pressure) <= 39 N/mm^2
    d1=d1+0.001;
    pb=fgp/(l1*d1);
end
disp('Length of small end of connecting rod');
disp(l1);
disp('Dia. of small end');
disp(d1);
disp('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');
disp('DESIGNING BIG END OF THE CONNECTING ROD');
disp('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');
disp('Press button to continue:::::________');
pause;
d2=0.7*d(1,1);                      % dia. b/w 0.67 to 0.73 of piston dia.
l2=1.5*d2;                          % length=(0.5 to 1.5) of big end dia.
pb=fgp/(l2*d2);
while pb<=7e6 | pb>=15e6            % bearing pressure b/w 7 to 15
    if pb<=7e6
        l2=l2-0.001;
    end
    if pb>=15e6
        l2=l2+0.001;
    end
    pb=fgp/(l2*d2);
end
disp('Length of big end of connecting rod');
disp(l2);
disp('Dia. of big end');
disp(d2);
disp('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');
disp('SOLVING FOR CAP DIMENSIONS');
disp('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');
disp('Press button to continue:::::________');
pause;
l3=d2+2*0.005+t(1,13)+2*0.005;      % length b/w the bolts in the cap
for i=1:13
    t(i,14)=sqrt((t(i,7)*l3)/(l2*sigb));    % cap thickness
end
t(1,14)=max(t(:,14));
t(1,14)=t(1,14)*1000;
if t(1,14) < round(t(1,14))         % rounding of cap thickness to higher value
    t(1,14)=round(t(1,14));
elseif t(1,14) > round(t(1,14))
    t(1,14)=round(t(1,14))+1;
end
disp('length b/w the bolts end is:=');
disp(l3);
disp('Thickness of cap is');
disp(t(1,14)/1000);
% ==================END OF PROGRAM===================
% For finding the the flange thickness roots of second order are calculated
% istead of order 4.  This is done to eliminate the complex roots.
% Roots generated by second order are then further square rooted to generate
% the real value of the flange