function [data_q,T] = rotate(data,theta,t)
%   将data饶Z轴旋转theta度，并平移t
%   data=[x1 x2 ...;
%         y1 y2 ...;
%         z1 z2 .. ]

theta=theta/180*pi;  
T=[ cos(theta),  -sin(theta),  0,  t(1);
    sin(theta),   cos(theta),  0,  t(2);
             0,            0,  1,  t(3);
             0,            0,  0,    1];    %旋转矩阵
 
rows=size(data,2);
rows_one=ones(1,rows);
data=[data;rows_one];    %化为齐次坐标
 
data_q=T*data;
data_q=data_q(1:3,:);    %返回三维坐标