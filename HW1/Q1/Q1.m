clc
clear

path = 'Q_1.ppm'
columns = 1282
rows = 852

F = fopen(path) ;
fileContent = fread(F);
fclose(F) ;

header = length(fileContent) - rows*columns*3

imageData = fileContent(header+1:end) ;

I = zeros(rows,columns) ;
J = zeros(rows,columns) ;
K = zeros(rows,columns) ;

k=1 ;
for i=1:rows
    for j=1:columns
    I(i,j) = imageData(k) ;
    k = k+1 ;
    J(i,j) = imageData(k) ;
    k = k+1 ;
    K(i,j) = imageData(k) ;
    k = k+1 ;
    end
end

resault = cat(3 , I ,J ,K);
test = imread(path) ;
imshow([resault , test],[]) ;
title("code resault:                          imread:");