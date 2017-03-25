I = imread('girl.jpg');
figure 
imshow(I), title('original image');
grayImage = rgb2gray(I);
figure 
imshow(grayImage), title('original image');
%Edge Detection
edges_prewitt = edge(grayImage,'Prewitt');
edges_roberts = edge(grayImage,'Roberts');
edges_sobel = edge(grayImage,'Sobel');
edges_canny = edge(grayImage, 'Canny');
%Visualization
figure;
imshow(edges_prewitt);
title('Prewitt Filter');

figure;
imshow(edges_roberts);
title('Roberts Filter');

figure;
imshow(edges_sobel);
title('Sobel Filter');

figure;
imshow(edges_canny);
title('Canny Filter');

% subplot('Position',[0.02 0.35 0.3 0.3]);
% imshow(edges_prewitt);
% subplot('Position',[0.35 0.35 0.3 0.3]);
% imshow(edges_roberts);
% subplot('Position',[0.68 0.35 0.3 0.3]);
% imshow(edges_sobel);


% linkaxes;
% 
% %Fill holes
% h = figure;
% 
% subplot('Position',[0.02 0.35 0.3 0.3]);
% imshow(imfill(edges_prewitt,'holes'));
% subplot('Position',[0.35 0.35 0.3 0.3]);
% imshow(imfill(edges_roberts,'holes'));
% subplot('Position',[0.68 0.35 0.3 0.3]);
% imshow(imfill(edges_sobel,'holes'));
% linkaxes;
% 
% BW_out = bwareaopen(imfill(edges_sobel,'holes'),20);
% figure; imshow(BW_out);
% 
% figure;
% imshow(grayImage);
% pause(3);
% grayImage(BW_out) = 0;
% imshow(grayImage);
