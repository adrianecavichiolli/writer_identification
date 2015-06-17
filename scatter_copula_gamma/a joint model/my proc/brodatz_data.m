function  out=brodatz_data(Jmax,maxclasses)

if nargin < 2
maxclasses = 120;
end

if Jmax == 7
		maxinners = 16;
elseif Jmax == 8
		maxinners = 4;
elseif Jmax==6
    maxinners=64;
else
	error('not supported \n');
end

%%%%%
sizeb=160
cd('E:\ɢ������\scattering\Brodatz');

filelist = dir();
it=1;
for d=3:min(2+maxclasses,size(filelist,1))
	if filelist(d).isdir ~=true
		fname = filelist(d).name;
		if strcmp( fname(size(fname,2)-3:size(fname,2)) ,'.jpg' ) == 1 || strcmp( fname(size(fname,2)-3:size(fname,2)) ,'.gif' ) == 1
		fprintf('processing image %s  read %d subimages \n',fname,maxinners);
		tempo = double(imread(fname));
		%tempo = double(rgb2gray(tempo));
		%tempo = tempo - mean(tempo(:));
		%tempo = tempo / norm(tempo(:));
% 			innerit=1;
            k=1;
			for tx=1:2^(9-Jmax)
					for ty=1:2^(9-Jmax)
						slice{k} =(tempo(1+sizeb*(tx-1):sizeb*tx,1+sizeb*(ty-1):sizeb*ty));
						%normalize to zero mean and unit variance
						slice{k} = slice{k} - mean(slice{k}(:));
						slice{k} = slice{k} / norm(slice{k}(:));
                        k=k+1;
%                         if innerit <= maxinners
% 							out{it}{innerit} = slice;
%                          end
% 						innerit = innerit + 1;
					end
            end
             rd=rand(1,maxinners);
            [res,order]=sort(rd);
%             pos_train=find(order<=maxinners/2);
%             sz_trian=size(pos_train,2);
             for i=1:size(order,2)
                 out{it}{i}=slice{order(i)};        
             end
    
			it=it+1;
		end
	end
end