tic;
%pdata_path='D:\zhubeibei\practiceimagebase';
classnum=50;
%�챴���Ŀ�
%pdata_path='C:\Program Files\MATLAB\R2012b\bin\workplace\zbb\practiceimagebase';
%tdata_path='C:\Program Files\MATLAB\R2012b\bin\workplace\zbb\testimagebase';
%pdata_path='D:\picturelibrary\handwriting\practiceimagebase';%cut��
%tdata_path='D:\picturelibrary\handwriting\testimagebase';%cut��
%Ԥ����⣨�ܺ��Ŀ⣩
%pdata_path='D:\picturelibrary\caohai\practiceimagebase';%cut��
%tdata_path='D:\picturelibrary\caohai\testimagebase';%cut��
%�ܺ������
%pdata_path='D:\picturelibrary\caohai\writing\writing\���\practiceimagebase';%cut��
%tdata_path='D:\picturelibrary\caohai\writing\writing\���\testimagebase';%cut��
%�ܺ�������
pdata_path='G:\writing\fixed\����\zbbs\mat\practiceimagebase';%cut��
tdata_path='G:\writing\fixed\����\zbbs\mat\testimagebase';%cut��
%�ܺ����ض�
%pdata_path='D:\picturelibrary\caohai\writing\writing\�ض�\seprate\practiceimagebase';%cut��
%tdata_path='D:\picturelibrary\caohai\writing\writing\�ض�\seprate\testimagebase';%cut��

%��ȡѵ��������������
FeatureTrainMatrix=[];

for classid=1:classnum
    
    if(classid<10)
        class_name=strcat(pdata_path,'\g0',num2str(classid));
        ClassFeatureMatrix=GainTrainImageFeature(class_name);
    else
        class_name=strcat(pdata_path,'\g',num2str(classid));
        ClassFeatureMatrix=GainTrainImageFeature(class_name);
    end 
    FeatureTrainMatrix=[FeatureTrainMatrix,ClassFeatureMatrix];
end

%tdata_path='D:\zhubeibei\testimagebase';

%��ȡ�����������е�ͼ������
FeatureMatrix=[];

for classid=1:classnum
    if(classid<10)
        class_name=strcat(tdata_path,'\g0',num2str(classid));
        ClassFeatureMatrix=GainImageFeatureArr(class_name,classid);
    else
        class_name=strcat(tdata_path,'\g',num2str(classid));
        ClassFeatureMatrix=GainImageFeatureArr(class_name,classid);
    end 
    FeatureMatrix=[FeatureMatrix;ClassFeatureMatrix];
end

%%subband KL distance array
subimagenum=classnum*20;

for i=1:classnum
    for j=1:subimagenum     
        KLMarrtrix(i,j).kld=sub_kld_measure(FeatureTrainMatrix(:,i),FeatureMatrix(j,1).featurevocter);
        KLMarrtrix(i,j).cid=FeatureMatrix(j,1).classid;
    end
end

%normal the subband kl distance array
NorKLMarrtrix=normal_subkld_marrtrix(KLMarrtrix);

%%statetic the all sub kl distance 
[m,n]=size(NorKLMarrtrix);
[msize,nsize]=size(NorKLMarrtrix(1,1).kld);
for i=1:m
    for j=1:n
        KLDArray(i,j).kld=0;
        KLDArray(i,j).classid=0;
    end
end

for i=1:m
    for j=1:n
        for k=1:nsize
             KLDArray(i,j).kld=KLDArray(i,j).kld+NorKLMarrtrix(i,j).kld(k);
        end
        KLDArray(i,j).classid=NorKLMarrtrix(i,j).cid;
    end
end

%%sort the the kl distance between two images
SortingResult=sort_KLDvalue(KLDArray);

%%compute the average retrieval rate
[AverRetrievalRate1,RR1]=Gain_AverageRetrievalRate(SortingResult)
toc;
