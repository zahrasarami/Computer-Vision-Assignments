clc;
clear;

coverImage = imread('Cover_Image.png') ;
dataImage = imread('IUT.jpg') ;

[rowC, colemnC, dimC] = size(coverImage);
[rowD, colemnD, dimD] = size(dataImage);

R = dataImage(:,:,1);
G = dataImage(:,:,2);
B = dataImage(:,:,3);

bit_planesR = cell(1, 8);
for i = 1:8
    bit_planesR{i} = bitget(R, i); % Extract ith bit plane
end
% imshow(logical(bit_planesR{1}));
bit_planesG = cell(1, 8);
for i = 1:8
    bit_planesG{i} = bitget(G, i); % Extract ith bit plane
end

bit_planesB = cell(1, 8);
for i = 1:8
    bit_planesB{i} = bitget(B, i); % Extract ith bit plane
end

% Concatenate matrices horizontally using a loop
tempP11 = [ bit_planesR{1}, bit_planesG{1} , bit_planesB{1} , bit_planesR{2}]; % Initialize result with the first matrix
tempP12 = [ bit_planesG{2} , bit_planesB{2} , bit_planesR{3} , bit_planesG{3}];
tempP13 = [ bit_planesB{3} , bit_planesR{4} , bit_planesG{4} , bit_planesB{4}];
tempP14 = [ bit_planesR{5}, bit_planesG{5} , bit_planesB{5} , bit_planesR{6}];

tempP21 = [ bit_planesG{6} , bit_planesB{6} , bit_planesR{7} , bit_planesG{7}];
tempP22 = [ bit_planesB{7} , bit_planesR{8} , bit_planesG{8} , bit_planesB{8}];

coverPlane1 = zeros(rowC , colemnC) ;
coverPlane1(1:4*rowD , 1:4*colemnD) = [tempP11;tempP12;tempP13;tempP14] ;
coverPlane2 = zeros(rowC , colemnC) ;
coverPlane2(1:2*rowD , 1:4*colemnD) = [tempP21;tempP22] ;

% crypto graphy
key = rng ;
randomPattern = (round(rand(size(coverPlane1)))==1) ;
randoSecret1 = xor(coverPlane1 , randomPattern) ;
randoSecret2 = xor(coverPlane2 , randomPattern) ;



steganoImage = bitset(coverImage , 1 , randoSecret1) ;
steganoImage = bitset(steganoImage , 2 , randoSecret2) ;

save('key' , 'key') ;
imwrite( steganoImage, 'steganoImage.png') ;
imshow([steganoImage , coverImage])
display([psnr(coverImage , steganoImage)]) ;
