function data = ctbgen(image,varargin)
    p = inputParser;
    p.addRequired('image',@(x)~isempty(x));
    p.addParamValue('margin','Weibull',@(x)any(strcmpi(x,{'Weibull','Gamma','Rayleigh','GGD','Cauchy'})));
    p.addParamValue('levels',3,@(x)x>=1 && x <= 5);
    p.addParamValue('debug',false,@islogical);
    p.parse(image,varargin{:});
    type = p.Results.margin;
    levels = p.Results.levels;
    debug = p.Results.debug;
    dim = size(image,3);%%%%  ��ɫͨ��Ϊ3
    progname ='ctbgen';
%     if (debug)
%         fprintf('[%s]: margin = %s, levels = %d\n', progname, type,levels);
%     end

%   data=gabortransform(image,options);

    
    
 
%%%%%%%%%%%%  Ĭ�ϳ���    
for i=1:dim
		plane = double(image(:,:,i));%%%%��ȡÿ��ͨ���߶ȵ�ͼ������
       plane = (plane - mean2(plane)./std2(plane));    
        switch type
            case {'Weibull','Gamma','Rayleigh'}
                [Yl,Yh] = dtwavexfm2(plane,levels,'near_sym_b','qshift_b');
                channels{i}.Yl = Yl;
                channels{i}.Yh = Yh;                
                
            case {'ggd','cauchy'}
                [c,s] = wavedec2(plane,levels,'bior4.4');
                channels{i}.c = c;
                channels{i}.s = s;
        end
end
    
    for l=1:levels%%%%% ÿ���ֽ�㣬6������ÿ������3���߶ȣ���ɫͨ����
        data{l} = [];%%%%�¶���ı�������ǰ����ȡ����data{}��ͬ
        switch type
            case {'Weibull','Gamma','Rayleigh'}
                for or=1:6%%%%%%Yhÿ�����6������ͨ��ͼ,��6������
                    for ch =1:dim %%%��ɫͨ��
                        coef = abs(channels{ch}.Yh{l}(:,:,or));%%% ��ɫͨ��-�ֽ��-������
                        coef = coef(:)+eps;%%%%%% Ϊ������
                        data{l} = [data{l} coef];
                    end
                end
            case {'ggd','cauchy'}
                for ch=1:dim
                    [H,V,D] = detcoef2('all',channels{ch}.c,channels{ch}.s,l);
                    data{l} = [data{l} H(:) V(:) D(:)];
                end
        end
    end
end





