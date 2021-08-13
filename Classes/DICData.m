classdef DICData < handle
    %ר�Ŷ�ȡĿ��·���µĶ����DIC�����ļ�
    properties(Hidden)
        computedResultPath;
        computedResultDataType='mat';
        extrinsicFilePath;
        extrinsicDataType='csv';
        suffixLetters=inf; %��ֵ��Ϊcell��ʽ
        orderName='camera';
        computedResultData;
        extrinsicData;
    end
    properties(Hidden,Dependent)
        csvNameList;
    end
    properties
        computedResultData_;
        extrinsicData_;
        cameraNum=0;
    end
    
    methods
        function obj=DICData(computedResult_path,...
                suffix_letters,...
                extrinsic_folder,...
                computedResult_datatype,...
                extrinsic_datatype)
            %Ĭ�ϼ�����Ϊmat�ļ�����ν��Ϊcsv�ļ�
            obj.computedResultPath=computedResult_path;
            obj.suffixLetters=strsplit(suffix_letters,' ');
            obj.extrinsicFilePath=extrinsic_folder;
            obj.cameraNum = length(strsplit(suffix_letters,' '));
            if nargin==5
                obj.computedResultDataType=computedResult_datatype;
                obj.extrinsicDataType=extrinsic_datatype;
            end
            obj.computedResultData=Data(obj.computedResultPath,obj.computedResultDataType,obj.suffixLetters);
            obj.extrinsicData     =Data(obj.extrinsicFilePath,obj.extrinsicDataType);
        end
        
        function getAllFileName(obj)
            %��ȡmat�ļ�
            obj.computedResultData.getAllFileName();
            %��ȡcsv�ļ�
            obj.extrinsicData.getAllFileName();
            
            %obj.computedResultData.fileName=sortCameraName(obj.computedResultData.filePath,obj.cameraNum,obj.orderName);
        end
        
        function readMatData(obj,order_name)    %��ȡmat�ļ�
            if nargin==2
                obj.orderName=order_name;
            end
            obj.computedResultData_=obj.computedResultData.readData(obj.orderName);
            %��0��nan/z����ȡ����
            for i=1:obj.cameraNum
                eval(['photoNum=length(fieldnames(obj.computedResultData_.camera',num2str(i),'));'])
                for j=1:photoNum
                    eval(['obj.computedResultData_.camera',num2str(i),'.num',num2str(j),'=change0toNaN(obj.computedResultData_.camera',num2str(i),'.num',num2str(j),');'])
                end
            end
        end
        
        function readCsvData(obj)   %��ȡcsv�ļ�
            obj.extrinsicData_=obj.extrinsicData.readData('csv');
            %ȥ0��[]
            %1.��־������
            for i=1:4
                obj.extrinsicData_.XYZ(:,6)=[];
            end
            obj.extrinsicData_.XYZ(:,2)=[];
            %2.RT����
            for i=0:(obj.cameraNum-1)
                eval(['obj.extrinsicData_.R',num2str(i),'(:,4)=[];'])
                eval(['obj.extrinsicData_.T',num2str(i),'(:,2)=[];'])
            end
            %3.RE_xyz
            %obj.extrinsicData_.RE_xyz(:,4)=[];
        end
        
        function calculateData(obj)
            for i=1:obj.cameraNum
                eval(['photoNum=length(fieldnames(obj.computedResultData_.camera',num2str(i),'));'])
                for j=1:photoNum
                    %1.ת������
                    XYZ=Transform();
                    eval(['obj.computedResultData_.camera',num2str(i),'.num',num2str(j),'.xyz=XYZ.RigidBodyTrans(1,obj.computedResultData_.camera',num2str(i),'.num',num2str(j),'.xyz'',obj.extrinsicData_.R',num2str(i-1),',obj.extrinsicData_.T',num2str(i-1),');'])
                    %2.reshapeMatrix
                    eval(['[row,col]=size(obj.computedResultData_.camera',num2str(i),'.num',num2str(j),'.X);'])
                    eval(['obj.computedResultData_.camera',num2str(i),'.num',num2str(j),'=reshapeMatrix(obj.computedResultData_.camera',num2str(i),'.num',num2str(j),',row,col);'])
                    %3.����dx,dy,dz
                    eval(['obj.computedResultData_.camera',num2str(i),'.num',num2str(j),'.dx=obj.computedResultData_.camera',num2str(i),'.num',num2str(j),'.x-obj.computedResultData_.camera',num2str(i),'.num1.x;'])
                    eval(['obj.computedResultData_.camera',num2str(i),'.num',num2str(j),'.dy=obj.computedResultData_.camera',num2str(i),'.num',num2str(j),'.y-obj.computedResultData_.camera',num2str(i),'.num1.y;'])
                    eval(['obj.computedResultData_.camera',num2str(i),'.num',num2str(j),'.dz=obj.computedResultData_.camera',num2str(i),'.num',num2str(j),'.z-obj.computedResultData_.camera',num2str(i),'.num1.z;'])
                    eval(['obj.computedResultData_.camera',num2str(i),'.num',num2str(j),'.dt=(obj.computedResultData_.camera',num2str(i),'.num',num2str(j),'.dx.^2+obj.computedResultData_.camera',num2str(i),'.num',num2str(j),'.dy.^2+obj.computedResultData_.camera',num2str(i),'.num',num2str(j),'.dz.^2).^0.5;'])
                end
            end
        end
        function drawing(obj,display_type,display_num,display_var_)
            %1.�ر����д���
            close all
            %2.������ͼ
            if display_type==0
                for i=1:obj.cameraNum
                    eval(['display_var=obj.computedResultData_.camera',num2str(i),'.num',num2str(display_num),'.',num2str(display_var_),';'])
