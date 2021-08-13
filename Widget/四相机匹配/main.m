clc
clear
%*******读取数据*******%
  R0=csvread('D:\R0.csv',0,0,[0 0 2 2]);
  T0=csvread('D:\T0.csv');
  R1=csvread('D:\R1.csv',0,0,[0 0 2 2]);
  T1=csvread('D:\T1.csv');
  xyz1=csvread('D:\RE-xyz1.csv');
  xyz2=csvread('D:\RE-xyz2.csv');
  XYZ=csvread('D:\XYZ.csv');
% left=xyz1(:,1:4);
% right=xyz2(:,1:4);
% bzd=XYZ(:,[1 3 4 5]);
load('D:\1.mat')
%*****匹配并排序****%
XYZ=sortrows(XYZ,1);
[xyz2]=AutoRank(XYZ,xyz2,1);

[RT]=SVDrt(xyz1(:,2:4),XYZ(:,2:4),1);       %i=1时，N行三列/i=2时，A，B为三行N列
[right(:,2:4)] = Transformation(RT,right(:,2:4),1);  %RT变换
[bzd(:,2:4)] = reTransformation(RT,bzd(:,2:4),1);    %RT逆变换

%*****三维转二维*****%
for i=1:2
    eval(['num=size(camera',num2str(i),',1);'])
    for j=1:num
        eval(['[xs,ys]=Three2Two(RT',num2str(i),',camera',num2str(i),'(',num2str(j),',2:4),K',num2str(i),',k',num2str(i),');'])
        eval(['xy',num2str(i),'(1,',num2str(j),')=xs;'])
        eval(['xy',num2str(i),'(2,',num2str(j),')=ys;'])
    end
end
scatter3(left(:,2),left(:,3),left(:,4));
hold on
text(left(:,2),left(:,3),left(:,4),num2str(left(:,1)));
scatter3(right(:,2),right(:,3),right(:,4));
hold on
text(right(:,2),right(:,3),right(:,4),num2str(right(:,1)));
scatter3(bzd(:,2),bzd(:,3),bzd(:,4));
hold on
text(bzd(:,2),bzd(:,3),bzd(:,4),num2str(bzd(:,1))); %num2str(bzd(:,4))

%*****误差分析*****%
value=right-bzd;
value(:,1)=(value(:,2).^2+value(:,3).^2+value(:,4).^2).^0.5;