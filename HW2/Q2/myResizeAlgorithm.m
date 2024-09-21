function [outputImage] = myResizeAlgorithm( sourceImage , resizeFactor)
    
    sourceImage = im2double(sourceImage);
    [rowS, colemnS, dimS] = size(sourceImage);
    rowD = round( rowS*resizeFactor );
    colemnD = round( colemnS*resizeFactor ); 
    dimD = dimS ;
    outputImage = zeros(rowD , colemnD , dimD , class(sourceImage) ) ;
    
    y = 1;
    for i=1 : rowD
        x = 1;
        for j=1 : colemnD
            if mod(i, 2) == 1 && mod(j, 2) == 1
                outputImage(i, j) = sourceImage(y, x);
                x = x + 1;
            elseif mod(i, 2) == 0 && mod(j, 2) == 0
                % average between neighber pixel
                if x < colemnS && y < rowS
                    outputImage(i, j) = (sourceImage(y, x) + sourceImage(y, x+1) + sourceImage(y-1, x) + sourceImage(y-1, x+1))/4;
                else
                    outputImage(i, j) = (sourceImage(y, x) + sourceImage(y-1, x)) / 2; 
                end
                x = x + 1;
            end
        end
        if mod(i, 2) == 1 && y < rowS
            y = y + 1;
        end
    end

    for i=1 : rowD
        for j=1 : colemnD
            if (mod(i, 2) == 1 && mod(j, 2) == 0) || (mod(i, 2) == 0 && mod(j, 2) == 1)
                if i < rowD && i > 1 && j < colemnD && j > 1
                    outputImage(i, j) = (outputImage(i+1, j) + outputImage(i-1, j) + outputImage(i, j+1) + outputImage(i, j-1))/4;
                elseif i == rowD 
                    if j == 1
                        outputImage(i, j) = (outputImage(i-1, j) + outputImage(i, j+1))/2;
                    elseif j == colemnD
                        outputImage(i, j) = (outputImage(i-1, j) + outputImage(i, j-1))/2;
                    else
                        outputImage(i, j) = (outputImage(i-1, j) + outputImage(i, j+1) + outputImage(i, j-1))/3; 
                    end

                elseif i == 1
                    if j == 1
                        outputImage(i, j) = (outputImage(i+1, j) + outputImage(i, j+1))/2;
                    elseif j == colemnD
                        outputImage(i, j) = (outputImage(i+1, j) + outputImage(i, j-1))/2;
                    else
                        outputImage(i, j) = (outputImage(i+1, j) + outputImage(i, j+1) + outputImage(i, j-1))/3; 
                    end

                elseif j==colemnD
                    if i == 1
                        outputImage(i, j) = (outputImage(i, j-1) + outputImage(i+1, j))/2;
                    elseif i == rowD
                        outputImage(i, j) = (outputImage(i, j-1) + outputImage(i-1, j))/2;
                    else
                        outputImage(i, j) = (outputImage(i+1, j) + outputImage(i-1, j) + outputImage(i, j-1))/3; 
                    end
                  elseif j==1
                    if i == 1
                        outputImage(i, j) = (outputImage(i, j+11) + outputImage(i+1, j))/2;
                    elseif i == rowD
                        outputImage(i, j) = (outputImage(i, j+1) + outputImage(i-1, j))/2;
                    else
                        outputImage(i, j) = (outputImage(i+1, j) + outputImage(i-1, j) + outputImage(i, j+1))/3; 
                    end  

                end

            end  

        end
    end
    
end