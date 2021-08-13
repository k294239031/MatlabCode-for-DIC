%step1 三个点组成一个平面
%step2 面截出点
%step3 点投影，拟合椭圆，计算圆心
%step4 将坐标旋转至轴心
%******Step1 平面******%
hFigure= figure;                           %把绘图命令加在这行命令后，即可捕捉
imshow(file.num1)                                      %绘图命令（可直接替换为任何绘图命令）
plane_num=3;                               %用于获取椭圆散点的平面数量
Width = 3;                                 %平行平面间距（值越大，用于拟合椭圆的点越多）
%*****Step2 &Step3*****%
SolvePlane                                              

%******Step4 点线******%
line = fitLine3d(ellipse_xyz);             %由N个点拟合成直线，line第一列为坐标，第二列为方向向量

%*****%Step5 求解RT*****%
v1=[0 -1745 0];                                %目标向量
RT.CylinderAxis.T=[0 0 0];                 %T平移向量
SolveRT                                    %求解RT



for file_num=1:size(path.cam1,1)

%******变换坐标系*******%
for i=1:camera_num
    eval(['[CAMERA',num2str(i),'.num',num2str(file_num),'.XYZ] = Transformation1(RT.CylinderAxis,CAMERA',num2str(i),'.num',num2str(file_num),');'])
    eval(['rw=size(camera',num2str(i),'.num',num2str(file_num),'.X);'])
    eval(['[CAMERA',num2str(i),'.num',num2str(file_num),']=ReshapeMatrix(CAMERA',num2str(i),'.num',num2str(file_num),',rw);'])
end

end

%******Step6 坐标系转******%
%[THETA,RHO,Z] = cart2pol(X,Y,Z) 笛卡尔坐标转柱坐标
%[THETA,RHO,Z] = cart2sph(X,Y,Z) 笛卡尔坐标转球坐标

