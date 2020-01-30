sl = load('E:\college age\生医工\毕业设计\EMG data\2nddata\train_group2nd.mat');%读取collect_traindata提取出来的训练数据及标签 
names = fieldnames(sl); % 获取mat中所有变量的名字
train_group2nd = sl.(names{1}); % 取出第一个变量

sl = load(['E:\college age\生医工\毕业设计\EMG data\2nddata\','traindata2nd.mat']);
names = fieldnames(sl); 
traindata2nd = sl.(names{1}); 
correctrate_gather=[];%v次正确率将被收集在这里
classifyresult_gather = [];%v次测试结果将被收集在这里
sample_gather = [];%v次测试样本将被收集在这里
sample_group_gather = [];
for v=1:10 %v次测试  ，每次测试的组数就是segment * n（这里是100组）
filename1=ls('E:\college age\生医工\毕业设计\EMG data\2nddata\sample\*.xlsx');%取得所用excel文件
filename=cellstr(filename1);
num=length(filename);%得到excel文件的个数n
segment=10;%每个长信号截segment段作为新信号
M=[];raw=[];sample_group=ones(num*segment,1);
n=499;
iii=1;
for ii=1:num
    i=randi([0 10]);
raw=xlsread(['E:\college age\生医工\毕业设计\EMG data\2nddata\sample\',filename{ii}],1,'C20:D5500');
for j=1:segment
M=[M,raw(i:i+n,1:2)];
i= i + n + randi([0 50]);
end
sample_group(iii:iii+segment-1,1) = str2num(filename1(ii));
iii = iii+segment;
end

%%50hz 去除
f0=50;
Ts=0.001;
fs=1/Ts;%采样频率
NLen=n+1;%目标信号长度
% n=0:NLen-1;
%陷波器的设计
apha=-2*cos(2*pi*f0*Ts);
beta=0.96;
b=[1 apha 1];
a=[1 apha*beta beta^2];
% figure(1);
% freqz(b,a,NLen,fs);%陷波器特性显示
Mnotch=[];
[Mrow,Mcol]=size(M);
%对每个信号去除50hz
for n=1:Mcol
x=M(:,n);%原信号
y=dlsim(b,a,x);%陷波器滤波处理
Mnotch(:,n)=y;

end
%%0-150hz低通
Fp=150;Fs=160;%通带、阻带频率 
wp=Fp*2/fs;
ws=Fs*2/fs;
rp=2;rs=20;
%通带波动、阻带衰减
%巴特沃斯型数字带通滤波器设计
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
   s(:,ii)=s(:,ii)+IMF(:,i,ii);%s为0-150hz滤波后，所得信号去掉第一层IMF（最高频信号）后的信号，然后直接用于小波分解
end
end
%%3层小波分解 1到3级小波系数能量最大值作为特征 即每个通道的信号化为3个特征值 两个通道6个特征值代表一个动作 
Layer = 3;
sample=zeros(IMFpage/2,Layer*2);%knn训练集 行：IMFpage/2个动作  列：Layer级分解就有Layer*2特征值  ‘2’是两个通道信号共同决定一个动作。
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
for i=1:2^ii %wpcoef(wpt1,[n,i-1])是求第n层第i个节点的系数
E(i)=norm(wpcoef(T,[ii,i-1]),2);%求第i个节点的范数平方，其实也就是平方和

end
sample(samplerow,samplecol)=max(E);
samplecol=samplecol+1;
end

end
samplerow=samplerow+1;
samplecol=1;
end

model_linear = svmtrain(train_group2nd, traindata2nd, '-t 0');% -t 0 是线性核的参数
[classifyresult, accuracy] = svmpredict(sample_group, sample, model_linear);
 
       correct_rate =  accuracy(1,1)/100;
       correctrate_gather = [correctrate_gather,correct_rate];%v次准确率放在这里
       classifyresult_gather = [classifyresult_gather,classifyresult];%v次测试结果,classifyresult是列向量
       sample_gather = [sample_gather,sample];
       sample_group_gather = [sample_group_gather,sample_group];
end

[C,I] = max(correctrate_gather);
contrastmatrix=[sample_group_gather(:,I), classifyresult_gather(:,I)];
[row,col,V]=find(contrastmatrix(:,1) ~= contrastmatrix(:,2));%找出分类错的位置
train_groupupdatepart = sample_group_gather(:,I);
traindata_updatepart = sample_gather(:,(I-1)*6+1:I*6);   %原来每个sample是n x 6矩阵
traindata_updatepart(row,:)=[];%删掉分类错误的标签和数据
train_groupupdatepart(row,:)=[];

traindata2nd=[traindata2nd;traindata_updatepart];%将分类正确的加入训练集 扩大训练集规模
train_group2nd=[train_group2nd;train_groupupdatepart];