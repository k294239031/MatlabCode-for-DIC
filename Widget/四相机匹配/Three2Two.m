function [xs,ys]=Three2Two(RT,XYZ,KK,k,p1,p2)
%三维坐标转到二维平面
%KK为相机内参矩阵，3行3列
%k为径向畸变系数，包含k1 k2 k3
R=RT.R;
T=RT.T;
I=R(1,1)*XYZ(1)+R(1,2)*XYZ(2)+R(1,3)*XYZ(3)+T(1,1);
J=R(2,1)*XYZ(1)+R(2,2)*XYZ(2)+R(2,3)*XYZ(3)+T(2,1);
K=R(3,1)*XYZ(1)+R(3,2)*XYZ(2)+R(3,3)*XYZ(3)+T(3,1);

x1=I/K;
y1=J/K;
r=(x1^2+y1^2)^0.5;

if nargin == 4
    x2=x1+(k(1)*r^2+k(2)*r^4+k(3)*r^6)*x1;
    y2=y1+(k(1)*r^2+k(2)*r^4+k(3)*r^6)*y1;
elseif nargin == 6
    x2=x1+(k(1)*r^2+k(2)*r^4+k(3)*r^6)*x1+2*p1*x1*y1+p2*(r^2+2*x1);
    y2=y1+(k(1)*r^2+k(2)*r^4+k(3)*r^6)*y1+2*p2*x1*y1+p1*(r^2+2*y1);
end
    
xs=KK(1,1)*x2+KK(1,2)*y2+KK(1,3);
ys=KK(2,2)*y2+KK(2,3);