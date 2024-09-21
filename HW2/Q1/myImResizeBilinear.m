

function outputImage = myImResizeBilinear( sourceImage , resizeFactor)

    sourceImage = im2double(sourceImage) ;
    [rowS, colemnS, dimS] = size(sourceImage);
    rowD = round( rowS*resizeFactor );
    colemnD = round( colemnS*resizeFactor ); 
    dimD = dimS ;
    outputImage = zeros(rowD , colemnD , dimD , class(sourceImage)) ;

    for x=1:colemnD
        for y=1:rowD
            colemnLoc = (x)*(colemnS/colemnD);
            PColemn = round(colemnLoc);
            colmnDst = colemnLoc - PColemn ;
            rowLoc = (y)*(rowS/rowD) ;
            PRow = round(rowLoc) ;
            rowDist = rowLoc - PRow ;
            PColemn = min(PColemn , colemnS-1) ;
            PRow = min(PRow , rowS-1) ;
            outputImage(y,x,:) = sourceImage(PRow , PColemn , :)*(1-rowDist)*(1-colmnDst) + sourceImage(PRow+1 , PColemn , :)*(rowDist)*(1-colmnDst) + sourceImage(PRow , PColemn+1 , :)*(1-rowDist)*(colmnDst) + sourceImage(PRow+1 , PColemn+1 , :)*(rowDist)*(colmnDst) ;

        end
    end

end

