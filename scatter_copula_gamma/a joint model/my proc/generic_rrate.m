function rr = generic_rrate(D,ns,method)
    nimages = size(D,1);
    ii = 1:nimages;
    for q=1:nimages
        [sd,si] = sort(D(q,:),method);
        r(si) = ii;%%ͼƬ����Ӧ��λ�����飬���λ������KL������������򣬾���ԽС��λ��Խǰ��siΪͼƬ������λ�ã�ii�������r����������λ�� 
        c = floor((q-1) / ns);%%%% floor����ȡ�����������
        rr(:, q) = r((c*ns+1):((c+1)*ns))';%% rrǰ16�У�ȡr��ǰ16������rr��16�У�ȡr�ĺ�16����
    end
end
        
