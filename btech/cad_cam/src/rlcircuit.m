%function for rlcircuit
function zdot=rlcircuit(t,z);
r=2;
l=2e-3;
v=1.5;
zdot=[((v-(r*z(1)))/1)];%defining the differential equation