function [dia1,dia2]=convergence_diagnose(loadi,loadj)
T=length(loadi);
% T=100;
gap=floor(T/100);
j=1;
dia1=nan(1,101);
dia2=nan(1,101);

i=16;
    avgi=mean(loadi(i/2:i,:));
    avgj=mean(loadj(i/2:i,:));
    stdi=std(loadi(i/2:i,:),0,1);
    stdj=std(loadj(i/2:i,:),0,1);
    std_av=(stdi+stdj)/2;
    diff_di1=abs((avgi-avgj))./std_av;
    dia1(1,j)=mean(diff_di1);
    
    diff_di2=abs((stdi-stdj))./std_av;
    dia2(1,j)=mean(diff_di2);
       
    j=j+1;
for i=gap:gap:T
    avgi=mean(loadi(i/2:i,:));
    avgj=mean(loadj(i/2:i,:));
    stdi=std(loadi(i/2:i,:),0,1);
    stdj=std(loadj(i/2:i,:),0,1);
    std_av=(stdi+stdj)/2;
    diff_di1=abs((avgi-avgj))./std_av;
    dia1(1,j)=mean(diff_di1);
    
    diff_di2=abs((stdi-stdj))./std_av;
    dia2(1,j)=mean(diff_di2);
       
    j=j+1;
end
figure
plot([0:100],dia1);
hold on
plot([0:100],dia2);
hold on
plot([1:100],ones(1,100)*0.2);
