%step1 ���������һ��ƽ��
%step2 ��س���
%step3 ��ͶӰ�������Բ������Բ��
%step4 ��������ת������
%******Step1 ƽ��******%
hFigure= figure;                           %�ѻ�ͼ���������������󣬼��ɲ�׽
imshow(file.num1)                                      %��ͼ�����ֱ���滻Ϊ�κλ�ͼ���
plane_num=3;                               %���ڻ�ȡ��Բɢ���ƽ������
Width = 3;                                 %ƽ��ƽ���ֵࣨԽ�����������Բ�ĵ�Խ�ࣩ
%*****Step2 &Step3*****%
SolvePlane                                              

%******Step4 ����******%
line = fitLine3d(ellipse_xyz);             %��N������ϳ�ֱ�ߣ�line��һ��Ϊ���꣬�ڶ���Ϊ��������

%*****%Step5 ���RT*****%
v1=[0 -1745 0];                                %Ŀ������
RT.CylinderAxis.T=[0 0 0];                 %Tƽ������
SolveRT                                    %���RT



for file_num=1:size(path.cam1,1)

%******�任����ϵ*******%
for i=1:camera_num
    eval(['[CAMERA',num2str(i),'.num',num2str(file_num),'.XYZ] = Transformation1(RT.CylinderAxis,CAMERA',num2str(i),'.num',num2str(file_num),');'])
    eval(['rw=size(camera',num2str(i),'.num',num2str(file_num),'.X);'])
    eval(['[CAMERA',num2str(i),'.num',num2str(file_num),']=ReshapeMatrix(CAMERA',num2str(i),'.num',num2str(file_num),',rw);'])
end

end

%******Step6 ����ϵת******%
%[THETA,RHO,Z] = cart2pol(X,Y,Z) �ѿ�������ת������
%[THETA,RHO,Z] = cart2sph(X,Y,Z) �ѿ�������ת������

