function ro = innerProduct(a,b)
    
    len=length(a);
    ro=0;
    for i=1:len
        ro=ro+a(i)*b(i);
    end
