function [R]= Vec2R(n)
%��ת����n����ת����R��ת��
%�˴���ʾ��ϸ˵��
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