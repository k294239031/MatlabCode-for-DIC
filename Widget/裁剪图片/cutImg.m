function [ img1,img2,img3,img4 ] = cutImg( selectedPoint,file )
%CUTIMG 裁剪图片分别保存
%图像坐标和矩阵坐标相反
point(1)=selectedPoint(2);
point(2)=selectedPoint(1);
width=size(file,1);
height=size(file,2);

for i=1:4
    eval(['img',num2str(i),'=im2uint8(zeros(length(file)));'])
end

img1(1:point(1),1:point(2))=file(1:point(1),1:point(2));
img3(point(1):width,1:point(2))=file(point(1):width,1:point(2));
img2(1:point(1),point(2):height)=file(1:point(1),point(2):height);
img4(point(1):width,point(2):height)=file(point(1):width,point(2):height);
end

