% Nlen=1000;
% fs1=1000;%����Ƶ��
% fp=[3 150];%ͨ��Ƶ��
% fc=[1 160];%���Ƶ��
% wp=2*fp/fs1;%��2��֮����Ƶ�ʹ�һ����ͨ����Ƶ��
% ws=2*fc/fs1;%��2��֮����Ƶ�ʹ�һ���������Ƶ��
% rp=0.1;%ͨ������ϵ��
% rs=30;%�������ϵ��
% [N,wn]=buttord(wp,ws,rp,rs);%����������˲�����ϵ����3db��ֹƵ��
% [B,A]=butter(N,wn);%�����˲���ϵ��
% [h,w]=freqz(B,A);
% freqz(B,A,NLen,fs)
fo=1000;%����Ƶ��?
N=200;
fp=140;fs=150;%ͨ�������Ƶ�� 
wp=fp*2/fo;
ws=fs*2/fo;
rp=2;rs=20;
%ͨ�����������˥��
%������˹�����ִ�ͨ�˲������
[n,wn]=buttord(wp,ws,rp,rs);
[b,a]=butter(n,wn);
y=filter(b,a,x);
