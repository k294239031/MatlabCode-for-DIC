function [CAMERA] = Transformation1(RT,camera)
%Transformation   ����[R T]��camera12��camera34������ת����ͬһ����ϵ��
%[CAMERA12,CAMERA34] = Transformation(R0,T0,R1,T1,camera12,camera34)
%  camera12��camera34����csv�����ļ�ֱ�ӵõ�
%  �˴���z����ȡ����

xyz=camera.XYZ;
T=repmat(RT.T',1,size(xyz,2));
% for i=1:size(x12,1)
%     eval(['CAMERA12(:,',num2str(i),')=R0*xyz12(:,',num2str(i),')+T0;'])
% end
CAMERA = RT.R*xyz+T;
end