sl = load('E:\college age\��ҽ��\��ҵ���\EMG data\2nddata\train_group2nd.mat');%��ȡcollect_traindata��ȡ������ѵ�����ݼ���ǩ 
names = fieldnames(sl); % ��ȡmat�����б���������
train_group2nd = sl.(names{1}); % ȡ����һ������

sl = load(['E:\college age\��ҽ��\��ҵ���\EMG data\2nddata\','traindata2nd.mat']);
names = fieldnames(sl); 
traindata2nd = sl.(names{1}); 
correctrate_gather=[];%v����ȷ�ʽ����ռ�������
classifyresult_gather = [];%v�β��Խ�������ռ�������
sample_gather = [];%v�β������������ռ�������
sample_group_gather = [];
for v=1:10 %v�β���  ��ÿ�β��Ե���������segment * n��������100�飩
filename1=ls('E:\college age\��ҽ��\��ҵ���\EMG data\2nddata\sample\*.xlsx');%ȡ������excel�ļ�
filename=cellstr(filename1);
num=length(filename);%�õ�excel�ļ��ĸ���n
segment=10;%ÿ�����źŽ�segment����Ϊ���ź�
M=[];raw=[];sample_group=ones(num*segment,1);
n=499;
iii=1;
for ii=1:num
    i=randi([0 10]);
raw=xlsread(['E:\college age\��ҽ��\��ҵ���\EMG data\2nddata\sample\',filename{ii}],1,'C20:D5500');
for j=1:segment
M=[M,raw(i:i+n,1:2)];
i= i + n + randi([0 50]);
end
sample_group(iii:iii+segment-1,1) = str2num(filename1(ii));
iii = iii+segment;
end

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
% figure(1);
% freqz(b,a,NLen,fs);%�ݲ���������ʾ
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
sample=zeros(IMFpage/2,Layer*2);%knnѵ���� �У�IMFpage/2������  �У�Layer���ֽ����Layer*2����ֵ  ��2��������ͨ���źŹ�ͬ����һ��������
samplerow=1;
samplecol=1;
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
sample(samplerow,samplecol)=max(E);
samplecol=samplecol+1;
end

end
samplerow=samplerow+1;
samplecol=1;
end

model_linear = svmtrain(train_group2nd, traindata2nd, '-t 0');% -t 0 �����Ժ˵Ĳ���
[classifyresult, accuracy] = svmpredict(sample_group, sample, model_linear);
 
       correct_rate =  accuracy(1,1)/100;
       correctrate_gather = [correctrate_gather,correct_rate];%v��׼ȷ�ʷ�������
       classifyresult_gather = [classifyresult_gather,classifyresult];%v�β��Խ��,classifyresult��������
       sample_gather = [sample_gather,sample];
       sample_group_gather = [sample_group_gather,sample_group];
end

[C,I] = max(correctrate_gather);
contrastmatrix=[sample_group_gather(:,I), classifyresult_gather(:,I)];
[row,col,V]=find(contrastmatrix(:,1) ~= contrastmatrix(:,2));%�ҳ�������λ��
train_groupupdatepart = sample_group_gather(:,I);
traindata_updatepart = sample_gather(:,(I-1)*6+1:I*6);   %ԭ��ÿ��sample��n x 6����
traindata_updatepart(row,:)=[];%ɾ���������ı�ǩ������
train_groupupdatepart(row,:)=[];

traindata2nd=[traindata2nd;traindata_updatepart];%��������ȷ�ļ���ѵ���� ����ѵ������ģ
train_group2nd=[train_group2nd;train_groupupdatepart];