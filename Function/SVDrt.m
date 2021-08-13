function [RT]=SVDrt(A,B,i)
% [RT]=SVDrt(left,right,1); ����Aת��B�ϵ�RT
%i=1ʱ��A��BΪN�����еľ���
%i=2ʱ��A��BΪ����N�еľ���
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

%����߶�ƽ��ֵ
lam2=A_norm./B_norm;
lam2=mean(lam2);

[U,S,V] = svd(H);
R = V*U';

%�������յ���ת������ƽ������
t = -R./(lam2^(0.5))*centroid_A' + centroid_B';
R = R./(lam2^(0.5));

RT.R=R;
RT.T=t;