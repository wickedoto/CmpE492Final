function [f, d] = computeSIFT(image, sift_type, sampling, idx, saliency)
% computeSIFT computes sift keypoints and descriptors.
%
% image
%   rgb image path
%
% sift_type
%   standart, c-sift
% 
% sampling
%   sparse, dense
%
% saliency
%   saliency map image path
%
% Ilhan Adiyaman
% 2015700000
% 21.12.2015
%

if nargin < 5
   saliency = 'None';
end

I = imread(image);
colorDescriptorExePath = fullfile(pwd, 'colorDescriptor');
colorDescriptorsPath = fullfile(pwd, sift_type, num2str(idx));

if strcmp(sift_type, 'standart') == 1
    if strcmp(saliency,'None') > 0
        I = single(rgb2gray(I));
    else
        I = rgb2gray(I);
        Map = imread(saliency);
        bw = double(Map>10); 
        img_out = I;
        img_out(~bw) = 0;
        I = single(img_out);
    end
    if strcmp(sampling, 'sparse') == 1
        [f,d] = vl_sift(I);
    elseif strcmp(sampling, 'dense') == 1
        [f,d] = vl_dsift(I, 'step', 8);
    end
elseif strcmp(sift_type, 'csift') == 1
    if strcmp(sampling, 'sparse') == 1
        parameters = [colorDescriptorExePath, ' ', image, ' --detector', ' harrislaplace', ' --descriptor', ' csift', ' --outputFormat binary', ' --output ', colorDescriptorsPath, '.txt'];
        system(parameters);
        output_name = strcat(colorDescriptorsPath, '.txt');
        [d , f] = readBinaryDescriptors(output_name);
        d = d';
        f = f';
    elseif strcmp(sampling, 'dense') == 1
        parameters = [colorDescriptorExePath, ' ', image, ' --detector', ' densesampling', ' --ds_spacing', ' 8', ' --descriptor', ' csift', ' --outputFormat binary', ' --output ', colorDescriptorsPath, '.txt'];
        system(parameters);
        output_name = strcat(colorDescriptorsPath, '.txt');
        [d , f] = readBinaryDescriptors(output_name);
    end
elseif strcmp(sift_type, 'opponentsift') == 1
    if strcmp(sampling, 'sparse') == 1
        parameters = [colorDescriptorExePath, ' ', image, ' --detector', ' harrislaplace', ' --descriptor', ' opponentsift', ' --outputFormat binary', ' --output ', colorDescriptorsPath, '.txt'];
        system(parameters);
        output_name = strcat(colorDescriptorsPath, '.txt');
        [d , f] = readBinaryDescriptors(output_name);
        d = d';
        f = f';
    elseif strcmp(sampling, 'dense') == 1
        parameters = [colorDescriptorExePath, ' ', image, ' --detector', ' densesampling', ' --ds_spacing', ' 8', ' --descriptor', ' opponentsift', ' --outputFormat binary', ' --output ', colorDescriptorsPath, '.txt'];
        system(parameters);
        output_name = strcat(colorDescriptorsPath, '.txt');
        [d , f] = readBinaryDescriptors(output_name);
    end
elseif strcmp(sift_type, 'rgbsift') == 1
    if strcmp(sampling, 'sparse') == 1
        parameters = [colorDescriptorExePath, ' ', image, ' --detector', ' harrislaplace', ' --descriptor', ' rgbsift', ' --outputFormat binary', ' --output ', colorDescriptorsPath, '.txt'];
        system(parameters);
        output_name = strcat(colorDescriptorsPath, '.txt');
        [d , f] = readBinaryDescriptors(output_name);
        d = d';
        f = f';
    elseif strcmp(sampling, 'dense') == 1
        parameters = [colorDescriptorExePath, ' ', image, ' --detector', ' densesampling', ' --ds_spacing', ' 8', ' --descriptor', ' rgbsift', ' --outputFormat binary', ' --output ', colorDescriptorsPath, '.txt'];
        system(parameters);
        output_name = strcat(colorDescriptorsPath, '.txt');
        [d , f] = readBinaryDescriptors(output_name);
    end
elseif strcmp(sift_type, 'rgbhistogram') == 1
    parameters = [colorDescriptorExePath, ' ', image, ' --detector', ' densesampling', ' --ds_spacing', ' 8', ' --descriptor', ' rgbhistogram', ' --outputFormat binary', ' --output ', colorDescriptorsPath, '.txt'];
    system(parameters);
    output_name = strcat(colorDescriptorsPath, '.txt');
    [d , f] = readBinaryDescriptors(output_name);
    
end