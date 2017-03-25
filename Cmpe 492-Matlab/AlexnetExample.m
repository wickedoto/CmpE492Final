net = alexnet;
net.Layers
I  = imread('supper.jpg');
 if ismatrix(I)
    I = cat(3,I,I,I);
 end
 
% Resize the image as required for the CNN.
Iout = imresize(I, [227 227]);

label = classify(net, Iout)

