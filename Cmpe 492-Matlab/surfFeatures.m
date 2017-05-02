I = imread('birth_of_venus.jpg');
grayImage = rgb2gray(I);
points = detectSURFFeatures(grayImage);
%display location of interest
imshow(I); hold on;
plot(points.selectStrongest(10));  
title('Strongest SURF features');

%extract SURF features, feature vectors, descriptors and their
%corresponding locations
[features, valid_points] = extractFeatures(grayImage, points);
figure; imshow(grayImage); hold on;
plot(valid_points.selectStrongest(10),'showOrientation',true);
title('Strongest SURF features and orientations');

%extract corner features
corners = detectHarrisFeatures(grayImage);
[features1, valid_corners] = extractFeatures(grayImage, corners);
figure; imshow(I); hold on
plot(valid_corners);
title('Corner features');
