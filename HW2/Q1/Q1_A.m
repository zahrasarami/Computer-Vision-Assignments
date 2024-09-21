testImages = ["Boat.png"; "Cameraman.png"];
for i=1 : length(testImages)
    
    I = imread(testImages(i));

    nBigger = myImResizeNeighbor(I , 2)  ;
    nSmaller = myImResizeNeighbor(I ,0.5 ) ;

    bBigger = myImResizeBilinear(I , 2)  ;
    bSmaller = myImResizeBilinear(I ,0.5 ) ;

    imwrite(nBigger , [ int2str(i) , '_nn_big.png']) ;
    imwrite(nSmaller , [ int2str(i) , '_nn_small.png']) ;
    imwrite(bBigger , [ int2str(i) , '_b_big.png']) ;
    imwrite(bSmaller , [ int2str(i) , '_b_small.png']) ;
    
    
end