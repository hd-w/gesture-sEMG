% load leleccum;  
% s = leleccum(1:3920); 
% % 用db1小波函数对信号进行三尺度小波分解
% [C,L]=wavedec(s,8,'db1');  
% figure(1);
% plot(s);
% title('leleccum原始信号');
% % 提取尺度1的低频系数
% cA1 = appcoef(C,L,'db1',1); %用小波分解框架[C.L]计算1层低频系数的近似值，小波基为db1
% % 提取尺度2的低频系数
% cA2 = appcoef(C,L,'db1',6);  
% figure(2);
% subplot(2,1,1);
% plot(cA1);
% title('尺度1的低频系数');
% subplot(2,1,2);
% plot(cA2);
% title('尺度2的低频系数');
% % 提取尺度1的高频系数
% cD1 = detcoef(C,L,1);   %用小波分解框架[C.L]计算1层高频系数的近似值，小波基为db1
% % 提取尺度2的高频系数
% cD2 = detcoef(C,L,8);   
% figure(3);
% subplot(2,1,1);
% plot(cD1);
% title('尺度1的高频系数');
% subplot(2,1,2);
% plot(cD2);
% title('尺度2的高频系数');

% clear all  
% clc
% [num]=xlsread('C:\Users\W\Desktop\EMG data\xh10.xlsx',1,'C12:C2501');
% 
% fs=1024;  %采样频率
% % f1=100;   %信号的第一个频率
% % f2=300;   %信号第二个频率
% t=0:1/fs:1;
% plot(num)


[tt]=wpdec(s,3,'dmey');  %小波包分解，3代表分解3层，像图1那样，'dmey'使用meyr小波
plot(tt)                 %这个就是画出图1那个图，可以用鼠标在上面点
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
% for i=1:2^ii %wpcoef(wpt1,[n,i-1])是求第n层第i个节点的系数
% E(i)=norm(wpcoef(T,[ii,i-1]),2);%求第i个节点的范数平方，其实也就是平方和
% 
% end
% E_total=sum(E); %求总能量
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
% E_total=sum(E); %求总能量
% for i=1:2^Layer
% Q(i)= E(i)/E_total;%求每个节点的概率
% end
% plot(cfs);
% figure;
% plot(T);
% plot(1:2^3,Q);
%plot(1:2^Layer,A);

