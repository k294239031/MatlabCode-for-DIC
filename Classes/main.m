clc
clear
R=[-1 1 0;2 3 -1;-4 4 1.1];
T=[-1 0 1];
a=Transform3D(2,[theta;rho;3 4]);
a.RigidBodyTrans(R,T)

