function quantizeShowResult(fishImage, K)
% This is function for showing result for different K values
% It firstly generates a figure showing k means cluster result image in RGB
% and Hue space

% Then it generates bar graph for equal-size bins and Hue space bins;

    %RGB k means
    [rgbKMeansImage, rgbMeanColors] = quantizeRGB(fishImage, K);
    rgbSSD = computeQuantizationError(fishImage, rgbKMeansImage);
    figure;
    subplot(2, 1, 1);
    imshow(rgbKMeansImage);
    title(['Output Image of k Means in RGB Space, k = ' , num2str(K), ', SSD = ', num2str(rgbSSD)]);
    
    %Hue space k means
    [hsvKMeansImage, hsvMeanColors] = quantizeHSV(fishImage, K);
    hsvSSD = computeQuantizationError(fishImage, hsvKMeansImage);
    subplot(2, 1, 2);
    imshow(hsvKMeansImage);
    title(['Output Image of k Means in HSV Space, k = ' , num2str(K), ',SSD = ', num2str(hsvSSD)]);
    
    %histogram for equal bins and Hue space;
    [histEqual, histClustered] = getHueHists(fishImage, K);
    histEqualMean = (1:length(histEqual)) * 1 / K - 1 / 2 / K;
    figure;
    pos1 = subplot(2, 1, 1);
    bar(pos1, histEqualMean, histEqual);
    title(['Histogram for Equal Bins, k = ', num2str(K)]);
    pos2 = subplot(2, 1, 2);
    bar(pos2, hsvMeanColors, histClustered);
    title(['Histogram for Hue Clustered Bins, k = ', num2str(K)]);
    
end

