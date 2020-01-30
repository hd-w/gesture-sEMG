 
filename1=ls('C:\Users\W\Desktop\EMG data\3rddata\*.xlsx');%ȡ������excel�ļ�
filename=cellstr(filename1);
num=length(filename);%�õ�excel�ļ��ĸ���n
segment=5;%ÿ�����źŽ�segment����Ϊ���ź�
M=[];raw=[];train_group=ones(num*segment,1);
n=499;
iii=1;
for ii=1:num
    i=randi([10 30]);
raw=xlsread(['C:\Users\W\Desktop\EMG data\3rddata\',filename{ii}],1,'C50:D2600');
for j=1:segment
M=[M,raw(i:i+n,1:2)];
i= i + 100;
end
train_group(iii:iii+segment-1,1) = str2num(filename1(ii));
iii = iii+segment;
end

% subplot(3,1,1);plot(M(:,3));
% subplot(3,1,2);plot(M(:,5));
% subplot(3,1,3);plot(M(:,7));
%%50hz ȥ��
f0=50;
Ts=0.001;
fs=1/Ts;%����Ƶ��
NLen=n+1;%Ŀ���źų���
% n=0:NLen-1;
%�ݲ��������
apha=-2*cos(2*pi*f0*Ts);
beta=0.96;
b=[1 apha 1];
a=[1 apha*beta beta^2];
figure(1);
freqz(b,a,NLen,fs);%�ݲ���������ʾ
Mnotch=[];
[Mrow,Mcol]=size(M);
%��ÿ���ź�ȥ��50hz
for n=1:Mcol
x=M(:,n);%ԭ�ź�
y=dlsim(b,a,x);%�ݲ����˲�����
Mnotch(:,n)=y;

end
%%0-150hz��ͨ
Fp=150;Fs=160;%ͨ�������Ƶ�� 
wp=Fp*2/fs;
ws=Fs*2/fs;
rp=2;rs=20;
%ͨ�����������˥��
%������˹�����ִ�ͨ�˲������
[n,wn]=buttord(wp,ws,rp,rs);
[b,a]=butter(n,wn);
Mfiltered=[];
for n=1:Mcol
x=Mnotch(:,n);
y=filter(b,a,x);
Mfiltered(:,n)=y;

end
for n=1:Mcol
IMF(:,:,n)=eemd(Mfiltered(:,n),0.01,100);

end
[IMFraw,IMFcol,IMFpage]=size(IMF);
s=zeros(IMFraw,IMFpage);
for ii=1:IMFpage
for i=3:9
   s(:,ii)=s(:,ii)+IMF(:,i,ii);%sΪ0-150hz�˲��������ź�ȥ����һ��IMF�����Ƶ�źţ�����źţ�Ȼ��ֱ������С���ֽ�
end
end
%%3��С���ֽ� 1��3��С��ϵ���������ֵ��Ϊ���� ��ÿ��ͨ�����źŻ�Ϊ3������ֵ ����ͨ��6������ֵ����һ������ 
Layer = 3;
traindata=zeros(IMFpage/2,Layer*2);%knnѵ���� �У�IMFpage/2������  �У�Layer���ֽ����Layer*2����ֵ  ��2��������ͨ���źŹ�ͬ����һ��������
trainrow=1;
traincol=1;
for iv=1:2:IMFpage-1
for iii=iv:iv+1
x=s(:,iii);
% plot(x);
dwtmode('per');
T = wpdec(x,Layer,'db20');
cfs = wpcoef(T,[3 3]);
for ii=1:Layer
for i=1:2^ii %wpcoef(wpt1,[n,i-1])�����n���i���ڵ��ϵ��
E(i)=norm(wpcoef(T,[ii,i-1]),2);%���i���ڵ�ķ���ƽ������ʵҲ����ƽ����

end
E_total=sum(E); %��������
traindata(trainrow,traincol)=max(E)/E_total;
traincol=traincol+1;
end

end
trainrow=trainrow+1;
traincol=1;
end







