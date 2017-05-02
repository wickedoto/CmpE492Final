function [ featureVector,info ] = showImage( bag,imds,index )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    [img,info] = readimage(imds, index);
    featureVector = encode(bag,img);
    figure
    bar(featureVector);
    title('Visual word occurrences');
    xlabel('Visual word index');
    ylabel('Frequency of occurrence');

end

