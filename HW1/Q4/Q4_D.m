clc;
clear;

steganoImage = imread('Cover_Image.png') ;

bit_planes = cell(1, 8);
for i = 1:8
    bit_planes{i} = bitget(steganoImage, i); % Extract ith bit plane
    imshow(logical(bit_planes{i})) ;
    imwrite(logical(bit_planes{i}) , ['steganoPlane',num2str(i) ,'.png']);
end

