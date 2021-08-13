classdef Data < handle
    %读取目标路径下的所有指定类型文件
    properties(Hidden)
        destination_folder='D:\';
        fileType='jpg';
        suffixLetters=inf;
    end
    properties
        filePath;
        fileName;
    end
    
    methods
        function obj=Data(floder_path,file_type,suffix_letters)   %初始化
            %目标文件夹/文件类型
            if nargin==0
                
            else
                if((floder_path(length(floder_path))~='\')...
                        &&(floder_path(length(floder_path))~='/'))
                    floder_path=[floder_path '\'];
            end
            obj.destination_folder=floder_path;
            obj.fileType=file_type;
            if nargin==3
                obj.suffixLetters=suffix_letters;
            end
            end
        end
        function getAllFileName(obj)   %读取文件名
            %fullfile构成地址字符串；
            if(iscell(obj.suffixLetters))
                for i=1:length(obj.suffixLetters)
                    path=fullfile(obj.destination_folder,strcat('*_',obj.suffixLetters(i),'.',obj.fileType));
                    eval(['obj.filePath.camera',num2str(i),'=dir(path{1});'])
                end
            else
                path=fullfile(obj.destination_folder,cat(2,'*.',obj.fileType));
                obj.filePath=dir(path);
            end
            if(isempty(obj.filePath))
                sprintf('目录%s下未找到%s格式文件',obj.destination_folder,obj.fileType)
            else
                %删除格式后缀名
                if(iscell(obj.suffixLetters))
                    
                else
                    obj.fileName=removeTypeName(obj.filePath,obj.fileType);
                end
            end
        end
        function file=readData(obj,NAME)    %读取文件
            if(strcmp(obj.fileType,'jpg')||strcmp(obj.fileType,'JPG'))
                for i=1:length(obj.filePath)
                    eval(['file.',NAME,'',num2str(i),'=imread(cat(2,obj.destination_folder,obj.filePath(i).name));'])
                end
            elseif(strcmp(obj.fileType,'mat'))
                for j=1:length(obj.suffixLetters)
                    eval(['number=length(obj.filePath.camera',num2str(j),');'])
                    for i=1:number
                        eval(['file.',NAME,'',num2str(j),'.num',num2str(i),'=load(cat(2,obj.destination_folder,obj.filePath.camera',num2str(j),'(i).name));'])
                    end
                end
            elseif(strcmp(obj.fileType,'csv'))
                for i=1:length(obj.filePath)
                    eval(['file.',obj.fileName(i).name,'=csvread(cat(2,obj.destination_folder,obj.filePath(i).name));'])
                end
            elseif(strcmp(obj.fileType,'bmp'))
                for i=1:length(obj.filePath)
                    eval(['file.',NAME,'',num2str(i),'=imread(cat(2,obj.destination_folder,obj.filePath(i).name));'])
                end
            else
                try
                    for i=1:length(obj.filePath)
                        eval(['file.',NAME,'',num2str(i),'=load(cat(2,obj.destination_folder,obj.filePath(i).name));'])
                    end
                catch
                    sprintf('打开%s格式文件失败',obj.destination_folder,obj.fileType)
                end
            end
        end
    end
end

%局部函数
function filePath=removeTypeName(filePath,fileType)
for i=1:length(filePath)
    for j=0:length(fileType)
        nameSize=length(filePath(i).name);
        filePath(i).name(nameSize)=[];
    end
end
end