function [right]=AutoRank(left,right,i)
%�����ұ�־����Ž���ƥ�䣬�������Ҿ���
%i=1ʱ��N������/i=2ʱ��A��BΪ����N��
if i==2
    left=left';
    right=right';
end
num=1;
for j=1:size(left,1)
    for k=1:1:size(right,1)
    if left(j,1)==right(k,1)
        a(num,:)=right(k,:);
        num=num+1;
        break
    end
    end
end
right=a;
if i==2
    right=right';
end