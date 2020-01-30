%% KNN
clear all
clc
%% data
trainData = [1.0,2.0;1.2,0.1;0.1,1.4;0.3,3.5;0.2,2.7];
trainClass = [2,1,1,1,2];
testData = [0.5,2.3];
k = 5;

%% distance
row = size(trainData,1);
col = size(trainData,2);
test = repmat(testData,row,1);
dis = zeros(1,row);
for i = 1:row
    diff = 0;
    for j = 1:col
        diff = diff + (test(i,j) - trainData(i,j)).^2;
    end
    dis(1,i) = diff.^0.5;
end

%% sort
jointDis = [dis;trainClass];
sortDis= sortrows(jointDis');
sortDisClass = sortDis';

%% find
% class = sort(2:1:k);
% member = unique(class);
% num = size(member);

% max = 0;
label1 = 0;
label2 = 0;
for i=1:k
class = sortDisClass(2,i);
if class == 2
    label2 = label2 + 1;
else if class == 1
    label1 = label1 + 1;
    end
end
end
label = max(label1,label2);
if label == label1
    result = 1;
else result = 2;
end


disp('最终的分类结果为：');
fprintf('%d\n',result)