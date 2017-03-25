I = imread('girl.jpg');
%figure 
%imshow(I), title('original image');
grayImage = rgb2gray(I);
%figure 
%imshow(grayImage), title('grayscale image');


[edges_prewitt, edge_threshold] = edge(grayImage,'Roberts');

step_size = -0.1;
sensitivity = edge_threshold + step_size;
edges_prewitt2 = edge(grayImage,'Canny',sensitivity);
test = imshow(edges_prewitt2);
title(sprintf('Sensitivity: %.03f', sensitivity));
