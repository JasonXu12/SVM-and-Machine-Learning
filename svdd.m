% N是导入训练样本的个数，d是样本属性的维度
[N,d]=size(data1);
% 判断希望训练的维度是否小于或等于样本的维度，若不是，则报错
if(dimension>d)
    disp('dimension is over the size!');
else
 
% 下面进行SMO算法

%对a[]进行初始化，a是对偶问题的变量，共N个，和为1，初始化为1/N
a=linspace(1/N,1/N,N);

% 根据梯度公式，依据a[]的初始化完成梯度g的初始化，g（i)是对偶问题的目标函数对a（i)求偏导；
i=1;
while(i<=N)
g(i)=Gaussian(data1,i,data1,i,dimension);
i=i+1;
end
i=1;
j=1;
while(i<=N)
while(j<=N)
g(i)=g(i)-a(j)*Gaussian(data1,i,data1,j,dimension);
j=j+1;
end
g(i)=g(i)-a(i)*Gaussian(data1,i,data1,i,dimension);
j=1;
i=i+1;
end

%对偶变量a[]的边界条件C，结果检验，设为0.25比较合适
C=0.25;
%取梯度最大和梯度最小的g
[gmax,i]=max(g);
[gmin,j]=min(g);
%delta为约束条件
delta=gmax-gmin;
%循环次数count，防止死循环
count=0;
%L为SMO算法的步长
L=0;
while(delta>=0.0000001&&count<2000)
L3=[C-a(i) a(j) (g(i)-g(j))/(Gaussian(data1,i,data1,i,dimension)+Gaussian(data1,j,data1,j,dimension)-2*Gaussian(data1,i,data1,j,dimension))];
L=min(L3);
k=1;
%每次迭代对SMO的梯度g[]进行更新
while(k<=N)
g(k)=g(k)-L*Gaussian(data1,k,data1,i,dimension)+L*Gaussian(data1,k,data1,j,dimension);
k=k+1;
end
%a[]也进行相应的更新
a(i)=a(i)+L;
a(j)=a(j)-L;
%IDi和IDj分别是满足<C和>0条件的a的集合
IDi=find(a<C-eps);
IDj=find(a>eps);
%从IDi中选取梯度最大的，从IDj中选取梯度最小的
[gmax,IDix]=max(g(IDi));
i=IDi(IDix(1));
[gmin,IDjx]=min(g(IDj));
j=IDj(IDjx(1));
%收敛性条件判断
delta=gmax-gmin;
count=count+1;
end
end