function [CAMERA] = reTransformation(RT,camera,i)
%Transformation   ����[R T]��camera12��camera34������ת����ͬһ����ϵ��
%[CAMERA12,CAMERA34] = Transformation(R0,T0,R1,T1,camera12,camera34)
%  camera12��camera34����csv�����ļ�ֱ�ӵõ�
%  �˴���z����ȡ����
%  i=1 N��3��/i=2 3��N��
if isstruct(camera)           %�ж��Ƿ�Ϊ�ṹ��
    camera.X(find(camera.X==0))=nan;
    x=camera.X;
    x=x(:);
    y=camera.Y;
    y=y(:);
    z=camera.Z;
    z=-z(:);
    xyz=[x,y,z]';
else 
    if i==1                   %i=1 N��3��/i=2 3��N��
        xyz=camera';
    elseif i==2
        xyz=camera;
    end
end
T=repmat(RT.T,1,size(xyz,2));

CAMERA = RT.R\(xyz-T);
if i==1
    CAMERA=CAMERA';
end
end