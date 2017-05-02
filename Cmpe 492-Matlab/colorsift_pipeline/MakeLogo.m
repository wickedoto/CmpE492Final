clear ; close all; clc

load annotation

IMAGE_FULL_PATH = '~/Documents/MATLAB/colorsift/output-squared';
OUTPUT_FULL_PATH = '~/Documents/MATLAB/colorsift/output-squared';
DATA_SET_SIZE = 1199;
IMAGE_EXTENSION = '.jpg';

for i = 1:DATA_SET_SIZE
    file_name = strcat(annotation(i,1), '.jpg'); 
    
    full_path = fullfile(IMAGE_FULL_PATH, file_name);
    fullPaths{i} =  full_path{1};
    
%     output_full_path = fullfile(OUTPUT_FULL_PATH, file_name);
%     
%     I = fullPaths{i};
%     img = imread(I);
%     img_resized = imresize(img, [64 64]);
%     imwrite(img_resized,output_full_path{1});
end



k = 0;
l = 0;
for i = 1:DATA_SET_SIZE
    file_name = strcat(annotation(i,1), '.jpg'); 
    full_path = fullfile(IMAGE_FULL_PATH, file_name);
    if annotation_numerical(i,1) == 0
        k = k + 1;
        l = 0;
        imagePaths{k} =  full_path{1};
    else
        l = l + 1;
        imagePaths{(144*l)+k} = full_path{1};
    end
    
    imagePaths{3312} = 'output-squared/black.jpg';
end


for i = 1:3312
    if isempty(imagePaths{i})
        imagePaths{i} = 'output-squared/black.jpg';
    end
end

montage(imagePaths, 'Size', [23 144]);
    
