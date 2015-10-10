function [error] = computeQuantizationError(origImg, quantizedImg)
%  Compute the SSD error between the original RGB pixel values and the quantized values

%  Where origImg and quantizedImg are both RGB images, and error is a scalar giving 
%  the total SSD error across the image.

    squareDifference = (double(origImg) - double(quantizedImg)) .^ 2;
    error = sum(sum(sum( squareDifference )));

end

