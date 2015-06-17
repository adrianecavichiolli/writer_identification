%% TR_CWTcoef_main.m
% MATLAB code for the article
%  TITLE = ��A Joint Model of Complex Wavelet Coefficients for Texture Retrieval��
% AUTHOR = {Roland Kwitt and Andreas Uhl},
%	DATE = {nov,2009},
% BOOKTITLE = {Proceedings of the IEEE International Conference on Image Processing, ICIP '09},

% ��ͼ�ķָ�
% TR_CWTcoef_splitting.m
tic
% clear all
clc
clear
cd('G:\scattering+gamma\scattering+gamma\a joint model\my proc');
addpath(genpath(pwd));
  
% ��ͼ���ݵ���
% %%%%%%% ͼ��ָ�Ϊ16����ͼ
% splittingimgs_path = 'H:\scattering\Brodatz�ָ�\';
% data = texload('Brodatz',splittingimgs_path ,16,1,2);


%%%%%%% ͼ��ָ�Ϊ64����ͼ
Jmax=7;  %%%%%%%%%%%%%%% ÿ�μǵ��޸�sizeb
maxclasses=2;
% data=brodatz_data(Jmax,maxclasses);
number=6;
[data,filenames] = retrieve_writing_Ltrain(number,maxclasses);
icip09(data,filenames,'stage','genmodel','copula','Gaussian','samples',100,'debug',true);   
