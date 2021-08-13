function [R]= Vec2R(n)
%旋转向量n到旋转矩阵R的转换
%此处显示详细说明
theta=norm(n);
n=n/theta;
sizeVec=size(n,2);
if size(n,1)>size(n,2)
    sizeVec=size(n,1);
    n=n';
end
R=eye(sizeVec)*cos(theta)+(1-cos(theta))*(n'*n)+sin(theta)*...
    [0 -n(3) n(2);
    n(3) 0 -n(1);
    -n(2) n(1) 0];
det(R);
end