
A=0;B=0;C=0;D=0;
for p_num=1:plane_num
    selectedpoints(:,:,p_num) = getpointsXYZ(hFigure,3,p_num);  %点击获取三维坐标点
    
    plane = selectedpoints(:,:,p_num);                          %三个点求解一般平面方程AX+BY+CZ+D=0
    A(p_num) = (plane(2,2) - plane(2,1))*(plane(3,3) - plane(3,1)) - (plane(3,2) - plane(3,1))*(plane(2,3) - plane(2,1));
    B(p_num) = (plane(1,3) - plane(1,1))*(plane(3,2) - plane(3,1)) - (plane(1,2) - plane(1,1))*(plane(3,3) - plane(3,1));
    C(p_num) = (plane(1,2) - plane(1,1))*(plane(2,3) - plane(2,1)) - (plane(1,3) - plane(1,1))*(plane(2,2) - plane(2,1));
    D(p_num) = -(A(p_num) * plane(1,1) + B(p_num) * plane(2,1) + C(p_num) * plane(3,1));
    
    %******step2面点******%
    clear xyz
    num=0;XYZ=[nan;nan;nan];
    for i=1:camera_num
        eval(['XYZ=[XYZ,CAMERA',num2str(i),'.num1.XYZ];'])
    end
    for i=1:size(XYZ,2)
        if XYZ(3,i)>(-A(p_num)/C(p_num))*XYZ(1,i)-(B(p_num)/C(p_num))*XYZ(2,i)-(D(p_num)/C(p_num))-Width/2 && XYZ(3,i)<(-A(p_num)/C(p_num))*XYZ(1,i)-(B(p_num)/C(p_num))*XYZ(2,i)-(D(p_num)/C(p_num))+Width/2
            num=num+1;
            xyz(:,num)=XYZ(:,i);
        end
    end
    if num~=0
        scatter3(xyz(1,:),xyz(2,:),xyz(3,:))
        %scatter(xyz(2,:),xyz(3,:))
        axis equal
    end
    
    %******step3圆心******%
    for i=1:3
        xy=xyz;
        xy(i,:)=[];
        a0 = [1 1 1 1 1];
        f = @(a,xy)xy(1,:).^2+a(1)*xy(1,:).*xy(2,:)+a(2)*xy(2,:).^2+a(3)*xy(1,:)+a(4)*xy(2,:)+a(5);
        p = nlinfit(xy,zeros(1,size(xy,2)),f,a0);
        x0y0(1,i)=(2*p(2)*p(3)-p(1)*p(4))/(p(1)^2-4*p(2));
        x0y0(2,i)=(2*p(4)-p(1)*p(3))/(p(1)^2-4*p(2));
    end
    ellipse_xyz(1,p_num)=(x0y0(1,2)+x0y0(1,3))/2;
    ellipse_xyz(2,p_num)=(x0y0(1,1)+x0y0(2,3))/2;
    ellipse_xyz(3,p_num)=(x0y0(2,1)+x0y0(2,2))/2;
end