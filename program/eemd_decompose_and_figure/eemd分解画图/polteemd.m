%% 统计输入数据的维数，将这个维数保存在一个矩阵之中,对数据进行eemd分解，并画图
%data为输入的信号
%分解成n个量fix(log2(data))+1;若信号有1万，则n在10-20之间,在这里只画8个分量，imf为n,则有n+2个图像，另两个为原信号与余量

function polteemd(IMF,n)


%% 绘制将每一列样本分解得出的IMF绘制在一张图中
%% plot画矩阵的列,故有y个图，其中第一列为原始信号,这里只画10列信号，1列为原始信号，2-9为1-8的imf分量，10为余量
clf
subplot((n+2),1,1);
 plot(IMF(:,1))
 ylabel('原始信号')
for i=2:(n+1)
 subplot((n+2),1,i);
 plot(IMF(:,i))
 biaoqian=['IMF',num2str(i-1)];%建立标签imf(i-1)
 ylabel(biaoqian)
end
subplot((n+2),1,(n+2));
 plot(IMF(:,(n+2)))
 ylabel('RES')


