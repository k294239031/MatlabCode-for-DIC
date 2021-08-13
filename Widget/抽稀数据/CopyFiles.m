clear  
clc  
% cd('F:\20201010NO.1'); % 设置当前目录
% %  此时test文件夹中有:文件夹1, 文件夹2， 文件1.txt, 文件2.txt
% 
% movefile('1.txt', '11.txt');  % 把1.txt剪切成11.txt(1.txt不存在了)，实际上相当于改名
% copyfile('2.txt', '22.txt');  % 把2.txt复制成22.txt(2.txt依然存在)
% 
% movefile('11.txt', '1');      % 把11.txt剪切到文件夹1中
% copyfile('0-00-08-00-00-000.bmp', '5hz');      % 把22.txt复制到文件夹2中

sourcePath='D:\2020111701';
targetPath='D:\2020111701\1hz';
type='bmp';     %提取文件类型
num=50;         %每隔num张图取一张

%****1.读取文件
pic=Data(path,type);
pic.getAllFileName();
source_img=pic.filePath;

for i=1:fix(size(pic.filePath,1)/num)
%****2.抽稀
change_img{i}=source_img(1+(i-1)*num).name;

%****3.移动文件
copyfile([sourcePath '\' change_img{i}], targetPath);      % 把22.txt复制到文件夹2中
end


