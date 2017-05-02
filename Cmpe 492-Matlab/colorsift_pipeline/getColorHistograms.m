function [ descriptor ] = getColorHistograms( img )

nBins = 8;
descriptor = zeros(1,nBins*3*5);

if (size(img, 3) ~= 3)
    disp('Input should be a color image');
    return;
end

hsv_img = rgb2hsv(img);

%generate histograms for each channel (discard zeros)
H = hsv_img(:,:,1);
S = hsv_img(:,:,2);
V = hsv_img(:,:,3);
hHist = imhist(H(H>0), nBins);
sHist = imhist(S(S>0), nBins);
vHist = imhist(V(V>0), nBins);

%create normalized feature vector
descriptor(1,1:24) = [(hHist')./sum(hHist),(sHist')./sum(sHist),(vHist')./sum(vHist)];

[m n ~] = size(hsv_img);

%split images and add features
for j=1:2
    for k=1:2
        splitImg = hsv_img(floor((j-1)*(m/2)+1):floor(j*m/2), floor((k-1)*(n/2)+1):floor(k*n/2),:);
        H = splitImg(:,:,1);
        S = splitImg(:,:,2);
        V = splitImg(:,:,3);
        hHist = imhist(H(H>0), nBins);
        sHist = imhist(S(S>0), nBins);
        vHist = imhist(V(V>0), nBins);
        %append normalized features to the vector
        idx = (j-1)*2 + k;
        descriptor(:,idx*(nBins*3)+1:(idx+1)*(nBins*3)) = [(hHist')./sum(hHist),(sHist')./sum(sHist),(vHist')./sum(vHist)];
    end
end

end

