function [centers, labels] = myKMeans(inputData, k)
    [numData, dimData] = size(inputData);
    
    centers = rand(k, dim_data) .* repmat(max(input_data, [], 1), k, 1);
    labels = zeros(1, num_data);
    
    MAX_ITERATION = 2^30;
    
    for iteration = 1:MAX_ITERATION
        dataSquare = repmat(sum((inputData .* inputData), 2)', k, 1);
        centerSquare = repmat(sum((centers .* centers), 2), 1, numData);
        dataCenterProduct = centers * inputData';
        distances = dataSquare - 2*dataCenterProduct + centerSquare;
        
        [maxValues, newLabels] = max(distances, [], 1);
        if newLabels == labels
            break;
        end
        
        labels = newLabels;
        
        for i = 1:k
            points = inputData(newLabels == i, :);
            if size(points, 1) ~= 0
                centers(i, :) = sum(points, 1) / size(points, 1);
            end
        end
    end
    
    for i = 1:k
        points = inputData(labels == i, :);
        if size(points, 1) ~= 0
            centers(i, :) = sum(points, 1) / size(points, 1);
        end
    end
end

