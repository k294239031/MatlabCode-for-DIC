function [CAMERA] = Transformation1(RT,camera)
%Transformation   利用[R T]对camera12和camera34的坐标转换到同一坐标系下
%[CAMERA12,CAMERA34] = Transformation(R0,T0,R1,T1,camera12,camera34)
%  camera12和camera34可由csv数据文件直接得到
%  此处对z坐标取负数

xyz=camera.XYZ;
T=repmat(RT.T',1,size(xyz,2));
% for i=1:size(x12,1)
%     eval(['CAMERA12(:,',num2str(i),')=R0*xyz12(:,',num2str(i),')+T0;'])
% end
CAMERA = RT.R*xyz+T;
end