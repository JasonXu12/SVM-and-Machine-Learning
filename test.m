%M是待检验样本的个数
[M,d]=size(data2);
clear flag;
%确定R
%调用RR函数计算所有训练样本到中心点的距离平方；
 k=1;
while(k<=N)
    r2(k)=RR(k,data1,N,a,dimension);
    k=k+1;
end

%选取支持向量的点的距离平方，取平均作为R^2
 IDsv=find(a>eps);
 R2=mean(r2(IDsv));

%进行检验，利用将点的坐标带入检验公式，若距离大于R，则flag=-1，排除；
%若距离小于R，则flag=1，接纳
k=1;
while(k<=M)
f=Gaussian(data2,k,data2,k,dimension);
i=1;
while(i<=N)
f=f-2*a(i)*Gaussian(data1,i,data2,k,dimension);
i=i+1;
end;
i=1;
j=1;
while(i<=N)
 while(j<=N)
   f=f+a(i)*a(j)*Gaussian(data1,i,data1,j,dimension);
   j=j+1;
 end
 i=i+1;
end

f=R2-f;
flag(k)=sign(f);
k=k+1;
end
%将结果进行输出
InNum=find(flag>0);
Incount=length(InNum);
fprintf('%d /%d samples is included in the classification.\n',Incount,M);

OutNum=find(flag<0);
Outcount=length(OutNum);
fprintf('%d /%d samples is excluded in the classification.\n',Outcount,M);