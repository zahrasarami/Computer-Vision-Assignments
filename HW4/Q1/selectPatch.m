
function [outIndex] = selectPatch(unshuffledImage, x, y , patchesNumber , edges,markPatch)
    maxPsnr = 0;
    if y == 1
        [left, right, up, down] = findEdges(unshuffledImage{x-1,y});
        for i=1 : patchesNumber
            %check up edge
            temp = psnr(edges{i,3} , down);
            if temp > maxPsnr && markPatch(i)==0
                maxPsnr = temp;
                outIndex = i;
            end
        end
    elseif (x == 1)
        [left, right, up, down] = findEdges(unshuffledImage{x,y-1});
        for i=1 : patchesNumber
            %check right edge
            temp = psnr(edges{i,1} , right);
            if temp > maxPsnr && markPatch(i)==0
                maxPsnr = temp;
                outIndex = i;
            end
        end
    else

        maxPsnr = 0;
        [leftU, rightU, upU, downU] = findEdges(unshuffledImage{x-1,y});
        [leftL, rightL, upL, downL] = findEdges(unshuffledImage{x,y-1});
        for i=1 : patchesNumber-1
            %check right edge
            tempU = psnr(edges{i,3} , downU);
            tempL = psnr(edges{i,1} , rightL);
            temp = tempU+tempL;
            disp(i);
            if temp > maxPsnr && markPatch(i)==0
                maxPsnr = temp;
                outIndex = i;
            else 
                outIndex = i ;
            end
        end
  
    end
    
end
