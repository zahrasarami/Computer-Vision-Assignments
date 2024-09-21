
function psnrValue = gray2gray_PSNR(inImage , refImage)
    mse = immse(inImage , refImage) ;
    maxPixelValue = double(1.0);
    psnrValue = 10 * log10((maxPixelValue^2) / mse);
    disp(['PSNR value: ', num2str(psnrValue)]);
end

