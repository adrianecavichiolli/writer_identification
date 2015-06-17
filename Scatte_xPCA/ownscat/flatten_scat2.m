function Y = flatten_scat2(X,M)
	Y.signal = {};
	Y.meta = struct();
	
	Y.meta.order = [];
	
	meta_fields = fieldnames(X{end}.meta);
	
	
	r = 1;
	for m = M:length(X)-1
		ind = r:r+length(X{m+1}.signal)-1;
		
		Y.signal(ind) = X{m+1}.signal;
		
		for p = 1:length(meta_fields)
			field = meta_fields{p};
			
			if isfield(Y.meta,field)
				value = getfield(Y.meta,field);
			else
				value = [];
			end
			
			if isfield(X{m+1}.meta,field) % : handle the case where 
				% different layer have different
				new_value = getfield(X{m+1}.meta,field);
			else
				new_value = [];
			end
			
			if size(value,1) < size(new_value,1)
				value = [value; ...
					-ones(size(new_value,1)-size(value,1),size(value,2))];
			elseif size(value,1) > size(new_value,1)
				new_value = [new_value; ...
					-ones(size(value,1)-size(new_value,1),size(new_value,2))];
			end
			
			value = [value new_value];
			
			Y.meta = setfield(Y.meta,field,value);
		end
		
		Y.meta.order = [Y.meta.order m*ones(1,length(ind))];
		
		r = r+length(ind);
	end
	
	Y = {Y};
end