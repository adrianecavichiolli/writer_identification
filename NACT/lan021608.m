%close all
im=imread('D46.gif');
x=double(im);
smooth_func = @rcos;
Pyr_mode = 2; %��һ��LP�ֽ��²�������
L=3;
y = PyrNDDec_mm(x, 'S', L, Pyr_mode, smooth_func)
for i=L+1:-1:1
    figure,imshow(y{i},[])
end
%�����п����Contourlet�е�LP�ֽ