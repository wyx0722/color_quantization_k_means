function  [outputImg, meanColors] = quantizeRGB(origImg, k) 
%  Given an RGB image, quantize the 3-dimensional RGB space, and map each 
%  pixel in the input image to its nearest k-means center. 
%  That is, replace the RGB value at each pixel with its nearest cluster’s average RGB value. 

%  where origImg and outputImg are RGB images, k specifies the number of colors to
%  quantize to, and meanColors is a k x 3 array of the k centers. 
    osize = size(origImg);
    numPixels = osize(1) * osize(2);
    colorMatrix = double(reshape(origImg, numPixels, 3));
    
    [labels, meanColors] = myKMeans(colorMatrix, k);
    %[labels, meanColors] = kmeans(colorMatrix, k);
    
    %replace the RGB value at each pixel with its nearest cluster’s average RGB value.
    outputImg = colorMatrix;
    for i = 1:k
       outputImg(labels == i,:) = repmat(meanColors(i,:), sum(labels == i), 1);
    end
    outputImg = uint8(reshape(outputImg, osize(1), osize(2), 3));
end

