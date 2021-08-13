classdef Transform3D < Transform2D
    %   Transform3D 三维坐标转换
    %   Version1.1函数包含坐标系变换，笛卡尔坐标系、柱坐标系与极坐标系的相互转换
    properties(Hidden)
        changed_z;
        n;
    end
    properties
        z;
    end
    methods
        function obj=Transform3D(type_,unchangedCoordinate_)
            %type_=1,表示输入为笛卡尔坐标
            %type_=2,表示输入为柱坐标
            %输入xyz应为三行N列,即xyz=[x1 x2 ...xn
            %                         y1 y2 ...yn
            %                         z1 z2 ...zn]
            obj=obj@Transform2D(type_,unchangedCoordinate_);
            obj.z=obj.unchangedCoordinate(3,:);
        end
        function changedCoordinate=RigidBodyTrans(obj,R_Vec_,T_)
            changedCoordinate=RigidBodyTrans@Transform2D(obj,R_Vec_,T_);
            
            %储存数据
            obj.changed_z=changedCoordinate(3,:);
            if size(R_Vec_,1)==size(R_Vec_,2)
                [obj.n] = R2Vec(obj.R);
            elseif (size(R_Vec_,1)==3)||(size(R_Vec_,2)==3)
                [obj.R] = Vec2R(obj.n);
            end
        end
        
    end
    methods(Hidden)
        
    end
end

function [n]= R2Vec(R)
%旋转矩阵R到旋转向量n的转换
%此处显示详细说明
thet=acos((trace(R)-1)/2);
vector_M=((R-R')/2)/sin(thet);
n=[vector_M(3,2),vector_M(1,3),vector_M(2,1)];
n=n*thet;
end

function [R]= Vec2R(n)
%旋转向量n到旋转矩阵R的转换
%此处显示详细说明
theta=norm(n);
n=n/theta;
sizeVec=size(n,2);
if size(n,1)>size(n,2)
    sizeVec=size(n,1);
    n=n';
end
R=eye(sizeVec)*cos(theta)+(1-cos(theta))*(n'*n)+sin(theta)*...
    [0 -n(3) n(2);
    n(3) 0 -n(1);
    -n(2) n(1) 0];
det(R)
end