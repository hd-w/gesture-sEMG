

filename1=ls('C:\Users\W\Desktop\EMG data\*.xls');%ȡ������excel�ļ�
filename=cellstr(filename1);
num=length(filename);%�õ�excel�ļ��ĸ���n
segment=10;%ÿ�����źŽ�segment����Ϊ���ź�
M=[];raw=[];train_group=ones(num*segment,1);
n=499;
iii=1;
for ii=1:num
    i=1;
raw=xlsread(['C:\Users\W\Desktop\EMG data\',filename{ii}],1,'C50:D5600');
for j=1:segment
M=[M,raw(i:i+n,1:2)];
i=i+n+50;
end
train_group(iii:iii+segment-1,1) = str2num(filename1(ii));
iii = iii+segment;
end

% clear;
% clc;
% getfilename=ls('C:\Users\W\Desktop\EMG data\*.xl*');  %ȡĿ¼������excel�ļ����ļ���(.xls��.xlsx)
% filename = cellstr(getfilename);                                      %���ַ�������ת��Ϊcell������
% num_of_files = length(filename);                                    %excel�ļ���Ŀ
% for i=1:num_of_files                                                  %ѭ������excel���ݲ�����ṹ��database��
%     database(i) = struct('Name',filename(i),'Data',xlsread(filename{i}));
% end