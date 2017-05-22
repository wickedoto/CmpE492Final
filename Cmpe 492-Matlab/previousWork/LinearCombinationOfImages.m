I = imread('arnolfi.jpg');
I1 = imread('arnolfiparody1.jpg');
I2= imread('arnolfiparody2.jpg');
I = imresize( I1,[size(I2,1) size(I2,2)]);
I1 = imresize( I1,[size(I2,1) size(I2,2)]);

grayImage = rgb2gray(I);
grayImage1 = rgb2gray(I1);
grayImage2 = rgb2gray(I2);

imgC = AverageImages(I1,I2, 0.5);

BW = edge(grayImage, 'Canny');
BW1 = edge(grayImage1, 'Canny');
BW2 = edge(grayImage2, 'Canny');

imgD = AverageImages(BW1,BW2, 0.5);

figure;
imshowpair(I1,I2,'montage');
figure;
imshowpair(BW1,BW2,'montage');
figure;
imshowpair(imgC,imgD,'montage');

%SURF Detection
pointsA = detectSURFFeatures(BW);
pointsB = detectSURFFeatures(imgD);

%Subset_Features =  pointsA(1:9:end);
figure;
imshow(BW); hold on;
plot(pointsA);

%Extract Features
[featuresA, pointsA] = extractFeatures(BW,pointsA);
[featuresB, pointsB] = extractFeatures(imgD,pointsB);

%Match Features
%indexPairs = matchFeatures(featuresA, featuresB, 'Method', 'Threshold');
indexPairs = matchFeatures(featuresA, featuresB);
numMatchedPoints = int32(size(indexPairs,1));

matchedPointsA = pointsA(indexPairs(:,1),:);
matchedPointsB = pointsB(indexPairs(:,2),:);
figure; 
ax = axes;
showMatchedFeatures(BW,imgD,matchedPointsA,matchedPointsB,'montage','Parent',ax);
title(ax, 'Candidate point matches');
legend(ax,'Image 1', 'Image 2');

