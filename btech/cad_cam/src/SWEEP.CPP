#include <graphics.h>
#include <stdio.h>
#include <conio.h>
#include<math.h>

float mul(float a[1][4], float b[4][4], float c[1][4])
{
int i,j;
for(i=0;i<1;i++)
	{
	for(j=0;j<4;j++)
		{
		c[i][j]=0;
		for(int k=0;k<4;k++)
			{
			c[i][j]+=a[i][k]*b[k][j];
			}
		}
	}
return(c[1][4]);
}

void main()
{
  /* request auto detection */
   int gdriver = DETECT, gmode;

   /* initialize graphics and local variables */
   initgraph(&gdriver, &gmode, "d:/tc/bgi");

float th=35.26*3.147/180,phi=-45*3.147/180,p1[3]={100,100,0},p2[3]={100,150,0};
float s,t;
float ti[4][4]={cos(phi),sin(phi)*sin(th),0,0,
		0,cos(th),0,0,
		sin(phi),-cos(phi)*sin(th),0,0,
		0,0,0,1};
float p0[1][4],p3[1][4],p4[1][4];
float t1[4][4]={1,0,0,0,//translation matrix
		0,1,0,0,
		0,0,1,0,
		-100,-100,0,1};
float t12[4][4]={1,0,0,0,//translation matrix
		 0,1,0,0,
		 0,1,0,0,
		 100,100,0,1};
float i,j,xln,yln,zln;

for(s=0;s<6.28;s+=0.01)
	{
	for(t=0;t<1;t+=0.001)
		{
		xln=p1[0]+(p2[0]-p1[0])*t;
		yln=p1[1]+(p2[1]-p1[1])*t;
		zln=p1[2]+(p2[2]-p1[2])*t;
		float p[1][4]={xln,yln,zln,1};//random point generation
		float ts[4][4]={1,0,0,0,
				0,cos(s),sin(s),0,
				0,-sin(s),cos(s),0,
				30*s,0,0,1};
		p0[1][4]=mul(p,t1,p0);//translate to origin
		p3[1][4]=mul(p0,ts,p3);//sweep transformation
		p4[1][4]=mul(p3,ti,p4);//isometric projection
		p0[1][4]=mul(p4,t12,p0);//translate back to origianl point
		putpixel(p0[0][0],p0[0][1],GREEN);
		}
	}

   getch();
   closegraph();
}