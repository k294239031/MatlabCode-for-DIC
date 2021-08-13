classdef Transform2D < handle
    %Transform2D ��ά����ת��
    %   Version1.1������������ϵ�任��ƽ��ֱ������ϵ�뼫����ϵ���໥ת��
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
            %type_=1,��ʾ����Ϊ�ѿ�������
            %type_=2,��ʾ����Ϊ������
            %����xyӦΪ����N��,��xy=[x1 x2 ...xn
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
                fprintf('obj=Transform2D(type_,unchangedCoordinate_),����type_ֵ����');
            end
        end
        function changedCoordinate=RigidBodyTrans(obj,R_Vec_,T_)
            
            %Ԥ����
            if size(T_,1)<size(T_,2)
                T_=T_';
            end
            T_=repmat(T_,1,size(obj.unchangedCoordinate,2));
            obj.T=T_;
            
            %����RT��������任
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
            
            %����任�������
            if obj.type==1
                
            elseif obj.type==2
                changedCoordinate(1,:)=obj.changed_theta;
                changedCoordinate(2,:)=obj.changed_rho;
            end
            
        end
        
    end
    
end

