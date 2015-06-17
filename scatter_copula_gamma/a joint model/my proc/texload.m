function data = texload(dbname,dirname,nsubs,texfrom,texto)
% dirname: ��ŷָ�õ���ͼ�ĸ�Ŀ¼��Ҫ��ֱ�Ӷ�ȡ������Bark.0000.01.tif
% 'D:\A Joint Model of Complex Wavelet Coefficients for Texture Retrieval\program\my proc\imgs\'
% dbname�� Ҫ���õĺ��������֣�vistex.m (�����ִ�Сд��case non-sensitive)
% nsubs��ÿ������ͼ�ָ����ͼ��Ŀ
% texfrom,texto�����ζ�ȡ��������򣬶��ٸ�����������:1:40

    data = {};   % �յ�cell
    name = eval(dbname);  % ���ã�function name = VisTex,��40*1��cell
    ntexs = length(name); % ����������������40
    cnt = 1;
    fprintf('loading %d textures\n', (texto-texfrom+1)*nsubs); % Ĭ���������Ļ
    for p = texfrom:texto   
        if p > ntexs
            break
        end
        for q= 1:nsubs   %ÿ��������16�Σ�16����ͼ
             file = sprintf('%s/%s.%02d.gif', dirname, name{p}, q);  
%             file = sprintf('%s/%s.%02d.tif', dirname, name{p}, q);  
            % name{1}:  Bark.0000
            
            data{cnt}.image = imread(file);
            data{cnt}.dim = size(data{cnt}.image,3); % size�����ĵ�����������ά��
            data{cnt}.idx = p;   
            data{cnt}.filename = sprintf('%s.%02d',name{p},q);  % ��ͼ���֣� Bark.0000.01
            cnt = cnt + 1;
        end
    end
    fprintf('read %d images.\n',cnt-1);
    % my add code for storage the result of this file
    % vistex_data = strcat('D:\A Joint Model of Complex Wavelet Coefficients for Texture Retrieval\program\my proc\Data');
    % save(vistex_data,'data');
end

%% �õ��Ľ����data
% data{1}:
%       image: [128x128x3 uint8]
%         dim: 3
%         idx: 1                      ����������
%    filename: 'Bark.0000.01'
