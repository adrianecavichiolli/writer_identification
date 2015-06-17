%close all
im=imread('D46.gif');
x=double(im);
pfilt='9-7';
[h, g] = pfilters(pfilt);
for level=1:3
[xlo,xhi]=lpdec(x, h, g);
yhi{level}=xhi;
figure,imshow(xhi,[]);
x=xlo;
end
ylo=xlo
figure,imshow(xlo,[]);
y=[yhi,ylo]
%仅进行Contourlet中的LP分解