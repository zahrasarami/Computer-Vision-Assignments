
function outputImage = myImResizeNeighbor( sourceImage , resizeFactor)
    
    sourceImage = im2double(sourceImage) ;
    [rowS, colemnS, dimS] = size(sourceImage);
    rowD = round( rowS*resizeFactor );
    colemnD = round( colemnS*resizeFactor ); 
    dimD = dimS ;
    outputImage = zeros(rowD , colemnD , dimD , class(sourceImage)) ;

    for x=1:colemnD
        for y=1:rowD
            PColmn = round((x)*(colemnS/colemnD)) ;
            PRow = round((y)*(rowS/rowD)) ;
            PColmn = min(PColmn , colemnS) ;
            PRow = min(PRow , rowS) ;
            outputImage(y,x,:) = sourceImage(PRow , PColmn , :) ;
        end
    end
end
