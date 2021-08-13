function pos = getPointInfo(hFigure,n)

datacursormode on

dcm_obj = datacursormode(hFigure);

pos = zeros(n,2);
for i = 1:n
    disp('点击获取数据点，按任意键继续');
    % Wait while the user does this.
    pause
    
    c_info = getCursorInfo(dcm_obj);
    pos(i,:) = c_info.Position;
    fprintf('共%d个点，点%d获取成功\n', n, i);
end
fprintf('\nFinish\n');
close
end