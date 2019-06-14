t=0:0.5:10;
q0=0.1;
for i=1:7
    rc=i;
    a=1-exp(-t/rc);
    s=q0*a;
    xlabel('time');
    ylabel('charge');
    plot(t,s);
    hold on
end