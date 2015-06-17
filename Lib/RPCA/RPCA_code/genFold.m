
function [traindata,testdata,gnd,tgnd] = genFold(dataset,label,idx,expopt)

% dataset  ���ݾ�������ά������������
% label    ����ǩ�����磺label = [1,1,1,1,2,2,2,2,3,3,3,3......]
% idx      ÿһ������ѵ�����������
% idy      ÿһ�����ڲ��Ե��������
% expopt   �ṹ�壬expopt.nClass ����� ��expopt.nFace ÿһ���������

nClass = expopt.nClass; % �����
nFace = expopt.nFace; % ÿһ���������
% nTrain = expopt.nTrain;
nTrain = size(idx,2); % ÿһ���ѵ��������
nTest = nFace - nTrain; % ÿһ��Ĳ���������

idy = [1:nFace];
for i = 1:nTrain
    [ix] = find(idy(:) == idx(i));
    idy(ix) = [];  
end

traindata = [];
testdata = [];
gnd = [];
tgnd = [];

for i = 1:nClass
    for j = 1:nTrain
        traindata = [traindata dataset(:,(i-1)*nFace+idx(j))];
        gnd = [gnd;label((i-1)*nFace + idx(j))];
    end
    
    for j = 1:nTest
        testdata = [testdata dataset(:,(i-1)*nFace+idy(j))];
        tgnd = [tgnd;label((i-1)*nFace + idy(j))];
    end
end

