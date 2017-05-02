% Ilhan Adiyaman
% 2015700000
% 21.04.2015

clear ; close all; clc

% Initial settings
IMAGE_FULL_PATH = '~/Documents/MATLAB/colorsift/output-saliency-cropped';
SALIENCY_FULL_PATH = '~/Documents/MATLAB/colorsift/output_saliency';
IMAGE_EXTENSION = '.jpg';
SALIENCY_EXTENSION = '.png';
DATA_SET_SIZE = 1199;
tic;
% Load annotation data from prepared mat file
load annotation
% toc;
% BMS('All-resized/','output_saliency/',true); % for salient object detection
% %Create cell array to store full paths
% fullPaths = cell(DATA_SET_SIZE, 1);
% saliencyPaths = cell(DATA_SET_SIZE, 1);
% for i = 1:DATA_SET_SIZE
%     file_name = strcat(annotation(i,1), '.jpg'); 
%     saliency_file_name = strcat(annotation(i,1), '.png'); 
%     
%     full_path = fullfile(IMAGE_FULL_PATH, file_name);
%     fullPaths{i} =  full_path{1};
%     
%     saliency_path = fullfile(SALIENCY_FULL_PATH, saliency_file_name);
%     saliencyPaths{i} =  saliency_path{1};
% end
% 
% %Calculate Hog descriptors
% colorFeatures = cell(DATA_SET_SIZE,1);
% parfor i = 1:DATA_SET_SIZE
%     I = fullPaths{i};
%     img = imread(I);
%     f = getColorHistograms(img);
%     colorFeatures{i} = f;
%     if mod(i,50) == 0
%         disp(i)
%     end
% end
    

%Calculate standart SIFT descriptors with sparse sampling
%Use default keypoint detector of SIFT
% sparseSIFT = cell(DATA_SET_SIZE, 1);
% parfor i = 1:DATA_SET_SIZE
%     I = fullPaths{i};
%     if origIdx(i,1) == 1  
%         saliency = saliencyPaths{i};
%         [f,d] = computeSIFT(I, 'standart', 'sparse', i, saliency);
%     else
%         [f,d] = computeSIFT(I, 'standart', 'sparse', i);
%     end
%     sparseSIFT{i} = {f, d};
%     if mod(i,50) == 0
%         disp(i)
%     end
% end

% %Calculate color SIFT descriptors with sparse sampling
% sparseSalientOPPONENTSIFT = cell(DATA_SET_SIZE, 1);
% parfor i = 1:DATA_SET_SIZE
%     I = fullPaths{i};
%     [f,d] = computeSIFT(I, 'opponentsift', 'sparse', i);
%     sparseSalientOPPONENTSIFT{i} = {f, d};
%     if mod(i,50) == 0
%         disp(i)
%     end
% end

% Calculate SIFT descriptors with dense sampling
% Sampled every 8th pixel
% denseSIFT = cell(DATA_SET_SIZE, 2);
% for i = 1:DATA_SET_SIZE
%     I = fullPaths{i};
%     [f,d] = computeSIFT(I, 'standart', 'dense', i);
%     denseSIFT{i, 1} = f;
%     denseSIFT{i, 2} = d;
% end

% %Calculate ColorSift descriptors with dense sampling
% %Sampled every 8th pixel
% colorDescriptors = {'csift'; 'opponentsift'; 'rgbsift'; 'rgbhistogram'};
% denseOPPONENTSIFT = cell(DATA_SET_SIZE, 2);
% for i = 1:DATA_SET_SIZE
%      I = fullPaths{i};
%      [f,d] = computeSIFT(I, 'opponentsift', 'dense', i);
%      denseOPPONENTSIFT{i, 1} = f';
%      denseOPPONENTSIFT{i, 2} = d';
% end

% load denseOPPONENTSIFT
% d = denseOPPONENTSIFT(:,2);
% d = d';
% d = vl_colsubset(cat(2, d{:}), 10e4) ;
% d = single(d) ;

% Quantize the descriptors to get the visual words
% vocab = vl_kmeans(d, 1280, 'verbose', 'algorithm', 'elkan', 'MaxNumIterations', 50) ;
% save('~/Documents/MATLAB/colorsift/vocab.mat', 'vocab') ;


manipulations = zeros(13,13);
for i = 2:14
    for j = 2:14
        manipulations(i-1,j-1) = sum(annotation_numerical(logical(annotation_numerical(:,i)),j));
        if (manipulations(i-1,j-1) == 0)
            value = 1000;
        else
            value = 1/manipulations(i-1,j-1)* 1000;
        end
        fprintf('{"source":%d,"target":%d,"value":%d, "distance":%d}, \n', i-2, j-2,manipulations(i-1,j-1), int32(value));
    end
end


