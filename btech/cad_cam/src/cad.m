clear all;
clc;
clear fig;
ch=1;
while ch~=0
disp('enter your choice');
disp('1 for rotation reflection & scaling of atriangle');
disp('2 for reflection about line y=1/2(x+4)');
disp('3 for orthographic projection from a 3-D object');
disp('4 for sweep surface');
ch=input('enter your choice');
switch ch;
case 1,
    a=[0,0];                            %co-ordinate A
    b=[2,0];                            %co-ordinate B
    c=[1,1];                            %co-ordinate C
    x=[a;b;c];                          %co-ordinates to single matrix
    xx=x(:,1);
    xx=[xx;x(1,1)];                     %adding back co-ordinae A to close the plot
    xy=x(:,2);
    xy=[xy;x(1,2)];
    theta=input('entet the angle by which the rotation has to be done');
    theta=theta*pi/180;
    scale=input('enter the scaling factor');
    plot(xx,xy);                        %origianl plot
    grid on;
    axis equal;
    hold on;
    tr=[cos(theta) sin(theta);-sin(theta) cos(theta)];  %rotation about an angle
    xs=x*tr;                            %transformed matrix
    xsx=xs(:,1);
    xsx=[xsx;xs(1,1)];
    xsy=xs(:,2);
    xsy=[xsy;xs(1,2)];
    plot(xsx,xsy,'m');
    tre=[-1 0;0 1];                     %reflection about y-axis
    xs=x*tre;
    xsx=xs(:,1);
    xsx=[xsx;xs(1,1)];
    xsy=xs(:,2);
    xsy=[xsy;xs(1,2)];
    plot(xsx,xsy,'g');
    ts=[scale 0;0 scale];               %scaling factor
    xs=x*ts;
    xsx=xs(:,1);
    xsx=[xsx;xs(1,1)];
    xsy=xs(:,2);
    xsy=[xsy;xs(1,2)];
    plot(xsx,xsy,'r');
    title('rotation(yellow), reflection along y-axis (green), scaling (red)');
case 2,
    ezplot('1/2*(x+4)');        %plotting the line
    grid on;
    hold on;
    a=[2,4,1];                  %co-ordinates of A
    b=[4,6,1];                  %co-ordinates of B
    c=[2,6,1];                  %co-ordinates of C
    x=[a;b;c];                  %A,B,C to a matrix
    xx=x(:,1);
    xx=[xx;x(1,1)];             %to close the plot
    xy=x(:,2);
    xy=[xy;x(1,2)];
    plot(xx,xy);                %origianl plot
    t1=[1 0 0;0 1 0;0 -2 1];
    theta=atan(1/2);            %slpoe=1/2 and the angle is in radians
    t2=[cos(theta) -sin(theta) 0;sin(theta) cos(theta) 0;0 0 1];
    t3=[1 0 0;0 -1 0;0 0 1];
    ts=t1*t2*t3*inv(t2)*inv(t1);
    xs=x*ts;
    xsx=xs(:,1);
    xsx=[xsx;xs(1,1)];
    xsy=xs(:,2);
    xsy=[xsy;xs(1,2)];
    plot(xsx,xsy,'m');
    title('reflection about a line y=1/2(x+4)');
case 3,
    x=[0 0 1 1;
       1 0 1 1;
       1 0.5 1 1;
       0.5 1 1 1
       0 1 1 1;
       0 0 0 1;
       1 0 0 1;
       1 1 0 1;
       0 1 0 1;
       1 1 0.5 1];
    pz=[1 0 0 0
        0 1 0 0
        0 0 0 0
        0 0 0 1];
%     s=[0 1 0 0 1 1 0 0 0 0;
%        0 0 1 0 0 0 1 0 0 0;
%        0 0 0 1 0 0 0 0 0 1;
%        0 0 0 0 1 0 0 0 0 1;
%        0 0 0 0 0 0 0 0 1 0;
%        0 0 0 0 0 0 1 0 1 0;
%        0 0 0 0 0 0 0 1 0 0;
%        0 0 0 0 0 0 0 0 1 1;
%        0 0 0 0 0 0 0 0 0 0;
%        0 0 0 0 0 0 0 0 0 0];
    xs=x*pz;
    plot(xs(:,1),xs(:,2));
