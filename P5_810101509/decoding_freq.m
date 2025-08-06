function DcodedMessageBin=decoding_freq(y,speed)
    s=zeros(length(y)/100,100);
    for r=1:(length(y)/100)
        for g=1:100
            s(r,g)=y((100*r-100)+g);
        end
    end
    len=length(s(:,1));
    index=zeros(1,len);
    for g=1:len
        y2=fftshift(fft(s(g,:)));
        out=y2/max(abs(y2));
        out=abs(out);
        positive=out(51:100);
        [~,I]=max(positive);
        index(g)=I-1;
    end
    frequency=cell(1,5);
    frequency{1,1}=[12,37];
    frequency{1,2}=[5,16,27,38];
    frequency{1,3}=[4,10,16,22,28,34,40,46];
    frequency{1,4}=[2,5,8,11,14,17,20,23,26,29,32,35,38,41,44,47];
    frequency{1,5}=[1,2,4,5,7,8,10,11,13,14,16,17,19,20,22,23,25,26,...
        28,29,31,32,34,35,37,38,40,41,43,44,46,47];
    string=[];
    co=cell2mat(frequency(speed));
    thre=zeros(1,length(co)+1);
    thre(1)=(0+co(1)/2);
    for v=1:length(co)-1
        thre(v+1)=(co(v)+co(v+1))/2;
    end
    thre(end)=(co(end)+49)/2;
    for r=1:len 
            for k=1:length(thre)-1
                if index(r)>thre(k) && index(r)<thre(k+1)
                    z=k;
                    break
                end
            end
            bin=dec2bin(z-1,speed);
            string=[string bin];
    end
    DcodedMessageBin=[]; 
    ind=1;
    Alphabet ='abcdefghijklmnopqrstuvwxyz ,;?.!';
    for p=(1:length(string)/5)
        characterbin=zeros(1,5);
        for cont=1:5
            vals=string(ind);
            vals1=dec2bin(vals);
            characterbin(cont)=str2double(vals1(end));
            ind=ind+1;        
        end
        num=sum(characterbin.*(2.^(4:-1:0)))+1;
        DcodedMessageBin=[DcodedMessageBin Alphabet(num)];
end