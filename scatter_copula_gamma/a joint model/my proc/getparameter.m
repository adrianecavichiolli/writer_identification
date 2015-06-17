function varargout = getparameter(data,filenames,varargin)
    p = inputParser;   % inputParser:Construct input parser object �����������������
    % p: �������빹������(inputParser)��������һ��ʵ��(instance),����Ի����(object)����һ���յ��������������
    % Ŀ�ģ����Դ�ȡ/����(access)��������з��������ԣ�����������֤�������������
    p.addRequired('data',@iscell); % returns logical 1 (true)if data is a cell array 
    % p.addRequired('filenames',@iscell);
    % p.addRequired(argname, validator) argname:����Ĳ���   validator����֤����matlab������֤��ʱ��ʹ�õľ����
    % ���ã�Ϊ����������p����һ��"required argument" 
    % If the validator function returns false or errors,the parsing fails and MATLAB throws an error. 
    % MATLAB parses  required arguments before optional or parameter-value arguments.
    % MATLAB parses  parameter-value arguments after required arguments and optional arguments.
    
    % model = icip09(data,'stage','genmodel','debug',true)
    p.addParamValue('models',{},@iscell); 
    % Add parameter-value pair argument to inputParser schema
    p.addParamValue('stage','genmodel',@(x)any(strcmpi(x,{'genmodel','runsim'}))); % strcmpi�ȽϽ����ͬ��1��any��ȫ0��1�������֤��Ϊ����ͨ����֤�������׳�����
                                                                                   % Ĭ��ѡ�genmodel����x�����������Ҫ�ͺ����ѡ�����ƥ��
    % p.addParamValue('margin', 'Weibull', @(x)any(strcmpi(x,{'Weibull','Gamma'})));
    p.addParamValue('margin', 'Gamma', @(x)any(strcmpi(x,{'Weibull','Gamma'})));
    p.addParamValue('copula', 'Gaussian', @(x)any(strcmpi(x,{'Gaussian','t'})));
    p.addParamValue('level',3,@(x)x>=1);
    p.addParamValue('samples',100,@(x)x>=100);
    p.addParamValue('debug',false,@islogical);
   
    p.parse(data,varargin{:});
    p.parse(filenames,varargin{:});
    %%p.parse(filenames,varargin{:});
    
    debug = p.Results.debug;
    models = p.Results.models;
    level = p.Results.level;
    samples = p.Results.samples;
    stage = p.Results.stage;
    margintype = p.Results.margin
    copulatype = p.Results.copula;

    progname ='icip09';
    options=struct;
    options.J=level;
    options.M=2;
    options.Q=1;
    M=getoptions(options,'M',2);

    if (debug)
        fprintf('[%s]: running %s for %s margins and %s copula (level %d)\n', ...
            progname, stage, margintype, copulatype, level);
    end
    switch stage                 % ����
        case 'genmodel'          % ����ģ��
            if (~isempty(models))
                error('model parameter given although stage is genmodel');
            end
            k=1;%%%%%%% k=i*j,��¼����ͼ������
            length1=size(filenames,2)
            for i=1:size(filenames,2)
                
                for j=1:size(filenames{i},2)
                        %%in=double(data{i}{j});
                        filename=filenames{i}{j};
                        %%X=ownscat(filename,options);
                        X=newscat(filename,options);
                        %%X=double(X);
                        %%fun = @(Sx)(mean(mean((remove_margin(format_scat(Sx),1)),2),3));
                        %%X=fun(X_all);
                        %%X=double(X);
                    %%  X=scatt_copula(in,options);
     %                         if k==3
     %                             k;
     %                              model{k} = ctbfit(abs(X{M+1}),'margin', margintype, 'copula',copulatype,'debug',debug); 
     %                         end
     %                        
            %            X = abs(scatt(in,options));
            %            X = ctbgen(data{i}{j},'margin',margintype,...
            %            'levels',level,'debug',debug);%%��ɫcopula
               %%      model{k} = ctbfit(abs(X{M}),'margin', margintype, 'copula',copulatype,'debug',debug); 
                     varmodel{k} = ctbfit(abs(X{M+1}),'margin', margintype, 'copula',copulatype,'debug',debug); 
                     clear X;
                     clear in;
                   k=k+1;
                end
                
            end

            varargout(1) = {varmodel};             % ��������ĸ������䳤��
    end
end