inImage = ["LR_Boat.png";"LR_Cameraman.png"; "LR_House.png"; "LR_Peppers.png"];
srcImage = ["Boat.png"; "Cameraman.png"; "House.png"; "Peppers.png"];

for i=1 : length(inImage)
    
    I = imread(inImage(i)) ;
    I = im2gray(I) ;
    srcI = im2double(imread(srcImage(i)) );
    srcI = im2gray(srcI) ;
    fprintf("\npicture %s : \n", inImage(i));

    tic
    nnImage = myImResizeNeighbor(I, 2);
    toc
    tic
    bilinearImage = myImResizeBilinear(I,2) ;
    toc
    tic
    bicubicImage = im2double( imresize(I, 2, 'bicubic') );
    toc
    tic
    euc = myImResizeEucleadian(I , 2);
    toc
    tic
    chess = myImResizeChessBoard(I , 2);
    toc
    tic
    city = myImResizeCityBlockDistance(I , 2);
    toc
    tic
    myResizeImage = myResizeAlgorithm(I,2);
    toc
    
    psnr_near = psnr(srcI, nnImage);
    psnr_bilinear = psnr(srcI, bilinearImage);
    psnr_bicubic = psnr(srcI, bicubicImage);
    psnr_euc = psnr(srcI, euc);
    psnr_chess = psnr(srcI, chess);
    psnr_myRisize = psnr(srcI, myResizeImage);
    psnr_city = psnr(srcI , city) ;

    disp(["psnr of nearest :", num2str(psnr_near)]);
    disp(["psnr of bilinear :", num2str(psnr_bilinear)]);
    disp(["psnr of bicubic :", num2str(psnr_bicubic)]);
    disp(["\npsnr of euc : ", num2str(psnr_euc)]);
    disp(["psnr of chess :", num2str(psnr_chess)]);
    disp(["psnr of city : ", num2str(psnr_city)]);
    disp(["psnr of MyResize algorithm :", num2str(psnr_myRisize)]);
    disp(["***********************************"]);
    
end