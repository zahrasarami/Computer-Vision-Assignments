

load 'key'
steganoImage = imread('steganoImage.png') ;
[rowC, colemnC, dimC] = size(steganoImage) ;

rng(key) ;
randomPattern = (round(rand(size(coverPlane1)))==1) ;
extracted_plane1 = bitget(steganoImage,1);
extracted_plane2 = (bitget(steganoImage,2)==1);
recovered_plane1 = xor(extracted_plane1, randomPattern);
recovered_plane2 = xor(extracted_plane2, randomPattern);


bitPlanesR = cell(1, 8);
bitPlanesG = cell(1, 8);
bitPlanesB = cell(1, 8);

bitPlanesR{1} = recovered_plane1(1:rowD ,1:colemnD) ;
bitPlanesG{1} = recovered_plane1(1:rowD,colemnD+1:colemnD*2) ;
bitPlanesB{1} = recovered_plane1(1:rowD,colemnD*2+1:colemnD*3) ;
bitPlanesR{2} = recovered_plane1(1:rowD,colemnD*3+1:colemnD*4) ;

bitPlanesG{2} = recovered_plane1(rowD+1:rowD*2 ,1:colemnD) ;
bitPlanesB{2} = recovered_plane1(rowD+1:rowD*2 ,colemnD+1:colemnD*2) ;
bitPlanesR{3} = recovered_plane1(rowD+1:rowD*2 ,colemnD*2+1:colemnD*3) ;
bitPlanesG{3} = recovered_plane1(rowD+1:rowD*2 ,colemnD*3+1:colemnD*4) ;

bitPlanesB{3} = recovered_plane1(rowD*2+1:rowD*3 ,1:colemnD) ;
bitPlanesR{4} = recovered_plane1(rowD*2+1:rowD*3 ,colemnD+1:colemnD*2) ;
bitPlanesG{4} = recovered_plane1(rowD*2+1:rowD*3 ,colemnD*2+1:colemnD*3) ;
bitPlanesB{4} = recovered_plane1(rowD*2+1:rowD*3 ,colemnD*3+1:colemnD*4) ;

bitPlanesR{5} = recovered_plane1(rowD*3+1:rowD*4 ,1:colemnD) ;
bitPlanesG{5} = recovered_plane1(rowD*3+1:rowD*4 ,colemnD+1:colemnD*2) ;
bitPlanesB{5} = recovered_plane1(rowD*3+1:rowD*4 ,colemnD*2+1:colemnD*3) ;
bitPlanesR{6} = recovered_plane1(rowD*3+1:rowD*4 ,colemnD*3+1:colemnD*4) ;

bitPlanesG{6} = recovered_plane2(1:rowD ,1:colemnD) ;
bitPlanesB{6} = recovered_plane2(1:rowD,colemnD+1:colemnD*2) ;
bitPlanesR{7} = recovered_plane2(1:rowD,colemnD*2+1:colemnD*3) ;
bitPlanesG{7} = recovered_plane2(1:rowD,colemnD*3+1:colemnD*4) ;

bitPlanesB{7} = recovered_plane2(rowD+1:rowD*2 ,1:colemnD) ;
bitPlanesR{8} = recovered_plane2(rowD+1:rowD*2 ,colemnD+1:colemnD*2) ;
bitPlanesG{8} = recovered_plane2(rowD+1:rowD*2 ,colemnD*2+1:colemnD*3) ;
bitPlanesB{8} = recovered_plane2(rowD+1:rowD*2 ,colemnD*3+1:colemnD*4) ;



R = zeros(rowD , colemnD , "uint8") ;
G = zeros(rowD , colemnD , "uint8") ;
B = zeros(rowD , colemnD , "uint8") ;

for i = 1:8
    R = bitset(R , i , bitPlanesR{i}) ; % set ith bit plane
    G = bitset(G , i , bitPlanesG{i}) ;
    B = bitset(B , i , bitPlanesB{i}) ;
end


RGB_image = cat(3, R, G, B);
imwrite(RGB_image , 'NEW_IUT.jpg') ;
% Display the RGB image
imshow(RGB_image , []);

