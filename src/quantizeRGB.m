function  [outputImg, meanColors] = quantizeRGB(origImg, k) 
%Input must be a 3d matrix, which means RGB image
%TODO too slow
    osize = size(origImg);
    numPixels = osize(1) * osize(2);
    colorMatrix = double(reshape(origImg, numPixels, 3));
    
    %generate k points as centers, until now we use random()
    
    [labels, meanColors] = myKMeans(colorMatrix, k);
    %[labels, meanColors] = kmeans(colorMatrix, k);
    
    outputImg = colorMatrix;
    
    for i = 1:k
       outputImg(labels == i,:) = repmat(meanColors(i,:), sum(labels == i), 1);
    end
    outputImg = uint8(reshape(outputImg, osize(1), osize(2), 3));
end

