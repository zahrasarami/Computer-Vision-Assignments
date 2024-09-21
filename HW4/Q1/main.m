clear;
folderName = './Puzzle_1_160'; %just change this directory to test


patchesNumber = str2num(folderName(end-2:end));
% patchesNumber = str2num(folderName(end-1:end)); for size 40
patchImages = cell(patchesNumber ,1) ;
% read patch
imageFiles = dir(fullfile(folderName, 'Patch*.tif')); 
for i=1:patchesNumber-4
    patchImages{i} = im2double( imread(fullfile(folderName, imageFiles(i).name)) ) ;
end

outputImage = im2double( imread([folderName , '/Output.tif']) );


% find size
cornerFiles = dir(fullfile(folderName, 'Corner*.tif')); 
for i=1:4
    patchImages{i+patchesNumber-4} = im2double( imread( fullfile(folderName, cornerFiles(i).name) )) ;
end

cellCountRoot = sqrt(patchesNumber);
rowParts = floor(cellCountRoot);
while mod(patchesNumber, rowParts) ~= 0
	  rowParts = rowParts - 1;
end
colParts = patchesNumber / rowParts;
% colParts = str2num(cornerFiles(4).name(end-4:end-4)) ;
% rowParts = str2num(cornerFiles(4).name(end-6:end-6)) ; % rowParts number of patch in each row

[row , column , dim ] = size(outputImage) ;
patchSize = row/rowParts ;



%%%%%%%%%%%%%fill output.tif
edges = cell(patchesNumber, 4); % to store edges  of each patch

for i=1:patchesNumber
    [edges{i, 1}, edges{i, 2}, edges{i, 3}, edges{i, 4}] = findEdges(patchImages{i});
end

mark = zeros(rowParts , colParts) ;
mark(1,1) = 1 ;
mark(1,colParts) = 1 ;
mark(rowParts,colParts) = 1 ;
mark(rowParts ,1) = 1 ;

markPatch = zeros(1, patchesNumber);
markPatch(patchesNumber-4:patchesNumber) = 1 ;

unshuffledImage = cell(rowParts, colParts);

topLeft = outputImage(1:patchSize,1:patchSize,:);
topRight = outputImage(1:patchSize,end-patchSize+1:end,:);
bottomLeft = outputImage(end-patchSize+1:end,1:patchSize,:);
bottomRight = outputImage(end-patchSize+1:end,end-patchSize+1:end,:);

unshuffledImage{1, 1} = topLeft;
unshuffledImage{1, colParts} = topRight;
unshuffledImage{rowParts, 1} = bottomLeft;
unshuffledImage{rowParts, colParts} = bottomRight;


for x=1 : rowParts 
   for y=1 : colParts
       if mark(x,y)==0
           ind = selectPatch( unshuffledImage, x, y,patchesNumber , edges,markPatch);
           unshuffledImage{x,y} = patchImages{ind} ;
           markPatch(ind) = 1;
           mark(x,y) = 1 ;

       end
   end    
end

unshuffledImage = cell2mat(unshuffledImage);
imshow(unshuffledImage) ;


