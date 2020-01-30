%% 统计输入数据的维数，将这个维数保存在一个矩阵之中,对数据进行eemd分解，并画图
%data为输入的信号
function ploteemd(data)
M= length(data);%%如果只有一列则不须要求数据维数

%% 对矩阵的每一列进行EMD变换，将变换后的结果赋给一个大型三维矩阵

IMF=eemd(data,0.2,10);%%一列数据进行计算，0，1是emd运算，通常

%% 将三维矩阵的维数保存起来
[k,y]=size(IMF);

%% 绘制将每一列样本分解得出的IMF绘制在一张图中
%% plot画矩阵的列,故有y个图，其中第一列为原始信号,这里只画10列信号，1列为原始信号，2-9为1-8的imf分量，10为余量
clf
subplot(10,1,1);
 plot(IMF(:,1));
 ylabel('原始信号')
for i=2:9
 subplot(10,1,i);
 plot(IMF(:,i));
 biaoqian=['imf',num2str(i-1)];%建立标签imf(i-1)
 ylabel(biaoqian)
end
subplot(10,1,10);
 plot(IMF(:,10));
 ylabel('RES')
xlabel('采样数')

