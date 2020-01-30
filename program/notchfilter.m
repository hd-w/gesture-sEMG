% clear;
% close all;
% wp=[40 60]/100;
% ws=[49 51]/100; %阻带位于通带中心 50hz
% rp=3; %通带波纹低于3db
% rs=20;%阻带衰减低于20DB
% fs=200;%采样频率200hz
% [n,wn]=buttord(wp,ws,rp,rs);
% [h]=butter(n,wn,'stop');
% figure(1),freqz(h,512,fs);
% t=(0:200)/fs;
% s=sin(80*pi*t)+sin(100*pi*t)+sin(120*pi*t);
% sf=filter(h,1,s);%对s进行滤波
% figure(2),subplot(2,1,1),plot(t*200,s);
% ylabel('magnitude');xlabel('Hz');title('混合sin信号');
% figure(2),subplot(2,1,2),plot(t*200,sf);
% ylabel('magnitude');xlabel('Hz');title('filtel后信号');
% Y=fft(s,512);
% pyy=Y.*conj(Y)/512;
% f=1000/512*(0:255);
% figure(3),subplot(2,1,1),plot(f/5,pyy(1:256));
% ylabel('magnitude');xlabel('Hz');title('滤波前频谱');
% Y=fft(sf,512);
% pyy=Y.*conj(Y)/512;
% f=1000/512*(0:255);
% figure(3),subplot(2,1,2),plot(f/5,pyy(1:256));
% ylabel('magnitude');xlabel('Hz');title('滤波后频谱');


%设置初值
% f0=50;
% Ts=0.001;
% fs=1/Ts;
% NLen=500;
% n=0:NLen-1;
% %陷波器的设计
% apha=-2*cos(2*pi*f0*Ts);
% beta=0.96;
% b=[1 apha 1];
% a=[1 apha*beta beta^2];
% figure(1);
% freqz(b,a,NLen,fs);%陷波器特性显示
% % x=xlsread('C:\Users\W\Desktop\EMG data\2nddata\30 13.xlsx',1,'C112:C611');%原信号
% 
% y=dlsim(b,a,x);%陷波器滤波处理
% % 对信号进行频域变换。
% xfft=fft(x,NLen);
% xfft=xfft.*conj(xfft)/NLen;
% y1=fft(y,NLen);
% y2=y1.*conj(y1)/NLen;
% figure(2);%滤除前后的信号对比。
% subplot(2,2,1);plot(n,x);grid;
% xlabel('时间 (ms)');ylabel('幅值（uV）');title('输入信号');
% axis([0 500 -120 100]);
% subplot(2,2,3);plot(n,y);grid;
% xlabel('时间 (ms)');ylabel('幅值（uV）');title('陷波输出');
% axis([0 500 -100 100]);
% subplot(2,2,2);plot(n*fs/NLen,xfft);axis([0 fs/2 min(xfft) max(xfft)]);grid;
% xlabel('频率 (Hz)');ylabel('幅度 (dB)');title('输入信号');
% subplot(2,2,4);plot(n*fs/NLen,y2);axis([0 fs/2 min(y2) max(y2)]);grid;
% xlabel('频率 (Hz)');ylabel('幅度 (dB)');title('陷波输出');
Fp=140;Fs=150;%通带、阻带频率 
wp=Fp*2/fs;
ws=Fs*2/fs;
rp=2;rs=20;
% 通带波动、阻带衰减
% 巴特沃斯型数字带通滤波器设计
[q,wn]=buttord(wp,ws,rp,rs);
[b,a]=butter(q,wn);
y3=filter(b,a,y);
figure(3)
plot(n,y);hold on;
plot(n,y3,'r');
xlabel('时间 (ms)');ylabel('幅值（uV）');title('低通滤波前后对比');

% IMF=eemd(y3,0.01,100);

