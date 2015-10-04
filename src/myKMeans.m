function [labels, centers] = myKMeans(inputData, k)

% A kmeans function uses Euclidean distance and ignore empty cluster error.
% The main idea combines three steps: compute distances -> compare labels
% (whether points are assigned to same centers as previous iteration) -> 
% new labels, new centers.

    [numData, dimData] = size(inputData);
    labels = zeros(numData, 1);
    
    MAX_ITERATION = 256; %If kmeans exceeds iteration limitation, we return. 
    
    %Centers are allocated randly in the data space.
    %But don't exceed range of inputData.
    Xmins = min(inputData,[],1);
    Xmaxs = max(inputData,[],1);
    centers =  unifrnd(Xmins(ones(k,1),:), Xmaxs(ones(k,1),:));;
    
    for iteration = 1:MAX_ITERATION
        %iteration
        
        % Compute distances by Euclidean distance (L2-norm)
        % distances is a numData-by-k matrix, the (i, j) entry means the
        % distance from point i to center j. 
        dataSquare = repmat(sum((inputData .* inputData), 2), 1, k);
        centerSquare = repmat(sum((centers .* centers), 2)', numData, 1);
        dataCenterProduct = inputData * centers';
        distances = dataSquare - 2 * dataCenterProduct + centerSquare;
        
        %Get labels 
        [minValues, newLabels] = min(distances, [], 2);
        
        % Compare labels to previous labels, if labels don't change, we can
        % finish kmeans iteration.
        if newLabels == labels
            break;
        end
        
        labels = newLabels;
        
        %Update new centers
        for i = 1:k
            %those points are assigned to center i
            points = inputData(newLabels == i, :); 
            if size(points, 1) ~= 0
                centers(i, :) = sum(points, 1) / size(points, 1);
            else
                iteration
                'warning, emtpy cluster'
                % Until now we don't deal with empty clusters.
                % There are two methods:
                % 1. see it as fault or warning
                % 2. assgin this center a position of a point which is
                % the most far to its center.
            end
        end
    end
    
    
end

