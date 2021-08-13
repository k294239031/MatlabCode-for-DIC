function [data_q,T] = rotate(data,theta,t)
%   ��data��Z����תtheta�ȣ���ƽ��t
%   data=[x1 x2 ...;
%         y1 y2 ...;
%         z1 z2 .. ]

theta=theta/180*pi;  
T=[ cos(theta),  -sin(theta),  0,  t(1);
    sin(theta),   cos(theta),  0,  t(2);
             0,            0,  1,  t(3);
             0,            0,  0,    1];    %��ת����
 
rows=size(data,2);
rows_one=ones(1,rows);
data=[data;rows_one];    %��Ϊ�������
 
data_q=T*data;
data_q=data_q(1:3,:);    %������ά����