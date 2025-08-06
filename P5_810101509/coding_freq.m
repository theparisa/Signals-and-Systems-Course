function [y,x_axis]=coding_freq(message,speed)
fs=100;
mapset= generateMapset;
message_len=length(message);
message_bin=cell(1,message_len);
for i=1:message_len
    ch=message(i);
    for j=1:32
        if ch==mapset{1,j}
            message_bin{i}=mapset{2,j};
        end
    end
end
binarymessage=cell2mat(message_bin);
binarymessage_len=length(binarymessage);
frequency=cell(1,5);
frequency{1,1}=[12,37];
frequency{1,2}=[5,16,27,38];
frequency{1,3}=[4,10,16,22,28,34,40,46];
frequency{1,4}=[2,5,8,11,14,17,20,23,26,29,32,35,38,41,44,47];
frequency{1,5}=[1,2,4,5,7,8,10,11,13,14,16,17,19,20,22,23,25,26,...
    28,29,31,32,34,35,37,38,40,41,43,44,46,47];
y=[];
ts=1/fs;
time=0:ts:(1-ts);
for j=0:(binarymessage_len/speed)-1
    u=[];
    for t=1:speed
        q=(binarymessage((speed*j+1)+t-1));
        u=[u q];
    end
    andis=bin2dec(u)+1;
    x=cell2mat(frequency(speed));
    f=x(andis);
    attach=sin(2*pi*f*time);
    y=[y,attach];
end
x_axis=0:0.01:binarymessage_len/speed-0.01;
end


