function pos = getpointsXYZ(hFigure,n,j)

datacursormode on

dcm_obj = datacursormode(hFigure);

pos = zeros(n,3);
for i = 1:n
    disp('点击获取数据点，按任意键继续')
    % Wait while the user does this.
    pause
    
    c_info = getCursorInfo(dcm_obj);
    pos(:,i) = c_info.Position;
end
disp(['Finish No.' num2str(j) '，按任意键结束'])
pause
end