clear ; close all; clc

% Initial settings
IMAGE_FULL_PATH = '~/Documents/MATLAB/colorsift/All-resized';
IMAGE_ORIGINALS_PATH = '~/Documents/MATLAB/colorsift/Originals';
IMAGE_EXTENSION = '.jpg';
DATA_SET_SIZE = 1199;
% Load annotation data from prepared mat file
load annotation

for i = 1:DATA_SET_SIZE
    file_name = strcat(annotation(i,1), '.jpg'); 
    if annotation_numerical(i,1) == 0
        disp(file_name)
        full_path = fullfile(IMAGE_FULL_PATH, file_name);
        full_path_original = fullfile(IMAGE_ORIGINALS_PATH, file_name);
        copyfile(full_path{1}, full_path_original{1})
    end
end