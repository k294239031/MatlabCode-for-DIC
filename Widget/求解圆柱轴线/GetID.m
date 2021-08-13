hFigure= figure(1);
% a=1:10;                     %绘图部分
% b=20:29;                     %绘图部分
% c=2:11;                     %绘图部分，任意数组
% scatter3(a,b,c)             %绘图部分
eval(['surf(CAMERA1.num3.xyz(:,:,1),CAMERA1.num3.xyz(:,:,2),CAMERA1.num3.xyz(:,:,3),CAMERA1.num3.' huitu ');'])
datacursormode on
dcm_obj = datacursormode(hFigure);
set(dcm_obj,'UpdateFcn',@(hObject, event_obj) myupdatefcn(hObject, event_obj,CAMERA1.num3.dy) );
