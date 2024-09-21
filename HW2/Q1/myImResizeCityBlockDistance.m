function outputImage = myImResizeCityBlockDistance( sourceImage , resizeFactor)
    
    sourceImage = im2double(sourceImage) ;
    [rowS, colemnS, dimS] = size(sourceImage);
    rowD = round( rowS*resizeFactor );
    colemnD = round( colemnS*resizeFactor ); 
    dimD = dimS ;
    outputImage = zeros(rowD , colemnD , dimD , class(sourceImage)) ;

    for x=1:colemnD
        for y=1:rowD
            PColmn = (x)*(colemnS/colemnD) ;
            PRow = (y)*(rowS/rowD) ;
            c = round(PColmn) ;
            r = round(PRow) ;

            d1 = abs(PColmn-c) + abs(PRow-r) ;
            d2 = abs(PColmn-abs(c-1)) + abs(PRow-abs(r-1)) ;
            d3 = abs(PColmn-abs(c-1)) + abs(PRow-r) ;
            d4 = abs(PColmn-c) + abs(PRow-abs(r-1) );

            d1(d1 == 0) = 0.001;
            d2(d2 == 0) = 0.001;
            d3(d3 == 0) = 0.001;
            d4(d4 == 0) = 0.001;

            sum = d1+d2+d3+d4 ;
            d1 = sum/d1 ;
            d2 = sum/d2 ;
            d3 = sum/d3 ;
            d4 = sum/d4 ;
            sum = d1+d2+d3+d4 ;
            c = min(c , colemnS-1) ;
            r = min(r , rowS-1) ;
            outputImage(y,x,:) = sourceImage(r , c , :)*((d1)/sum) + sourceImage(max(1, round(r-1)) , max(1, round(c-1)) , :)*((d2)/sum) + sourceImage(r , max(1, round(c-1)) , :)*((d3)/sum)+ sourceImage(max(1, round(r-1)) , c , :)*((d4)/sum); 
           
        end
    end
end
