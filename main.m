clear
clc
load data
[m,n]=size(data_route);
n=max(max(data_route(:,2)),max(data_route(:,3)));
G=inf*ones(n);
for i=1:n
    G(i,i)=0;
end
for i=1:m
    G(data_route(i,2),data_route(i,3))=1;
    G(data_route(i,3),data_route(i,2))=1;
end
