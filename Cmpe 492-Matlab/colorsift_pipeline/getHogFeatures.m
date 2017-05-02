function [ features ] = getHogFeatures( img )
    numWindowsX = 8;
    numWindowsY = 8;
    numHistBins = 31;
    
    [L,C] = size(img); %Lines and columns
    
    img = im2double(img);
    
    features  = zeros( numWindowsX * numWindowsY * numHistBins, 1); %Initialize feature vector
    
    %Compute gradients
    hx = [-1,0,1];
    hy = -hx';
    gradX = imfilter(img,hx);
    gradY = imfilter(img,hy);

    %Angles and magnitudes of gradients
    angles = atan2(gradY,gradX); %Four quadrant inverse tangent between -pi, +pi
    magnitude =((gradY.^2).*(gradX.^2)).^.5;
    
    %Step size in terms of pixels
    stepX = floor(C/(numWindowsX+1));
    stepY = floor(L/(numWindowsY+1));
    
    countBlock = 0; %Counter of block number
    
    for n = 0:numWindowsY - 1
        for m = 0:numWindowsX - 1
            countBlock = countBlock + 1;
            %Angles and magnitudes of current block
            blockAngles = angles( (n*stepY)+1:(n+2)*stepY , (m*stepX)+1:(m+2)*stepX ); 
            blockMagnitude = magnitude( (n*stepY)+1:(n+2)*stepY , (m*stepX)+1:(m+2)*stepX );
            
            %Matrices transformed into one-column vectors
            blockAngles = blockAngles(:);    
            blockMagnitude = blockMagnitude(:);
                        
            %Create histogram of angles with 'numHistBins' bins
            countBin = 0; %Counter of bin indexes
            blockFeatures = zeros(numHistBins,1);
            
            for theta = -pi+2*pi/numHistBins:2*pi/numHistBins:pi
                countBin = countBin + 1;
                for k=1:length(blockAngles)
                    if blockAngles(k)<theta
                        blockAngles(k)= 100; %sentinel value for Inf
                        blockFeatures(countBin) = blockFeatures(countBin) + blockMagnitude(k);
                    end
                end
            end
        
            blockFeatures = blockFeatures/(norm(blockFeatures)+0.01); %normalize blocks
            
            features(((countBlock-1)*numHistBins)+1 : countBlock*numHistBins,1)= blockFeatures;
        end
    end
    % Each row is histogram of one block
     features = reshape(features, numWindowsX*numWindowsY, numHistBins);
    
end