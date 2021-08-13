function [RT]=SVDrt(A,B,i)
% [RT]=SVDrt(left,right,1); 计算A转到B上的RT
%i=1时，A，B为N行三列的矩阵
%i=2时，A，B为三行N列的矩阵
if i == 2
    A=A';
    B=B';
end

centroid_A = mean(A);
centroid_B = mean(B);

N = size(A,1);

H = (A - repmat(centroid_A, N, 1))' * (B - repmat(centroid_B, N, 1));

A_move=A - repmat(centroid_A, N, 1);
B_move=B - repmat(centroid_B, N, 1);

A_norm=sum(A_move.*A_move,2);
B_norm=sum(B_move.*B_move,2);

%计算尺度平均值
lam2=A_norm./B_norm;
lam2=mean(lam2);

[U,S,V] = svd(H);
R = V*U';

%计算最终的旋转矩阵与平移向量
t = -R./(lam2^(0.5))*centroid_A' + centroid_B';
R = R./(lam2^(0.5));

RT.R=R;
RT.T=t;