%     for i=1:10
%         for j=1:10
%             if s(i,j)==1
%                 hold on;
%                 plot(xs(i,0),xs(i,1));
%             end
%         end
%     end
case 4,
    p1=[0,0,0];
    p2=[0,5,0];
    p=p1+(p2-p1);
    p=[p,1];
    th=-pi/4;
    phi=35.26*pi/180;
    ti=[cos(phi),sin(phi)*cos(th),0,0
        0,cos(th),0,0
        sin(phi),-cos(phi)*sin(th),0,0
        0,0,0,1];    
    for s=0:0.01:2*pi
        for t=0:0.01:1
            pl=p.*[0 t 0 1];
            ts=[1,0,0,0
                0,cos(s),sin(s),0
                0,-sin(s),cos(s),0
                5*s,0,0,1];
            ps=pl*ts*ti;
            plot(ps(:,1),ps(:,2),'r');
            hold on;
        end
    end
    title('sweep surface');
case 5,
    p=[50,50,50,1;  % original points of the fig.
	   50,100,50,1;
	   100,100,50,1;
       100,50,50,1;
       50,50,100,1;
       50,100,100,1;
       75,100,100,1;
       100,100,75,1;
       100,75,100,1;
       100,50,100,1];
   s=[0,0,0,0,0,0,0,0,0,0;   % points to be plotted logic
      0,0,0,0,0,0,0,0,0,0;
      0,1,0,1,0,0,0,0,0,0;
      0,0,0,0,0,0,0,0,0,0;
      0,0,0,0,0,0,0,0,0,0;
      0,1,0,0,1,0,1,0,0,0;
      0,0,0,0,0,0,0,1,1,0;
      0,0,1,0,0,0,0,0,1,0;
      0,0,0,0,0,0,0,0,0,1;
      0,0,0,1,1,0,0,0,0,0];
    t=[1,0,0,0,   % translation matrix to origin
       0,1,0,0;
       0,0,1,0;
       -50,-50,-50,1];
    tt=[1,0,0,0;  % inverse translation
        0,1,0,0;
        0,0,1,0;
        50,50,50,1];
    phi=35.26*pi/180;
    th=-pi/4;
    ti=[cos(phi),sin(phi)*cos(th),0,0;
        0,cos(th),0,0;
        sin(phi),-cos(phi)*sin(th),0,0;
        0,0,0,1]; 
    p1=p*t*ti*tt;
    for i=1:10
        for j=1:10
            if s(i,j)==1
                p2(i,1)=p1(i,1);
                p2(i,2)=p1(i,2);
            end
        end
    end
    plot(p2(:,1),p2(:,2));
end
end









%    float p[10][4]={50,50,50,1,  //original points of the fig.
% 		   50,100,50,1,
% 		   100,100,50,1,
% 		   100,50,50,1,
% 		   50,50,100,1,
% 		   50,100,100,1,
% 		   75,100,100,1,
% 		   100,100,75,1,
% 		   100,75,100,1,
% 		   100,50,100,1};
% 
%    float t[4][4]={1,0,0,0,//translation matrix to origin
% 		0,1,0,0,
% 		0,0,1,0,
% 		-50,-50,-50,1};
% 
%    float tt[4][4]={1,0,0,0,//inverse translation
% 		 0,1,0,0,
% 		 0,0,1,0,
% 		 50,50,50,1};
% 
% int s[10][10]={0,0,0,0,0,0,0,0,0,0,//points to be plotted logic
% 	       0,0,0,0,0,0,0,0,0,0,
% 	       0,1,0,1,0,0,0,0,0,0,
% 	       0,0,0,0,0,0,0,0,0,0,
% 	       0,0,0,0,0,0,0,0,0,0,
% 	       0,1,0,0,1,0,1,0,0,0,
% 	       0,0,0,0,0,0,0,1,1,0,
% 	       0,0,1,0,0,0,0,0,1,0,
% 	       0,0,0,0,0,0,0,0,0,1,
% 	       0,0,0,1,1,0,0,0,0,0};
% 
% float i,j,phi=(-45*3.14)/180,th=(35.26*3.14)/180,p1[10][4],p2[10][4],p3[10][4];
% 
% /* isometric projection matrix */
% float ti[4][4]={cos(phi),sin(phi)*sin(th),0,0,
% 		0,cos(th),0,0,
% 		sin(phi),-cos(phi)*sin(th),0,0,
% 		0,0,0,1};
% 
% p1[10][4]=mul(p,t,p1);/* translate to origin */
% p2[10][4]=mul(p1,ti,p2);/* isometric projection */
% p3[10][4]=mul(p2,tt,p3);/* inverse translation */
% 
% for(i=0;i<10;i++)//plot logic
% 	{
% 	for(j=0;j<10;j++)
% 		{
% 		if(s[i][j]==1)
% 			{
% 			line(p3[i][0],p3[i][1],p3[j][0],p3[j][1]);
% 			}
% 		}
% 	}
% 
%    /* clean up */
%    getch();
%    closegraph();
% }
% 
% 
% 
% 
% /* isometric projection */
% #include <graphics.h>
% #include<iostream.h>
% #include<math.h>
% #include <stdlib.h>
% #include <stdio.h>
% #include <conio.h>
% 
% float mul(float a[10][4], float b[4][4], float c[10][4])
% {
% int i,j;
% for(i=0;i<10;i++)
% 	{
% 	for(j=0;j<4;j++)
% 		{
% 		c[i][j]=0;
% 		for(int k=0;k<4;k++)
% 			{
% 			c[i][j]+=a[i][k]*b[k][j];
% 			}
% 		}
% 	}
% return(c[10][4]);
% }
% 
% 
% void main(void)
% {
%    /* request auto detection */
%    int gdriver = DETECT, gmode;
% 
%    /* initialize graphics and local variables */
%    initgraph(&gdriver, &gmode, "d:/tc/bgi");
% 
%    /* original points of the fig. */
%    float p[10][4]={50,50,50,1,
% 		   50,100,50,1,
% 		   100,100,50,1,
% 		   100,50,50,1,
% 		   50,50,100,1,
% 		   50,100,100,1,
% 		   75,100,100,1,
% 		   100,100,75,1,
% 		   100,75,100,1,
% 		   100,50,100,1};
% 
%    /* translation matrix to origin */
%    float t[4][4]={1,0,0,0,
% 		  0,1,0,0,
% 		  0,0,1,0,
% 		  -50,-50,-50,1};
% 
%    /* inverse transslation */
%    float tt[4][4]={1,0,0,0,
% 		   0,1,0,0,
% 		   0,0,1,0,
% 		   50,50,50,1};
% 
% /* points to be plotted logic */
% int s[10][10]={0,0,0,0,0,0,0,0,0,0,
% 	       0,0,0,0,0,0,0,0,0,0,
% 	       0,1,0,1,0,0,0,0,0,0,
% 	       0,0,0,0,0,0,0,0,0,0,
% 	       0,0,0,0,0,0,0,0,0,0,
% 	       0,1,0,0,1,0,1,0,0,0,
% 	       0,0,0,0,0,0,0,1,1,0,
% 	       0,0,1,0,0,0,0,0,1,0,
% 	       0,0,0,0,0,0,0,0,0,1,
% 	       0,0,0,1,1,0,0,0,0,0};
% 
% float i,j,phi=(-45*3.14)/180,th=(35.26*3.14)/180;
% float p1[10][4],p2[10][4],p3[10][4],p4[10][4];
% 
% /* isometric projection matrix */
% float ti[4][4]={cos(phi),sin(phi)*sin(th),0,0,
% 		0,cos(th),0,0,
% 		sin(phi),-cos(phi)*sin(th),0,0,
% 		0,0,0,1};
% 
% float tp[4][4]={1,0,0,0,
% 		0,0,0,0,
% 		0,0,0,-1/100,
% 		0,0,0,1};
% 
% /* translate to origin */
% p1[10][4]=mul(p,t,p1);
% 
% /* perspective projection */
% p2[10][4]=mul(p1,tp,p2);
% 
% /* isometric projection */
% p4[10][4]=mul(p2,ti,p4);
% 
% /* inverse translation */
% p3[10][4]=mul(p4,tt,p3);
% 
% /* plot logic */
% for(i=0;i<10;i++)
% 	{
% 	for(j=0;j<4;j++)
% 		{
% 		//if(s[i][j]==1)
% 			{
% 			line(p3[i][0],p3[i][1],p3[j][0],p3[j][1]);
% 			}
% 		}
% 	}
% 
%    /* clean up */
%    getch();
%    closegraph();
% }
