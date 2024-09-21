inImage = ["./Baboon.bmp"  ,"./Barbara.bmp" , "Cameraman.bmp" , "Pepper.bmp"];

for i=1 : length(inImage)
    
    srcImage = im2double(imread(inImage(i))) ;
    [row, colemn, dim] = size(srcImage);
    
    if dim == 3
    srcImage = rgb2gray(srcImage);
    end
    
    for j=0.3:0.2:0.9

        noiseImage = imnoise(srcImage , 'salt & pepper' , j) ;
        mainSize = 3 ;
        dstImage = noiseReduction(noiseImage , mainSize); 
        psnrI = psnr(srcImage,dstImage) ;
        imwrite(dstImage, [num2str(i),'NR_',num2str(psnrI) ,'_', num2str(j), '.bmp']);

        filteredImage = medfilt2(noiseImage, [mainSize,mainSize]);
        psnrII = psnr(srcImage,filteredImage) ;
        imwrite(filteredImage, [num2str(i),'Median_',num2str(psnrII) ,'_', num2str(j), '.bmp']);

   

    end
    
    
end