clc
close all;
clear;

% SELECTING THE TEST DATA
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[file,path]=uigetfile({'*.jpg;*.bmp;*.png;*.tif'},'Choose an image');
s=[path,file];
picture=imread(s);
figure;
subplot(1,2,1);
imshow(picture);
picture=imresize(picture,[300 500]);
subplot(1,2,2);
imshow(picture);

%RGB2GRAY
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
picture=mygrayfun(picture);
figure;
subplot(1,3,1);
imshow(picture);


% THRESHOLDIG and CONVERSION TO A BINARY IMAGE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
threshold = 100; % Example threshold value
picture = mybinaryfun(picture,threshold);
picture=~picture;
subplot(1,3,2);
imshow(picture);


% Removing the small objects and background
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
threshold = 300;
cleanedImage = myremovecom(~picture, threshold);
subplot(1,3,3);
imshow(cleanedImage);

% Segmentation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Labeling connected components
[L, Ne] = mysegmentation(cleanedImage);
propied = regionprops(L, 'BoundingBox');
hold on
for n = 1:size(propied, 1)
    rectangle('Position', propied(n).BoundingBox, 'EdgeColor', 'g', 'LineWidth', 2)
end
hold off


% Decision Making
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Loading the mapset
load TRAININGSET;
totalLetters=size(TRAIN,2);

figure
final_output=[];
for n=1:Ne
    
    [r,c]=find(L==n);
    Y=cleanedImage(min(r):max(r),min(c):max(c));
    imshow(Y)
    Y=imresize(Y,[42,24]);
    imshow(Y)
    pause(0.2)
    
   
    ro=zeros(1,totalLetters);
    for k=1:totalLetters   
        ro(k)=corr2(TRAIN{1,k},Y);
    end

    [MAXRO,pos]=max(ro);
    if MAXRO>.45
        out=TRAIN{2,pos};       
        final_output=[final_output out];
    end
end

% Writing the final output to a text file
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
file = fopen('number_Plate.txt', 'wt');
fprintf(file,'%s\n',final_output);
fclose(file);
