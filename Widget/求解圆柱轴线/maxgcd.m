function [maxgcd]=maxgcd(A)
%求解最大公因数
%maxgcd([6 9 27])
n=length(A);
maxgcd=A(1);
for i=1:1:(n-1)
    maxgcd=gcd(maxgcd,A(i+1));
end
end