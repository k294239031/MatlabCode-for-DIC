function [n]= R2Vec(R)
%��ת����R����ת����n��ת��
%�˴���ʾ��ϸ˵��
thet=acos((trace(R)-1)/2);
vector_M=((R-R')/2)/sin(thet);
n=[vector_M(3,2),vector_M(1,3),vector_M(2,1)];
n=n*thet;
end