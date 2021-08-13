clc;
clear;
close all;
%���õ�ǰ·��
currentPath=mfilename('fullpath');
num=strfind(currentPath,'\');
currentPath=currentPath(1:num(end));
cd(currentPath);
clear num currentPath


RGB_data = imread('.\filteringAlgorithm_binarization_sample.png');

%�޸Ĳ���
Sobel_Threshold = 170; %sobel��ֵ
mhd=0.5;               %gs�˲�ģ����
%

R_data =    RGB_data(:,:,1);
G_data =    RGB_data(:,:,2);
B_data =    RGB_data(:,:,3);
subplot(2,2,1);
imshow(RGB_data),title('ԭͼ');
[ROW,COL, DIM] = size(RGB_data);
Y_data = zeros(ROW,COL);
Cb_data = zeros(ROW,COL);
Cr_data = zeros(ROW,COL);
Gray_data = RGB_data;
for r = 1:ROW
for c = 1:COL
Y_data(r, c) = 0.299*R_data(r, c) + 0.*G_data(r, c) + 0.114*B_data(r, c);
Cb_data(r, c) = -0.172*R_data(r, c) - 0.339*G_data(r, c) + 0.511*B_data(r, c) + 128;
Cr_data(r, c) = 0.511*R_data(r, c) - 0.428*G_data(r, c) - 0.083*B_data(r, c) + 128;
end
end
Gray_data(:,:,1)=Y_data;
Gray_data(:,:,2)=Y_data;
Gray_data(:,:,3)=Y_data;
%subplot(2,2,2);
%imshow(Gray_data),title('�Ҷ�ͼ');

%-----------��ֵ�˲�-----------%
imgn = RGB_data;
Median_Img = RGB_data;
for r = 2:ROW-1
for c = 2:COL-1
median3x3 =[imgn(r-1,c-1)    imgn(r-1,c) imgn(r-1,c+1)
imgn(r,c-1)      imgn(r,c)      imgn(r,c+1)
imgn(r+1,c-1)      imgn(r+1,c) imgn(r+1,c+1)];
sort1 = sort(median3x3, 2, 'descend');
sort2 = sort([sort1(1), sort1(4), sort1(7)], 'descend');
sort3 = sort([sort1(2), sort1(5), sort1(8)], 'descend');
sort4 = sort([sort1(3), sort1(6), sort1(9)], 'descend');
mid_num = sort([sort2(3), sort3(2), sort4(1)], 'descend');
Median_Img(r,c) = mid_num(2);
end
end
subplot(2,2,2);
imshow(Median_Img),title('��ֵ�˲�');

%-------------��ֵ��--------------%
thresh = graythresh(Median_Img);%�Զ�ȷ����ֵ����ֵ
I2=Median_Img;
for i=1:ROW
for j=1:COL
if Median_Img(i,j)<thresh
I2(i,j)=255;
else
I2(i,j)=0;
end
end
end %��ͼ���ֵ��
subplot(2,2,3);
imshow(I2),title('��ֵ��(��ֵ)');
thresh = graythresh(RGB_data);     %�Զ�ȷ����ֵ����ֵ
I3 = im2bw(RGB_data,thresh); %��ͼ���ֵ��
subplot(2,2,4);
imshow(I3),title('��ֵ��(ԭͼ)');

imgn = I3;
Median_Img = I3;
for r = 2:ROW-1
for c = 2:COL-1
median3x3 =[imgn(r-1,c-1)    imgn(r-1,c) imgn(r-1,c+1)
imgn(r,c-1)      imgn(r,c)      imgn(r,c+1)
imgn(r+1,c-1)      imgn(r+1,c) imgn(r+1,c+1)];
sort1 = sort(median3x3, 2, 'descend');
sort2 = sort([sort1(1), sort1(4), sort1(7)], 'descend');
sort3 = sort([sort1(2), sort1(5), sort1(8)], 'descend');
sort4 = sort([sort1(3), sort1(6), sort1(9)], 'descend');
mid_num = sort([sort2(3), sort3(2), sort4(1)], 'descend');
Median_Img(r,c) = mid_num(2);
end
end
figure;
imshow(Median_Img),title('��ֵ�˲�');
