clear; close all;
%%��д��ͼ��·��
path_to_db = 'F:\dataset\3_28\smalltemp';
db_name = 'handwriting';
%%��д�������洢·��
% savepath = 'D:\2_26\��д��\roto_trans_scatt_log_scale_avg.mat'
%%ѵ��
%ѵ������ÿ���е�ͼƬ��
train_length=10;
modelfile='modelfile';

model=train_writers(path_to_db,train_length,modelfile);
%��Ҫ���Եıʼ��ı�ͼƬ
testimg='F:\dataset\3_28\smalltemp\2\g0201.0.0.jpg';
%Ԥ����д�� 
person=test_writer(modelfile,train_length,testimg);
%% classification
%% assure the person who to write
% rsds_classif(db, db_name, feature_name, grid_train, nb_split);

