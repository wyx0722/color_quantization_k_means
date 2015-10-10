function [histEqual, histClustered] = getHueHists(im, k)
% Given an image, compute and display two histograms of its hue values. Let the first
% histogram use k equally-spaced bins (uniformly dividing up the hue values), and let the
% second histogram use bins defined by the k cluster center memberships (i.e., all pixels
% belonging to hue cluster i go to the i-th bin, for i=1,…k)
    osize = size(im);
    numPixels = osize(1) * osize(2);
    hsvImage = rgb2hsv(im);
    
    colorMatrix = reshape(hsvImage(:,:,1), numPixels, 1); 
    
    %generate k points as centers, until now we use random()
    [histEqual] = hist(colorMatrix, k);
    
    
    [labels, meanHues] = myKMeans(colorMatrix, k);
    %[labels, meanHues] = kmeans(colorMatrix, k);

    
    histClustered = zeros(1, k);
    for i = 1:k
        histClustered(1, i) = sum(labels == i);
    end
end

