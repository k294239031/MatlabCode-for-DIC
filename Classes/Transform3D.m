classdef Transform3D < Transform2D
    %   Transform3D ��ά����ת��
    %   Version1.1������������ϵ�任���ѿ�������ϵ��������ϵ�뼫����ϵ���໥ת��
    properties(Hidden)
        changed_z;
        n;
    end
    properties
        z;
    end
    methods
        function obj=Transform3D(type_,unchangedCoordinate_)
            %type_=1,��ʾ����Ϊ�ѿ�������
            %type_=2,��ʾ����Ϊ������
            %����xyzӦΪ����N��,��xyz=[x1 x2 ...xn
            %                         y1 y2 ...yn
            %                         z1 z2 ...zn]
            obj=obj@Transform2D(type_,unchangedCoordinate_);
            obj.z=obj.unchangedCoordinate(3,:);
        end
        function changedCoordinate=RigidBodyTrans(obj,R_Vec_,T_)
            changedCoordinate=RigidBodyTrans@Transform2D(obj,R_Vec_,T_);
            
            %��������
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
%��ת����R����ת����n��ת��
%�˴���ʾ��ϸ˵��
thet=acos((trace(R)-1)/2);
vector_M=((R-R')/2)/sin(thet);
n=[vector_M(3,2),vector_M(1,3),vector_M(2,1)];
n=n*thet;
end

function [R]= Vec2R(n)
%��ת����n����ת����R��ת��
%�˴���ʾ��ϸ˵��
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