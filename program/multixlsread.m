

filename1=ls('C:\Users\W\Desktop\EMG data\*.xls');%取得所用excel文件
filename=cellstr(filename1);
num=length(filename);%得到excel文件的个数n
segment=10;%每个长信号截segment段作为新信号
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
% getfilename=ls('C:\Users\W\Desktop\EMG data\*.xl*');  %取目录下所有excel文件的文件名(.xls或.xlsx)
% filename = cellstr(getfilename);                                      %将字符型数组转换为cell型数组
% num_of_files = length(filename);                                    %excel文件数目
% for i=1:num_of_files                                                  %循环读入excel数据并存入结构体database中
%     database(i) = struct('Name',filename(i),'Data',xlsread(filename{i}));
% end