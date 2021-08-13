%step1 前处理
%step2 获取点坐标
%step3 根据点坐标分割4图/
%step4 将4图分别保存
%******Step1 前处理******%
clc
clear
imgPath='E:\DIC Data\4camera_test\3';
img=Data(imgPath,'bmp');
img.getAllFileName();
file=img.readData('num');
hFigure= figure;
imshow(file.num1);

%*****Step2 获取点坐标*****%
p_num=1;
selectedPoint = getPointInfo(hFigure,p_num);%图像坐标和矩阵坐标相反

for i=1:length(img.filePath)
    %*****Step3 分割4图片*****%
    eval(['[ img1,img2,img3,img4 ] = cutImg( selectedPoint,file.num',num2str(i),' );;'])
    
    %*****Step4 批量保存*****%
    for folderNum=1:4
        if exist([imgPath '\' num2str(folderNum)],'dir')==0
        mkdir([imgPath '\' num2str(folderNum)]);
        end
    end
    imwrite(img1,[imgPath '\1\' img.fileName(i).name '.bmp']);    
    imwrite(img2,[imgPath '\2\' img.fileName(i).name '.bmp']);
    imwrite(img3,[imgPath '\3\' img.fileName(i).name '.bmp']);
    imwrite(img4,[imgPath '\4\' img.fileName(i).name '.bmp']);
end
