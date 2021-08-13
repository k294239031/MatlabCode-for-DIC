function [right]=AutoRank(left,right,i)
%对左右标志点序号进行匹配，并排序右矩阵
%i=1时，N行三列/i=2时，A，B为三行N列
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