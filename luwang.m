clear
clc
tic
%OD1_2所有可能的路径
OD1=[2,18,11,0,0,0;2,17,7,9,11,0;2,17,7,10,15,0;2,17,8,14,15,0;1,6,12,14,15,0;1,5,8,14,15,0;1,5,7,10,15,0;1,5,7,9,11,0];
%OD1_3所有可能的路径
OD2=[1,6,13,19,0,0;1,5,7,10,16,0;1,5,8,14,16,0;1,6,12,14,16,0;2,17,8,14,16,0;2,17,7,10,16,0];
%OD4_2所有可能的路径
OD3=[3,5,7,9,11,0;3,5,7,10,15,0;3,5,8,14,15,0;3,6,12,14,15,0;4,12,14,15,0,0];
%OD4_3所有可能的路径
OD4=[4,12,19,0,0,0;4,12,14,16,0,0;3,6,12,14,16,0;3,5,8,14,16,0;3,5,7,10,16,0];
x=sdpvar(19,1);
t0=[7;9;9;12;3;9;5;13;5;9;9;10;9;6;9;8;7;14;11];%自由时间
c=[900;700;700;900;800;600;900;500;300;400;700;700;600;700;700;700;300;700;700];%容量
t=t0.*x+t0.*(0.03*x.^5)./(c.^4);%时间（积分后）
f=sum(t);%目标函数
od1=sdpvar(8,1);%每个路径选择的车辆数
od2=sdpvar(6,1);%每个路径选择的车辆数
od3=sdpvar(5,1);%每个路径选择的车辆数
od4=sdpvar(5,1);%每个路径选择的车辆数
link=zeros(19,8+6+5+5);%路径-道路关联矩阵
[m,n]=size(OD1);
for i=1:m
    for j=1:n
        if OD1(i,j)~=0
            link(OD1(i,j),i)=1;
        end
    end    
end
[m,n]=size(OD2);
for i=1:m
    for j=1:n
        if OD2(i,j)~=0
            link(OD2(i,j),i+8)=1;
        end
    end    
end
[m,n]=size(OD3);
for i=1:m
    for j=1:n
        if OD3(i,j)~=0
            link(OD3(i,j),i+8+6)=1;
        end
    end    
end
[m,n]=size(OD4);
for i=1:m
    for j=1:n
        if OD4(i,j)~=0
            link(OD4(i,j),i+8+6+5)=1;
        end
    end    
end
C=[x==link*[od1;od2;od3;od4]];%道路流量
C=[C,x>=0,od1>=0,od2>=0,od3>=0,od4>=0,sum(od1)==400,sum(od2)==800,sum(od3)==600,sum(od4)==200];
ops=sdpsettings('solver','ipopt');%内点法
solvesdp(C,f,ops);
x=double(x);%结果展示
t=t0+t0.*(0.15*x.^4)./(c.^4);%路径时间
f=double(f);od1=double(od1);od2=double(od2);od3=double(od3);od4=double(od4);
toc
%文献结果
%x=[800;400;395.300000000000;404.700000000000;898;297.300000000000;898;0;395.300000000000;502.700000000000;795.300000000000;204.700000000000;497.300000000000;204.700000000000;204.700000000000;502.700000000000;0;400;497.300000000000];
%t=t0+t0.*(0.15*x.^4)./(c.^4);
%f=sum(t0.*x+t0.*(0.03*x.^5)./(c.^4));