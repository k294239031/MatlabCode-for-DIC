clc;
clear;
close all;
%���õ�ǰ·��
currentPath=mfilename('fullpath');
num=strfind(currentPath,'\');
currentPath=currentPath(1:num(end));
cd(currentPath);
clear num currentPath


RGB_data = imread('.\getContour_sample.png');
RGB_data=imnoise(RGB_data,'salt & pepper',0.01);

%�޸Ĳ���
Sobel_Threshold = 170; %sobel��ֵ
mhd=0.5;               %gs�˲�ģ����

R_data =    RGB_data(:,:,1);
G_data =    RGB_data(:,:,2);
B_data =    RGB_data(:,:,3);
subplot(2,2,1);
imshow(RGB_data),title('ԭͼ');
[ROW,COL, DIM] = size(RGB_data);
Y_data = zeros(ROW,COL);
Cb_data = zeros(ROW,COL);
Cr_data = zeros(ROW,COL);
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

%-----------��˹�˲�-----------%
gs=Median_Img;
W = fspecial('gaussian',[5,5],mhd); 
G = imfilter(gs, W, 'replicate');
subplot(2,2,3);
imshow(G),title('��˹�˲�');

%-------------��ֵ��--------------%
thresh = graythresh(Median_Img);     %�Զ�ȷ����ֵ����ֵ
I2 = im2bw(Median_Img,0.4); %��ͼ���ֵ��

subplot(2,2,4);
imshow(I2),title('��ֵ��');

figure;
B=[0 1 1 0;1 1 1 1;1 1 1 1;0 1 1 0];
fushi=imerode(I2,B);%ͼ��A1���ṹԪ��B����
fushi2=imerode(fushi,B);
fushi3=imdilate(fushi2,B);
fushi4=imdilate(fushi3,B);
subplot(121),imshow(I2);
title('imdilate����ԭʼͼ��');
subplot(122),imshow(fushi4);
title('ʹ��B��1�����ͺ��ͼ��');