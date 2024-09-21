clc;
clear;

image1 = im2double( imread('Test_1.ppm') );
image2 = im2double( imread('Test_2.ppm') );
image3 = im2double( imread('Test_3.ppm') );

R1 = image1(:,:,1);
G1 = image1(:,:,2);
B1 = image1(:,:,3);
R2 = image2(:,:,1);
G2 = image2(:,:,2);
B2 = image2(:,:,3);
R3 = image3(:,:,1);
G3 = image3(:,:,2);
B3 = image3(:,:,3);

grayScale1 = (R1+G1+B1)/3;
grayScale2 = (R2+G2+B2)/3;
grayScale3 = (R3+G3+B3)/3;




rgbtogray1 = rgb2gray(image1) ;
rgbtogray2 = rgb2gray(image2) ;
rgbtogray3 = rgb2gray(image3) ;

imwrite(image1 , 'Test_1.png');
imwrite(grayScale1 , 'test_1_averaage.png') ;
imwrite(rgbtogray1 , 'test_1_rgb2gray.png') ;
display( ["test 1:rgb2gray way:" ,  num2str(psnr(cat(3 ,rgbtogray1 , rgbtogray1 , rgbtogray1), image1)) ])
display( ["test 1:average way:" ,  num2str(psnr(cat(3 ,grayScale1 , grayScale1 , grayScale1), image1)) ] ) ;

imwrite(image2 , 'Test_2.png');
imwrite(grayScale2 , 'test_2_averaage.png') ;
imwrite(rgbtogray2 , 'test_2_rgb2gray.png') ;
display( ["test2 :rgb2gray way:" ,  num2str(psnr(cat(3 ,rgbtogray2 , rgbtogray2 , rgbtogray2), image2)) ])
display( ["test 2 : average way:" ,  num2str(psnr(cat(3 ,grayScale2 , grayScale2 , grayScale2), image2)) ] ) ;

imwrite(image3 , 'Test_3.png');
imwrite(grayScale3 , 'test_3_averaage.png') ;
imwrite(rgbtogray3 , 'test_3_rgb2gray.png') ;
display( ["test3 :rgb2gray way:" ,  num2str(psnr(cat(3 ,rgbtogray3 , rgbtogray3 , rgbtogray3), image3)) ])
display( ["test 3 : average way:" ,  num2str(psnr(cat(3 ,grayScale3 , grayScale3 , grayScale3), image3)) ] ) ;
