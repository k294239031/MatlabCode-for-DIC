clear  
clc  
% cd('F:\20201010NO.1'); % ���õ�ǰĿ¼
% %  ��ʱtest�ļ�������:�ļ���1, �ļ���2�� �ļ�1.txt, �ļ�2.txt
% 
% movefile('1.txt', '11.txt');  % ��1.txt���г�11.txt(1.txt��������)��ʵ�����൱�ڸ���
% copyfile('2.txt', '22.txt');  % ��2.txt���Ƴ�22.txt(2.txt��Ȼ����)
% 
% movefile('11.txt', '1');      % ��11.txt���е��ļ���1��
% copyfile('0-00-08-00-00-000.bmp', '5hz');      % ��22.txt���Ƶ��ļ���2��

sourcePath='D:\2020111701';
targetPath='D:\2020111701\1hz';
type='bmp';     %��ȡ�ļ�����
num=50;         %ÿ��num��ͼȡһ��

%****1.��ȡ�ļ�
pic=Data(path,type);
pic.getAllFileName();
source_img=pic.filePath;

for i=1:fix(size(pic.filePath,1)/num)
%****2.��ϡ
change_img{i}=source_img(1+(i-1)*num).name;

%****3.�ƶ��ļ�
copyfile([sourcePath '\' change_img{i}], targetPath);      % ��22.txt���Ƶ��ļ���2��
end


