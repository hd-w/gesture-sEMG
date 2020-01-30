% Nlen=1000;
% fs1=1000;%采样频率
% fp=[3 150];%通带频率
% fc=[1 160];%阻带频率
% wp=2*fp/fs1;%对2分之采样频率归一化的通带角频率
% ws=2*fc/fs1;%对2分之采样频率归一化的阻带角频率
% rp=0.1;%通带波动系数
% rs=30;%阻带波动系数
% [N,wn]=buttord(wp,ws,rp,rs);%求巴特沃兹滤波器的系数及3db截止频率
% [B,A]=butter(N,wn);%计算滤波器系数
% [h,w]=freqz(B,A);
% freqz(B,A,NLen,fs)
fo=1000;%采样频率?
N=200;
fp=140;fs=150;%通带、阻带频率 
wp=fp*2/fo;
ws=fs*2/fo;
rp=2;rs=20;
%通带波动、阻带衰减
%巴特沃斯型数字带通滤波器设计
[n,wn]=buttord(wp,ws,rp,rs);
[b,a]=butter(n,wn);
y=filter(b,a,x);

