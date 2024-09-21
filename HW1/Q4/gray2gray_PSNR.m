
function psnrValue = gray2gray_PSNR(inImage , refImage)
    mse = immse(inImage , refImage) ;
    maxPixelValue = double(1.0);
    psnrValue = 10 * log10((maxPixelValue^2) / mse);
    disp(['PSNR value: ', num2str(psnrValue)]);
end

% Convert the RGB image to grayscale
% 
% inImage = rgb2gray(image);
% %inImage = grayScale;
% % Compute the MSE between original grayscale and grayscale version of RGB image
% mseR = immse(inImage, R);
% mseG = immse(inImage, G);
% mseB = immse(inImage, B);
% mse = (mseR + mseG + mseB)/3 ;
% 
% % Calculate the maximum possible pixel value
% maxPixelValue = double(1.0);
% 
% % Calculate PSNR
% psnrValue = 10 * log10((maxPixelValue^2) / mse);
% maxPixelValue = double(1.0);
% % Display the PSNR value
