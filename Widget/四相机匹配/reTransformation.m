function [CAMERA] = reTransformation(RT,camera,i)
%Transformation   利用[R T]对camera12和camera34的坐标转换到同一坐标系下
%[CAMERA12,CAMERA34] = Transformation(R0,T0,R1,T1,camera12,camera34)
%  camera12和camera34可由csv数据文件直接得到
%  此处对z坐标取负数
%  i=1 N行3列/i=2 3行N列
if isstruct(camera)           %判定是否为结构体
    camera.X(find(camera.X==0))=nan;
    x=camera.X;
    x=x(:);
    y=camera.Y;
    y=y(:);
    z=camera.Z;
    z=-z(:);
    xyz=[x,y,z]';
else 
    if i==1                   %i=1 N行3列/i=2 3行N列
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