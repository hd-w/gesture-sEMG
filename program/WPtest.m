% load leleccum;  
% s = leleccum(1:3920); 
% % ��db1С���������źŽ������߶�С���ֽ�
% [C,L]=wavedec(s,8,'db1');  
% figure(1);
% plot(s);
% title('leleccumԭʼ�ź�');
% % ��ȡ�߶�1�ĵ�Ƶϵ��
% cA1 = appcoef(C,L,'db1',1); %��С���ֽ���[C.L]����1���Ƶϵ���Ľ���ֵ��С����Ϊdb1
% % ��ȡ�߶�2�ĵ�Ƶϵ��
% cA2 = appcoef(C,L,'db1',6);  
% figure(2);
% subplot(2,1,1);
% plot(cA1);
% title('�߶�1�ĵ�Ƶϵ��');
% subplot(2,1,2);
% plot(cA2);
% title('�߶�2�ĵ�Ƶϵ��');
% % ��ȡ�߶�1�ĸ�Ƶϵ��
% cD1 = detcoef(C,L,1);   %��С���ֽ���[C.L]����1���Ƶϵ���Ľ���ֵ��С����Ϊdb1
% % ��ȡ�߶�2�ĸ�Ƶϵ��
% cD2 = detcoef(C,L,8);   
% figure(3);
% subplot(2,1,1);
% plot(cD1);
% title('�߶�1�ĸ�Ƶϵ��');
% subplot(2,1,2);
% plot(cD2);
% title('�߶�2�ĸ�Ƶϵ��');

% clear all  
% clc
% [num]=xlsread('C:\Users\W\Desktop\EMG data\xh10.xlsx',1,'C12:C2501');
% 
% fs=1024;  %����Ƶ��
% % f1=100;   %�źŵĵ�һ��Ƶ��
% % f2=300;   %�źŵڶ���Ƶ��
% t=0:1/fs:1;
% plot(num)


[tt]=wpdec(s,3,'dmey');  %С�����ֽ⣬3����ֽ�3�㣬��ͼ1������'dmey'ʹ��meyrС��
plot(tt)                 %������ǻ���ͼ1�Ǹ�ͼ������������������
wpviewcf(tt,1);

% load leleccum;
% fs = 6400;
% ts = 0.16;
% N = fs*ts;
% N=4320;
% Layer = 3;
% A=zeros(1,2^Layer);
%  t = (0:N-1)/fs;
% x = sin(2*pi*50*t);
% transdata=zeros(IMFpage/2,Layer*2);
% trainrow=1;
% traincol=1;
% for iv=1:2:IMFpage-1
% for iii=iv:iv+1
% x=s(:,iii);
% % plot(x);
% dwtmode('per');
% T = wpdec(x,Layer,'db20');
% cfs = wpcoef(T,[3 3]);
% for ii=1:Layer
% for i=1:2^ii %wpcoef(wpt1,[n,i-1])�����n���i���ڵ��ϵ��
% E(i)=norm(wpcoef(T,[ii,i-1]),2);%���i���ڵ�ķ���ƽ������ʵҲ����ƽ����
% 
% end
% E_total=sum(E); %��������
% transdata(trainrow,traincol)=max(E)/E_total;
% traincol=traincol+1;
% end
% 
% end
% trainrow=trainrow+1;
% traincol=1;
% end


% for j=2:2^Layer
%     M(1,j)=E(j);
% E_total=sum(E); %��������
% for i=1:2^Layer
% Q(i)= E(i)/E_total;%��ÿ���ڵ�ĸ���
% end
% plot(cfs);
% figure;
% plot(T);
% plot(1:2^3,Q);
%plot(1:2^Layer,A);

