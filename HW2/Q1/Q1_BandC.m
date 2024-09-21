clear;
srcImage = im2double( imread("LR_Boat.png") ) ;
mainImage = im2double( imread("Boat.png") ) ;

nearNeighbor = myImResizeNeighbor(srcImage , 2)  ;
bilinear = myImResizeBilinear(srcImage , 2)  ;
euc = myImResizeEucleadian(srcImage , 2)  ;
chess = myImResizeChessBoard(srcImage , 2)  ;
city = myImResizeCityBlockDistance(srcImage , 2) ;

psnr_near = psnr(mainImage, nearNeighbor);
psnr_bilinear = psnr(mainImage, bilinear);
psnr_euc = psnr(mainImage, euc);
psnr_chess = psnr(mainImage, chess);
psnr_city = psnr(mainImage , city) ;


disp(["psnr of nearest :", num2str(psnr_near)]);
disp(["psnr of bilinear :", num2str(psnr_bilinear)]);
disp(["npsnr of euc : ", num2str(psnr_euc)]);
disp(["psnr of chess :", num2str(psnr_chess)]);
disp(["psnr of city : ", num2str(psnr_city)]);

imwrite(nearNeighbor , 'n.png') ;
imwrite(bilinear , 'b.png') ;
imwrite(euc , 'e.png') ;
imwrite(chess , 'c.png') ;
imwrite(city , 'city.png') ;
