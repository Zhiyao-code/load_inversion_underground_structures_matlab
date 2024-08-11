function logpro=dw_fem_test_muchpar(n,zi,xi,K,l,node,conn,data)

coord=node(conn);
P=curvefitting(n,zi,xi,coord);
%边界条件处理，用矩阵计算代替循环
numelement=numel(conn)/2;
numDof=2*(numelement+1);

L=l/numelement;
A1=[7*L/20,3*L^2/60;3*L/20,2*L^2/60];%L表示单元长度
A2=[3*L/20,-2*L^2/60;7*L/20,-3*L^2/60];
F1=P*A1;
F2=P*A2;
F1=[F1;0,0];
F2=[0,0;F2];
F=F1+F2;
f=F';
f=f(:);
delta1=K\f;
delta=(delta1(1:2:numDof-1)*1000)';
indx=ismember(round(0:L:l,2),round(data(1,:),2));
delta_cp=delta(indx);
error=delta_cp-data(2,:);
logpdf=-error.^2/2;%方差设置为1
logpro=sum(logpdf);

end