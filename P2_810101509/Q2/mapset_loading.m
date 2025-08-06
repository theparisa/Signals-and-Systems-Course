clc;           
clear;        
close all;  
files=dir('Farsi_mapset');
len=length(files)-2;
TRAIN=cell(2,len);

for i=1:len
   img = imread([files(i+2).folder,'\',files(i+2).name]);
   TRAIN{1,i}=imresize(img, [42, 24]); % Resize images in training set to 42x24
   TRAIN{2,i}=files(i+2).name(1);
end

save TRAININGSET TRAIN;
