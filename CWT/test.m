im=imread('peppers.png');
x=double(im);
nlevs=[2,3];
dfilt='pkva';
pfilt='pkva';
y1 = wdfbdec(x, pfilt,dfilt, nlevs)
% [xlod, xLH,xHL,xHH] = dwt2(x, 'db1');
% xhi_dir = dfbdec_l(xLH, dfilt,2)
% %  [h, g] = pfilters(pfilt);
%  [xlop, xhi] = lpdec(x, h, g);
% y = pdfbdec(x, pfilt, dfilt, nlevs)
% y=wdfbdec(x, dfilt, nlevs);
% y = pdfbdec(x, pfilt, dfilt, nlevs)