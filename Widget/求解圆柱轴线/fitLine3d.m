function line = fitLine3d(ellipse_xyz)
% number of points
% ����ƽ��ֵ����ϵ�ֱ�߱ع��������������ƽ��ֵ��
xyz0(1)=mean(ellipse_xyz(1,:));
xyz0(2)=mean(ellipse_xyz(2,:));
xyz0(3)=mean(ellipse_xyz(3,:));%��ϵ�����
% ����ֵ�ֽ���㷽������(��һ�ַ���)
% Э�����������任
% ����ֱ�ߵķ���ʵ�������������ֵ��Ӧ������������ͬ
 centeredLine=bsxfun(@minus,ellipse_xyz,xyz0);
 [U,S,V]=svd(centeredLine);
 line(:,1)=[xyz0(1);xyz0(2);xyz0(3)];
 line(:,2)=V(:,1);%��������
end

