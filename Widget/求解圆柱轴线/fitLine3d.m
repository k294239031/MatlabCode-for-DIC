function line = fitLine3d(ellipse_xyz)
% number of points
% 计算平均值（拟合的直线必过所有坐标的算数平均值）
xyz0(1)=mean(ellipse_xyz(1,:));
xyz0(2)=mean(ellipse_xyz(2,:));
xyz0(3)=mean(ellipse_xyz(3,:));%拟合点坐标
% 奇异值分解计算方向向量(第一种方法)
% 协方差矩阵奇异变换
% 所得直线的方向实际上与最大奇异值对应的奇异向量相同
 centeredLine=bsxfun(@minus,ellipse_xyz,xyz0);
 [U,S,V]=svd(centeredLine);
 line(:,1)=[xyz0(1);xyz0(2);xyz0(3)];
 line(:,2)=V(:,1);%方向向量
end

