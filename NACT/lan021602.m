close all
im=imread('E:\matlab7\work\lena.png');
x=double(im);
smooth_func = @rcos;
Pyr_mode = 2; %��һ��LP�ֽ��²�������
L=3;
y = PyrNDDec_mm(x, 'S', L, Pyr_mode, smooth_func)
%�����п����Contourlet�е�LP�ֽ