
function [I_gradx,I_grady,I] = comput_gradient(input_image)

I = double(input_image);
% Imax = max(max(I));
% Imin = min(min(I));
% I = (I-Imin)./(Imax-Imin); % ��һ����[0,1]

[I_gradx,I_grady] = gradient(I); % x,y�����ݶ�ͼ

I = sqrt((I_gradx).^2 + (I_grady).^2); % �ݶȷ�ֵͼ

% figure
% imshow(I,[])

