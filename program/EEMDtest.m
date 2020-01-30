% f=8*10^3;     %信号频率
% f1=30*10^3;    %噪声频率
% l=100;       %信号的长度
% fs=100*10^3; %采样频率
% %%%%%%%%%%%%%%%%生成信号
% t=(0:l-1)/fs;
% s=0.5*sin(2*pi*f*t)+cos(2*pi*f1*t);
% for n=1:Mcol
% IMF(:,:,n)=eemd(Mfiltered(:,n),0.01,100);
% 
% end
% IMF=eemd(s,0.01,100);
% ploteemd(s);

% [IMFraw,IMFcol,IMFpage]=size(IMF);
% s=zeros(IMFraw,IMFpage);
% for ii=1:IMFpage
% for i=3:9
%    s(:,ii)=s(:,ii)+IMF(:,i,ii);
% end
% end
% figure;
% plot(s(:,3),'red');hold on;
% M=xlsread(['C:\Users\W\Desktop\EMG data\','0 1.xls'],1,'C50:D6300');
%  plot(s(:,1));
% ii=1;
% for i=1:2:9
%     
%    subplot(5,1,ii)
%    plot(M(:,i));
%     ii=ii+1;
% end

%
plot(s(:,1));
figure (2);
plot(s(:,3));
figure (3);
plot(s(:,5));
figure (4);
plot(s(:,7));
figure (5);
plot(s(:,9));
figure (6);
plot(s(:,11));
figure (7);
plot(s(:,13));
figure (8);
plot(s(:,15));
figure (9);
plot(s(:,17));