% clear;
% close all;
% wp=[40 60]/100;
% ws=[49 51]/100; %���λ��ͨ������ 50hz
% rp=3; %ͨ�����Ƶ���3db
% rs=20;%���˥������20DB
% fs=200;%����Ƶ��200hz
% [n,wn]=buttord(wp,ws,rp,rs);
% [h]=butter(n,wn,'stop');
% figure(1),freqz(h,512,fs);
% t=(0:200)/fs;
% s=sin(80*pi*t)+sin(100*pi*t)+sin(120*pi*t);
% sf=filter(h,1,s);%��s�����˲�
% figure(2),subplot(2,1,1),plot(t*200,s);
% ylabel('magnitude');xlabel('Hz');title('���sin�ź�');
% figure(2),subplot(2,1,2),plot(t*200,sf);
% ylabel('magnitude');xlabel('Hz');title('filtel���ź�');
% Y=fft(s,512);
% pyy=Y.*conj(Y)/512;
% f=1000/512*(0:255);
% figure(3),subplot(2,1,1),plot(f/5,pyy(1:256));
% ylabel('magnitude');xlabel('Hz');title('�˲�ǰƵ��');
% Y=fft(sf,512);
% pyy=Y.*conj(Y)/512;
% f=1000/512*(0:255);
% figure(3),subplot(2,1,2),plot(f/5,pyy(1:256));
% ylabel('magnitude');xlabel('Hz');title('�˲���Ƶ��');


%���ó�ֵ
% f0=50;
% Ts=0.001;
% fs=1/Ts;
% NLen=500;
% n=0:NLen-1;
% %�ݲ��������
% apha=-2*cos(2*pi*f0*Ts);
% beta=0.96;
% b=[1 apha 1];
% a=[1 apha*beta beta^2];
% figure(1);
% freqz(b,a,NLen,fs);%�ݲ���������ʾ
% % x=xlsread('C:\Users\W\Desktop\EMG data\2nddata\30 13.xlsx',1,'C112:C611');%ԭ�ź�
% 
% y=dlsim(b,a,x);%�ݲ����˲�����
% % ���źŽ���Ƶ��任��
% xfft=fft(x,NLen);
% xfft=xfft.*conj(xfft)/NLen;
% y1=fft(y,NLen);
% y2=y1.*conj(y1)/NLen;
% figure(2);%�˳�ǰ����źŶԱȡ�
% subplot(2,2,1);plot(n,x);grid;
% xlabel('ʱ�� (ms)');ylabel('��ֵ��uV��');title('�����ź�');
% axis([0 500 -120 100]);
% subplot(2,2,3);plot(n,y);grid;
% xlabel('ʱ�� (ms)');ylabel('��ֵ��uV��');title('�ݲ����');
% axis([0 500 -100 100]);
% subplot(2,2,2);plot(n*fs/NLen,xfft);axis([0 fs/2 min(xfft) max(xfft)]);grid;
% xlabel('Ƶ�� (Hz)');ylabel('���� (dB)');title('�����ź�');
% subplot(2,2,4);plot(n*fs/NLen,y2);axis([0 fs/2 min(y2) max(y2)]);grid;
% xlabel('Ƶ�� (Hz)');ylabel('���� (dB)');title('�ݲ����');
Fp=140;Fs=150;%ͨ�������Ƶ�� 
wp=Fp*2/fs;
ws=Fs*2/fs;
rp=2;rs=20;
% ͨ�����������˥��
% ������˹�����ִ�ͨ�˲������
[q,wn]=buttord(wp,ws,rp,rs);
[b,a]=butter(q,wn);
y3=filter(b,a,y);
figure(3)
plot(n,y);hold on;
plot(n,y3,'r');
xlabel('ʱ�� (ms)');ylabel('��ֵ��uV��');title('��ͨ�˲�ǰ��Ա�');

% IMF=eemd(y3,0.01,100);

