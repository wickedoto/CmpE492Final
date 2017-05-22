function imgC = AverageImages(imgA, imgB, weight)
%# AverageImages - average two input images according to a specified weight.
%# The two input images must be of the same size and data type.

    if weight < 0 || weight > 1
        error('Weight out of range.')
    end
    c = class(imgA);
    if strcmp(c, class(imgB)) ~= 1
        error('Images should be of the same datatype.')
    end

    %# Use double matrices for averaging so we don't lose a bit
    x = double(imgA);
    y = double(imgB);
    z = weight*x + (1-weight)*y;

    imgC = cast(z, c); %# return the same datatype as the input images
end
