hFigure= figure(1);
% a=1:10;                     %��ͼ����
% b=20:29;                     %��ͼ����
% c=2:11;                     %��ͼ���֣���������
% scatter3(a,b,c)             %��ͼ����
eval(['surf(CAMERA1.num3.xyz(:,:,1),CAMERA1.num3.xyz(:,:,2),CAMERA1.num3.xyz(:,:,3),CAMERA1.num3.' huitu ');'])
datacursormode on
dcm_obj = datacursormode(hFigure);
set(dcm_obj,'UpdateFcn',@(hObject, event_obj) myupdatefcn(hObject, event_obj,CAMERA1.num3.dy) );
