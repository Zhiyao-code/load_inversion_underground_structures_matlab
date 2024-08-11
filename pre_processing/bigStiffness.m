function [K,K0,node,conn]=bigStiffness(numelement,L,E,I1,I2)
node=0:L:numelement*L;%节点坐标
conn=[1:1:numelement;2:1:numelement+1]';%节点矩阵
numNode=numelement+1;%节点数
numDof=2*numNode;
coord=node(conn);
%%%%%%%%%%%%%%%%fem 矩阵组装
ke_down=finite_element_beam(L,E,I1);%beam 下部单刚
ke_up=finite_element_beam(L,E,I2);%beam 下部单刚
K=zeros(numDof,numDof);%矩阵大小
scter=zeros(1,4);
K0=zeros(numelement*4,numelement*4);
%%%地基刚度k=k0+a*x,   
% k0=1.1e3;a=-1e3;

for i=1:1:numelement
    scter(1:2:3)=conn(i,:)*2-1;
    scter(2:2:4)=conn(i,:)*2;
%     if(i<=numelement/l*buried)
%     k1=a*(coord(i,1))+k0;k2=a*(coord(i,2))+k0;%%%%%%%%%%%%%%%%%%%%%%%%%%%foundation 单刚,码字错误
%     kf=finite_element_foundation(k1,k2,L);
%     else
%         kf=zeros(4,4);
%     end
    if(i==1)
        k1=1e12;k2=1e12;
        kf=finite_element_foundation(k1,k2,L);
    else           
        kf=zeros(4,4);
    end
    if(i<=numelement/10*7)
    K0(i*4-3:4*i,i*4-3:4*i)=ke_down+kf;%计算弯矩的铺垫
    K(scter,scter)=K(scter,scter)+ke_down+kf;
    else
    K0(i*4-3:4*i,i*4-3:4*i)=ke_up+kf;%计算弯矩的铺垫
    K(scter,scter)=K(scter,scter)+ke_up+kf;  
    end
end