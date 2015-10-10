function [outputImg, meanHues] = quantizeHSV(origImg, k)
%  Given an RGB image, convert to HSV, and quantize the 1-dimensional Hue space. 
%  Map each pixel in the input image to its nearest quantized Hue value using k means, 
%  while keeping its Saturation and Value channels the same as the
%  input. Convert the quantized output back to RGB color space

%  where origImg and outputImg are RGB images, k specifies the number of clusters, and
%  meanHues is a k x 1 vector of the hue centers.

    osize = size(origImg);
    numPixels = osize(1) * osize(2);
    hsvImage = rgb2hsv(origImg);
    colorMatrix = reshape(hsvImage(:,:,1), numPixels, 1); 
    
    [labels, meanHues] = myKMeans(colorMatrix, k);
    %[labels, meanHues] = kmeans(colorMatrix, k);
    
    outputImg = colorMatrix;
    
    %replace the Hue value at each pixel with its nearest cluster’s average Hue value.
    for i = 1:k
       outputImg(labels == i) = repmat(meanHues(i,:), sum(labels == i), 1);
    end
    outputImg = reshape(outputImg, osize(1), osize(2));
    
    hsvImage(:,:,1) = outputImg;
    outputImg = hsv2rgb(hsvImage);

end

