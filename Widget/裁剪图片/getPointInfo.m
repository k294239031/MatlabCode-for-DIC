function pos = getPointInfo(hFigure,n)

datacursormode on

dcm_obj = datacursormode(hFigure);

pos = zeros(n,2);
for i = 1:n
    disp('�����ȡ���ݵ㣬�����������');
    % Wait while the user does this.
    pause
    
    c_info = getCursorInfo(dcm_obj);
    pos(i,:) = c_info.Position;
    fprintf('��%d���㣬��%d��ȡ�ɹ�\n', n, i);
end
fprintf('\nFinish\n');
close
end