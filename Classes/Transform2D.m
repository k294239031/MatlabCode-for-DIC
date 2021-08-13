classdef Transform2D < handle
    %Transform2D 二维坐标转换
    %   Version1.1函数包含坐标系变换，平面直角坐标系与极坐标系的相互转换
    properties(Hidden)
        type;
        R;
        T;
        unchangedCoordinate;
        changed_x;
        changed_y;
        changed_theta;
        changed_rho;
    end
    properties
        x;
        y;
        theta;
        rho;
    end
    methods
        function obj=Transform2D(type_,unchangedCoordinate_)
            %type_=1,表示输入为笛卡尔坐标
            %type_=2,表示输入为极坐标
            %输入xy应为两行N列,即xy=[x1 x2 ...xn
            %                       y1 y2 ...yn]
            obj.type=type_;
            obj.unchangedCoordinate=unchangedCoordinate_;
            if obj.type==1
                obj.x=obj.unchangedCoordinate(1,:);
                obj.y=obj.unchangedCoordinate(2,:);
                [obj.theta,obj.rho] = cart2pol(obj.x,obj.y);
            elseif obj.type==2
                obj.theta=obj.unchangedCoordinate(1,:);
                obj.rho=obj.unchangedCoordinate(2,:);
                [obj.x,obj.y] = pol2cart(obj.theta,obj.rho);
                obj.unchangedCoordinate(1,:)=obj.x;
                obj.unchangedCoordinate(2,:)=obj.y;
            else
                fprintf('obj=Transform2D(type_,unchangedCoordinate_),其中type_值出错！');
            end
        end
        function changedCoordinate=RigidBodyTrans(obj,R_Vec_,T_)
            
            %预处理
            if size(T_,1)<size(T_,2)
                T_=T_';
            end
            T_=repmat(T_,1,size(obj.unchangedCoordinate,2));
            obj.T=T_;
            
            %利用RT进行坐标变换
            if size(R_Vec_,1)==size(R_Vec_,2)
                obj.R=R_Vec_;
                changedCoordinate = obj.R*obj.unchangedCoordinate+T_;
            elseif (size(R_Vec_,1)==3)||(size(R_Vec_,2)==3)
                obj.n=R_Vec_;
                thet=norm(obj.n);
                changedCoordinate=obj.unchangedCoordinate*cos(thet)...
                    +(1-cos(thet))*((obj.n/thet)*obj.unchangedCoordinate)*(obj.n/thet)...
                    +sin(thet)*cross((obj.n/thet),obj.unchangedCoordinate)+T_;
            end
            
            obj.changed_x=changedCoordinate(1,:);
            obj.changed_y=changedCoordinate(2,:);
            [obj.changed_theta,obj.changed_rho] = cart2pol(obj.changed_x,obj.changed_y);
            
            %输出变换后的坐标
            if obj.type==1
                
            elseif obj.type==2
                changedCoordinate(1,:)=obj.changed_theta;
                changedCoordinate(2,:)=obj.changed_rho;
            end
            
        end
        
    end
    
end

