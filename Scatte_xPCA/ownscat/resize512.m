clc
clear
cd('D:\cyi\scatnet-0.2\ͼ���\512��д��ͼ���');
files = dir();
sz = size(files,1);
savepath = 'C:\Users\ch\Desktop\tmp\'
for i=3:sz 
    
    
    dirname=['C:\Users\ch\Desktop\tmp\' files(i).name];%�µ��ļ�����
    a=['mkdir ' dirname];%��������
    system(a) %�����ļ���
    
   
        insides = dir(files(i).name);
        in_sz = size(insides);
        
           
            
        for j=3:in_sz
            name = insides(j).name;
            image = imread(name);
            spath = strcat(savepath,files(i).name,'\',name);
            imwrite(image,spath);
            
            image1 = imresize(image,[128 128]);
            name(7) = '0';
            newname1 = name;
            spath = strcat(savepath,files(i).name,'\',newname1);
            imwrite(image1,spath);
            
            image2 = imresize(image,[256 256]);
            name(7) = '1';
            newname2 = name;
            spath = strcat(savepath,files(i).name,'\',newname2);
            imwrite(image2,spath);
              
        end
end
