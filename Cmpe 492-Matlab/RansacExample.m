imgArgb = im2single(imread('left.jpg'));
imgBrgb = im2single(imread('right.jpg'));

imgArgb_resized = imresize(imgArgb,0.5);
imgBrgb_resized = imresize(imgBrgb,0.5);
imgA = rgb2gray(imgArgb_resized);
imgB = rgb2gray(imgBrgb_resized);

h1= figure;
subplot(1,2,1); imshow(imgArgb_resized);
subplot(1,2,2); imshow(imgBrgb_resized);

%SURF Detection
pointsA = detectSURFFeatures(imgA);
pointsB = detectSURFFeatures(imgB);
%Subset_Features =  pointsA(1:9:end);
figure;
imshow(imgA); hold on;

plot(pointsA);

%Extract Features
[featuresA, pointsA] = extractFeatures(imgA,pointsA);
[featuresB, pointsB] = extractFeatures(imgB,pointsB);

%Match Features
%indexPairs = matchFeatures(featuresA, featuresB, 'Method', 'Threshold');
indexPairs = matchFeatures(featuresA, featuresB);
numMatchedPoints = int32(size(indexPairs,1));

matchedPointsA = pointsA(indexPairs(:,1),:);
matchedPointsB = pointsB(indexPairs(:,2),:);
figure; 
ax = axes;
showMatchedFeatures(imgA,imgB,matchedPointsA,matchedPointsB,'montage','Parent',ax);
title(ax, 'Candidate point matches');
%legend('Image 1', 'Image 2');
legend(ax, 'Image 1','Image 2');



