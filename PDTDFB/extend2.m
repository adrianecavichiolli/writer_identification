function y = extend2(x, ru, rd, cl, cr, extmod, symopt)
% EXTEND2   2D extension
%
%	y = extend2(x, ru, rd, cl, cr, extmod)
%
% Input:
%	x:	input image
%	ru, rd:	amount of extension, up and down, for rows
%	cl, cr:	amount of extension, left and rigth, for column
%	extmod:	extension mode.  The valid modes are:
%       'sym':		symmetric extension (both direction)
%		'per':		periodized extension (both direction)
%		'qper_row':	quincunx periodized extension in row
%		'qper_col':	quincunx periodized extension in column
%   sympopt : optional argument for symmetric extension, affect the center 
%   of symmetry at the four borders of matrix 
%   0 : the border is repeated, 
%   1 : the border is not repeated, the second row (column) is repeated
%   default [1,1,1,1]
%
% Output:
%	y:	extended image
%
% Note:
%	Extension modes 'qper_row' and 'qper_col' are used multilevel
%	quincunx filter banks, assuming the original image is periodic in 
%	both directions.  For example:
%		[y0, y1] = fbdec(x, h0, h1, 'q', '1r', 'per');
%		[y00, y01] = fbdec(y0, h0, h1, 'q', '2c', 'qper_col');
%		[y10, y11] = fbdec(y1, h0, h1, 'q', '2c', 'qper_col'); 
%		
% See also:	FBDEC

if ~exist('symopt','var')
    symopt = [1,1,1,1];
end

[rx, cx] = size(x);
    
switch extmod
    case 'sym'
        y = [x;];
        y = [x(ru+symopt(1):-1:1+symopt(1),cl+symopt(3):-1:1+symopt(3)),...
            x(ru+symopt(1):-1:1+symopt(1),:),...
            x(ru+symopt(1):-1:1+symopt(1),cx-symopt(4):-1:(cx-cr-symopt(4)+ 1));...
            x(:,cl+symopt(3):-1:1+symopt(3)), ...
            x, ...
            x(:,cx-symopt(4):-1:(cx-cr-symopt(4)+ 1 )); ...
            x(rx-symopt(2):-1:(rx-rd-symopt(2)+1),cl+symopt(3):-1:1+symopt(3)), ... 
            x(rx-symopt(2):-1:(rx-rd-symopt(2)+1),:), ...
            x(rx-symopt(2):-1:(rx-rd-symopt(2)+1),cx-symopt(4):-1: (cx-cr-symopt(4)+ 1)) ];
    case 'per'
	I = getPerIndices(rx, ru, rd);
	y = x(I, :);
	
	I = getPerIndices(cx, cl, cr);
	y = y(:, I);
	
    case 'qper_row'
	rx2 = round(rx / 2);
		
	y = [[x(rx2+1:rx, cx-cl+1:cx); x(1:rx2, cx-cl+1:cx)], x, ...
	     [x(rx2+1:rx, 1:cr); x(1:rx2, 1:cr)]];
	
	I = getPerIndices(rx, ru, rd);
	y = y(I, :);	
	
    case 'qper_col'
	cx2 = round(cx / 2);
	
	y = [x(rx-ru+1:rx, cx2+1:cx), x(rx-ru+1:rx, 1:cx2); x; ...
	     x(1:rd, cx2+1:cx), x(1:rd, 1:cx2)];
	
	I = getPerIndices(cx, cl, cr);
	y = y(:, I);
	
    otherwise
	error('Invalid input for EXTMOD')
end	

%----------------------------------------------------------------------------%
% Internal Function(s)
%----------------------------------------------------------------------------%
function I = getPerIndices(lx, lb, le)

I = [lx-lb+1:lx , 1:lx , 1:le];

if (lx < lb) || (lx < le)
    I = mod(I, lx);
    I(I==0) = lx;
end