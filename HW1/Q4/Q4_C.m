
refImage = imread('IUT.jpg') ;
dataImage = imread('NEW_IUT.jpg') ;

display([psnr(refImage , dataImage)]) ;