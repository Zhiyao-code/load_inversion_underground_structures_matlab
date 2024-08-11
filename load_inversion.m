addpath(genpath('E:\tzy\自适应贝叶斯反演\matlab\manuscript2\curve_fitting\manuscrit_update_major\Load_inversion_ap_pt_rjmcmc'));
global scale_factor sc
rng('shuffle');
T=2000000;nn=101;N=10;
scale_factor=ones(1,N);
sc=nan(T,N);

n_min=3;n_max=nn;
x_min=-300;x_max=300;  %%%%%%%prior
R=[n_min,n_max;x_min,x_max];

l=10;E=25e6;I1=187e3/25e6;I2=171e3/25e6;  %%%%%%%enter your own structure details. anti-slide pile in this case
numelement=100;%划分为100个单元   %%%%%%% FEM forward model
L=l/numelement;%单元大小
[K,K0,node,conn]=bigStiffness(numelement,L,E,I1,I2);

load('data.mat'); %%%%%%%%%%%%enter your own data

pdf=@(n,z,x)dw_fem_test_muchpar(n,z,x,K,l,node,conn,data);


[n,z,x,p_x]=AP_PT_RJMCMC(pdf,R,T,l,nn,N);

figure 
plot(n);
figure
plot(p_x(end/2:end,:));

post_n=n(end/2:end,1);
post_x=x(end/2:end,:,1);
post_z=z(end/2:end,:,1);

figure 
histogram(post_n);
figure 
plot(post_n);

l_mp=load_density_map(post_n,post_x,post_z,l,nn,-500,500);
