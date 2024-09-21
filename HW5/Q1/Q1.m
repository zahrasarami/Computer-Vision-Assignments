clc; clear; close all;

org_img = im2double( imread("Cells.tif") );

[counting_img,num_cells]=counting_cells(org_img);

disp(["number of cells: ", num2str(num_cells)]);
figure,imshow([counting_img ], []);

excelFileName = 'cells_info.xlsx';
createExcelFile(org_img, excelFileName, './');







function createExcelFile(org_img, excelFileName, excelDirectory)
  

    SE = strel('disk', 5);

    [counting_img,num_cells]=counting_cells(org_img);



    mask_img = counting_img;
    for k=2:num_cells+1
        for i=1:size(counting_img,1)
            for j=1:size(counting_img,2)
                if (counting_img(i,j)==k)
                    mask_img(i,j) = 1;
                else
                    mask_img(i,j)=0;
                end
                
            end
        end
        dilate_mask_img = imdilate(mask_img,SE);
        area(k-1) = sum(sum(dilate_mask_img));
        h = dilate_mask_img(:,:) .* im2uint8(org_img(:,:));
        avgBrightness(k-1) = sum(sum(h)) / area(k-1);
        number(k-1) = k-1;
    end



   
    excelFilePath = fullfile(excelDirectory, excelFileName);

     number = number';
    area = area';
    avgBrightness = avgBrightness';
    T = table(number, area, avgBrightness);
    writetable(T, excelFilePath);

end







    


function [out_img]=neighbor(e_gray,i,j,count)  
    e_gray(i,j) = count;
    for a=i-1:i+1
        for b=j-1:j+1
            if ( e_gray(a,b) == 1 )
                e_gray(a,b) = count;
                e_gray = neighbor(e_gray,a,b,count);
            end
        end
    end
    out_img = e_gray;
end


function [counting_img,num_cells]=counting_cells(org_img)

    thresh = multithresh(org_img,2);
    bw = im2bw(org_img, thresh(1));

    SE = strel('disk', 5);
    e = imerode(bw, SE);

    e_pad =  padarray(e , [1, 1], 0, "both");
    
    e_gray = im2uint8(e_pad);
    
    e_gray(e_gray==255) = 1; 

    % start from 2 
    count = 1;
    for i=2:size(e_gray, 1)-1
        for j=2:size(e_gray,2)-1
            if ( e_gray(i,j) == 1 )
              if( ( max(max( e_gray(i-1:i+1, j-1:j+1) ) ) )==1) 
                  count = count+1;
                  e_gray = neighbor(e_gray,i,j,count);
              end
    
            end
    
        end
    end

    counting_img= e_gray(2:size(e_gray, 1)-1, 2:size(e_gray,2)-1);

    num_cells = count-1;
end

