function colorQuantizeMain( )
% Main function for showing results for assignment
    fishImage = imread('fish.jpg');
    K = 3;
    quantizeShowResult(fishImage, K);
    K = 10;
    quantizeShowResult(fishImage, K);  
end

