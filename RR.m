%依据SVDD理论中原问题R^2和对偶变量a的关系，计算出R^2
%k是a值小于C的支持变量在a数组中对应的下标
function [ R2 ] = RR( k,data1,N,a ,dimension)
R2=Gaussian(data1,k,data1,k,dimension);
i=1;
while(i<=N)
    R2=R2-2*a(i)*Gaussian(data1,i,data1,k,dimension);
    i=i+1;
end
i=1;
j=1;
while(i<=N)
    while(j<=N)
      R2=R2+a(i)*a(j)*Gaussian(data1,i,data1,j,dimension);
      j=j+1;
    end
    i=i+1;
end

end

