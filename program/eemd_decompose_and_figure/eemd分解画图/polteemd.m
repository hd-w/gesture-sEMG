%% ͳ���������ݵ�ά���������ά��������һ������֮��,�����ݽ���eemd�ֽ⣬����ͼ
%dataΪ������ź�
%�ֽ��n����fix(log2(data))+1;���ź���1����n��10-20֮��,������ֻ��8��������imfΪn,����n+2��ͼ��������Ϊԭ�ź�������

function polteemd(IMF,n)


%% ���ƽ�ÿһ�������ֽ�ó���IMF������һ��ͼ��
%% plot���������,����y��ͼ�����е�һ��Ϊԭʼ�ź�,����ֻ��10���źţ�1��Ϊԭʼ�źţ�2-9Ϊ1-8��imf������10Ϊ����
clf
subplot((n+2),1,1);
 plot(IMF(:,1))
 ylabel('ԭʼ�ź�')
for i=2:(n+1)
 subplot((n+2),1,i);
 plot(IMF(:,i))
 biaoqian=['IMF',num2str(i-1)];%������ǩimf(i-1)
 ylabel(biaoqian)
end
subplot((n+2),1,(n+2));
 plot(IMF(:,(n+2)))
 ylabel('RES')


