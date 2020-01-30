
%        gscatter(training(:,1),training(:,2),group);hold on;
 
%        some random sample data
%        sample = unifrnd(-5, 5, 200, 6);
       % classify the sample using the nearest neighbor classification
%        c = knnclassify(sample, traindata, train_group);
%        gscatter(sample(:,1),sample(:,2),c,'mc'); hold on;

%        c3 = knnclassify(sample, traindata, train_group, 7);
%        total = size(sample_group,1);
%        correct=0;
%        for i=1:total
%            if c3(i,1)==sample_group(i,1)
%                correct = correct+1 ;
%            end
%        end
%        correct_rate =  correct/total;
%        gscatter(sample(:,1),sample(:,2),c3,'mc','o');

% contrastmatrix=[sample_group,c3];
% [row,col,V]=find(contrastmatrix(:,1) ~= contrastmatrix(:,2));%找出分类错的位置
% train_groupuadatepart=sample_group;
% traindata_uadatepart=sample;
% traindata_uadatepart(row,:)=[];
% train_groupuadatepart(row,:)=[];
% 
% traindata=[traindata;traindata_uadatepart];%将分类正确的加入训练集 扩大训练集规模
% train_group=[train_group;train_groupuadatepart];

% sl = load('C:\Users\W\Desktop\EMG data\2nddata\train_group2nd.mat');
% names = fieldnames(sl); % 获取mat中所有变量的名字
% train_group2nd = sl.(names{1}); % 取出第一个变量
% sl = load(['C:\Users\W\Desktop\EMG data\2nddata\','traindata2nd.mat']);
% names = fieldnames(sl); % 获取mat中所有变量的名字
% traindata2nd = sl.(names{1}); % 取出第一个变量

%SVM
% load('C:\Users\W\Desktop\EMG data\2nddata\train_group2nd.mat');
% load(['C:\Users\W\Desktop\EMG data\2nddata\','traindata2nd.mat']);
% idx=randperm(400);%1到400随机打乱序列
% label=zeros(400,1);
% ran_label=zeros(400,1);
% ran_data=zeros(400,6);
% for i=1:400
%     ran_label(i,1)=train_group(idx(i),:);
%     ran_data(i,:)=traindata(idx(i),:);
% end
%  % Split Data
%  train_data = ran_data(1:350,:);
%  train_label = ran_label(1:350,:);
%  test_data = ran_data(351:400,:);
%  test_label = ran_label(351:400,:);
%   % Linear Kernel
%  model_linear = svmtrain(train_label, train_data, '-t 0');
%  [predict_label_L, accuracy_L, dec_values_L] = svmpredict(test_label, test_data, model_linear);
%  accuracy_L;

% figure (1);
%  plot(IMF(:,1));hold on;
%  xlabel('时间 (ms)');ylabel('幅值（uV）');title('剔除IMF1前后对比');

%  for i=2:6
%      figure (i);
%      plot (IMF(:,i));
%      xlabel('时间 (ms)');ylabel('幅值（uV）');title(['IMF',num2str(i-1)]);
%  end
% s=zeros(500,1);
% for i=3:9
% s(:,1)=s(:,1)+IMF(:,i,1);
% 
% end
% plot(s,'r');
% fs=1000;N=500;   %采样频率和数据点数
% n=0:N-1;t=n/fs;   %时间序列
% %信号
% y=fft(s,N);    %对信号进行快速Fourier变换
% mag=abs(y);     %求得Fourier变换后的振幅
% f=n*fs/N;    %频率序列
% plot(f,mag);   %绘出随频率变化的振幅
% xlabel('频率/Hz');
% ylabel('振幅');title('N=128');grid on
% a=[0.76,0.73,0.74,0.75,0.72,0.76,0.73,0.74,0.74,0.77];
% plot(1:10,a);title('KNN分类结果')
% set(gca,'xtick',[1:1:10]);
% axis([-inf,inf,0,1]);
% ylabel('准确率');
% xlabel('次数');
sl=load('C:\Users\W\Desktop\EMG data\1stdata\traindata.mat');
names = fieldnames(sl); % 获取mat中所有变量的名字
traindata2nd = sl.(names{1}); % 取出第一个变量

sl=load('C:\Users\W\Desktop\EMG data\1stdata\train_group.mat');
names = fieldnames(sl); 
train_group2nd = sl.(names{1}); 

idx=randperm(400);
label=zeros(400,1);
ran_label=zeros(400,1);
ran_data=zeros(400,6);
for i=1:400
    ran_label(i,1)=train_group2nd(idx(i),:);
    ran_data(i,:)=traindata2nd(idx(i),:);
end
 % Split Data
 train_data = ran_data(1:350,:);
 train_label = ran_label(1:350,:);
 test_data = ran_data(351:400,:);
 test_label = ran_label(351:400,:);
  % Linear Kernel
 model_linear = svmtrain(train_label, train_data, '-t 0');
 [classifyresult, accuracy] = svmpredict(test_label, test_data, model_linear);



