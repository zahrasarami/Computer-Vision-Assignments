
function dstImage=noiseReduction(noiseImage , mainSize)

    [row, colemn, dim] = size(noiseImage);
    dstImage = zeros(row ,colemn , 1 , class(noiseImage)) ;
    
    
    for x=1:row
        for y=1:colemn
            
            % make kernel
            kernelSize = mainSize ;
            while true
                kernel = noiseImage( max(1,x-floor(kernelSize / 2)):min(row,x+floor(kernelSize / 2)) , max(1,y-floor(kernelSize / 2)):min(colemn,y+floor(kernelSize / 2)));
                
                notNoisePixels = [];
                noiseCounter = 0 ;
                [r , c] = size(kernel) ;
                %count noisy pixel and extract real data 
                for i=1:r
                    for j=1:c
                        if kernel(i,j)==0 || kernel(i,j)==1
                            noiseCounter = noiseCounter + 1  ;
                        else
                            notNoisePixels = [notNoisePixels , kernel(i,j)] ;
                        end
                    end
                end
    
                if noiseCounter==kernelSize^2
                    kernelSize = kernelSize+2 ; %add one pixel in each side
                else
                        break;
                end
    
            end
            
            dstImage(x, y) = median(notNoisePixels);
            if size(notNoisePixels)==0
               dstImage(x, y) = 0.5; 
            end
        end
    end
end