%                     eval(['x=obj.computedResultData_.camera',num2str(i),'.num',num2str(display_num),'.x;'])
%                     eval(['y=obj.computedResultData_.camera',num2str(i),'.num',num2str(display_num),'.y;'])
%                     eval(['z=obj.computedResultData_.camera',num2str(i),'.num',num2str(display_num),'.z;'])
                    eval(['x=obj.computedResultData_.camera',num2str(i),'.num1.x;'])
                    eval(['y=obj.computedResultData_.camera',num2str(i),'.num1.y;'])
                    eval(['z=obj.computedResultData_.camera',num2str(i),'.num1.z;'])
                    surf(x,y,z,display_var);
                    hold on
                end
            elseif display_type==1
                for i=1:obj.cameraNum
                    eval(['display_var=obj.computedResultData_.camera',num2str(i),'.num',num2str(display_num),'.',num2str(display_var_),';'])
                    eval(['x=obj.computedResultData_.camera',num2str(i),'.num',num2str(display_num),'.x;'])
                    eval(['y=obj.computedResultData_.camera',num2str(i),'.num',num2str(display_num),'.y;'])
                    eval(['z=obj.computedResultData_.camera',num2str(i),'.num',num2str(display_num),'.z;'])
                    scatter3(x(:),y(:),z(:),20,display_var(:),'.');
                    hold on
                end
            end
        end
        %         function csvNameList=get.csvNameList(obj)   %��̬��ȡ����
        %             csvNameList={'RE_xyz',...
        %                      length(obj.extrinsicData.fileName)/2,...
        %                      'XYZ',...
        %                      length(obj.extrinsicData.fileName)};
        %         end
    end
end

%�ֲ�����
function computedResultData=sortCameraName(filePath,cameraNum,orderName)
num=fix(length(filePath)/cameraNum);
for j=1:cameraNum
    for i=1:num
        eval(['computedResultData(i).',orderName,num2str(j),'=filePath(j+cameraNum*(i-1)).name;'])
    end
end
end

function file=change0toNaN(file)
file.X(file.X==0)=nan;
file.Z=-file.Z;   %��Z����ȡ����
file.xyz=[file.X(:),file.Y(:),file.Z(:)];

% file.Exx_=file.Exx;
% file.Exy_=file.Exy;
% file.Eyy_=file.Eyy;
file.LeftX(file.LeftX==0)=nan;
file.RightX(file.RightX==0)=nan;

file.Exx(file.Exx==0)=nan;
file.Exy(file.Exy==0)=nan;
file.Eyy(file.Eyy==0)=nan;
end

function file=reshapeMatrix(file,row,col)
file.x=reshape(file.xyz(1,:),[row col]);
file.y=reshape(file.xyz(2,:),[row col]);
file.z=reshape(file.xyz(3,:),[row col]);
end
% function file=varRename(file,name_list)
% ori_name=fieldnames(file.extrinsicData.fileName);
% for i=1:2:(length(name_list)-1)
%     eval(['file.',name_list(i),'=file.extrinsicData.fileName.',ori_name{name_list(i+1)},';'])
% end
% end

