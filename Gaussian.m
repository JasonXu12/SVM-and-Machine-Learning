%高斯核函数，参数s取0.5，dimension为维度
%将点data1（i)与data（2）带入计算
function [K] = Gaussian(data1,i,data2,j,dimension)

s=0.5;
k=1;
d=0;
while(k<=dimension)
d=d+(data1(i,k)-data2(j,k))^2;
k=k+1;
end

K=exp(-d/s);

end

