/* isometric projection */
#include <graphics.h>
#include<math.h>
#include <stdio.h>
#include <conio.h>

float mul(float a[10][4], float b[4][4], float c[10][4])
{
int i,j;
for(i=0;i<10;i++)
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
return(c[10][4]);
}

void main(void)
{
   /* request auto detection */
   int gdriver = DETECT, gmode;

   /* initialize graphics and local variables */
   initgraph(&gdriver, &gmode, "d:/tc/bgi");

float p[10][4]={50,50,50,1,  //original points of the fig.
		50,100,50,1,
		100,100,50,1,
		100,50,50,1,
		50,50,100,1,
		50,100,100,1,
		75,100,100,1,
		100,100,75,1,
		100,75,100,1,
		100,50,100,1};

float t[4][4]={1,0,0,0,    //translation matrix to origin
	       0,1,0,0,
	       0,0,1,0,
	       -50,-50,-50,1};

float tt[4][4]={1,0,0,0,   //inverse translation
		0,1,0,0,
		0,0,1,0,
		50,50,50,1};

int s[10][10]={0,0,0,0,0,0,0,0,0,0,   //points to be plotted logic
	       0,0,0,0,0,0,0,0,0,0,
	       0,1,0,1,0,0,0,0,0,0,
	       0,0,0,0,0,0,0,0,0,0,
	       0,0,0,0,0,0,0,0,0,0,
	       0,1,0,0,1,0,1,0,0,0,
	       0,0,0,0,0,0,0,1,1,0,
	       0,0,1,0,0,0,0,0,1,0,
	       0,0,0,0,0,0,0,0,0,1,
	       0,0,0,1,1,0,0,0,0,0};

float i,j,phi=(-45*3.14)/180,th=(35.26*3.14)/180,p0[10][4],p1[10][4],p2[10][4];

/* isometric projection matrix */
float ti[4][4]={cos(phi),sin(phi)*sin(th),0,0,
		0,cos(th),0,0,
		sin(phi),-cos(phi)*sin(th),0,0,
		0,0,0,1};

p0[10][4]=mul(p,t,p0);/* translate to origin */
p1[10][4]=mul(p0,ti,p1);/* isometric projection */
p0[10][4]=mul(p1,tt,p0);/* inverse translation */

for(i=0;i<10;i++)//plot logic
	{
	for(j=0;j<10;j++)
		{
		if(s[i][j]==1)
			{
			line(p0[i][0],p0[i][1],p0[j][0],p0[j][1]);
			}
		}
	}
getch();
closegraph();
}

