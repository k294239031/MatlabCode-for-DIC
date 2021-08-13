clc;
clear;
close all;
%设置当前路径
currentPath=mfilename('fullpath');
num=strfind(currentPath,'\');
currentPath=currentPath(1:num(end));
cd(currentPath);
clear num currentPath

[data1,data2,data3,data4]=textread('.\FFT_sample.txt','%f%f%f%f','headerlines',1);
t=data1;y=data2;
figure;
subplot(2,1,1);plot(t,y)
title('长度')
xlabel('时间(s)')
ylabel('长度（mm）')
Fs=200;L=643;
N = 2^nextpow2(L);      %采样点数，采样点数越大，分辨的频率越精确，N>=L，超出的部分信号补为0
Y = fft(y,N)/N*2;       %除以N乘以2才是真实幅值，N越大，幅值精度越高
f = Fs/N*(0:1:N-1);     %频率
A = abs(Y); %幅值
subplot(2,1,2);
plot(f(1:N/2),A(1:N/2)); %函数fft返回值的数据结构具有对称性,因此我们只取前一半
title('幅值频谱')
xlabel('频率(Hz)')
ylabel('幅值')