%step1 ǰ����
%step2 ��ȡ������
%step3 ���ݵ�����ָ�4ͼ/
%step4 ��4ͼ�ֱ𱣴�
%******Step1 ǰ����******%
clc
clear
imgPath='E:\DIC Data\4camera_test\3';
img=Data(imgPath,'bmp');
img.getAllFileName();
file=img.readData('num');
hFigure= figure;
imshow(file.num1);

%*****Step2 ��ȡ������*****%
p_num=1;
selectedPoint = getPointInfo(hFigure,p_num);%ͼ������;��������෴

for i=1:length(img.filePath)
    %*****Step3 �ָ�4ͼƬ*****%
    eval(['[ img1,img2,img3,img4 ] = cutImg( selectedPoint,file.num',num2str(i),' );;'])
    
    %*****Step4 ��������*****%
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
