% Initial settings
IMAGE_FULL_PATH = '~/Documents/MATLAB/colorsift/All-resized';
OUTPUT_FULL_PATH = '~/Documents/MATLAB/colorsift/output-saliency-cropped';
SALIENCY_FULL_PATH = '~/Documents/MATLAB/colorsift/output_saliency';
IMAGE_EXTENSION = '.jpg';
SALIENCY_EXTENSION = '.png';
DATA_SET_SIZE = 1199;

% Load annotation data from prepared mat file
load annotation

%BMS('All-resized/','output_saliency/',true); % for salient object detection

%Create cell array to store full paths
fullPaths = cell(DATA_SET_SIZE, 1);
saliencyPaths = cell(DATA_SET_SIZE, 1);
for i = 1:DATA_SET_SIZE
    file_name = strcat(annotation(i,1), '.jpg'); 
    saliency_file_name = strcat(annotation(i,1), '.png'); 
    
    full_path = fullfile(IMAGE_FULL_PATH, file_name);
    fullPaths{i} =  full_path{1};
    
    saliency_path = fullfile(SALIENCY_FULL_PATH, saliency_file_name);
    saliencyPaths{i} =  saliency_path{1};
    
    output_full_path = fullfile(OUTPUT_FULL_PATH, file_name);
    
    
    image = full_path{1};
    saliency = saliency_path{1};
    I = imread(image);

    Map = imread(saliency);
    bw = double(Map>10); 
    bw = repmat(bw, [1, 1, 3]);
    img_out = I;
    img_out(~bw) = 0;

    imwrite(img_out,output_full_path{1});
    
end
