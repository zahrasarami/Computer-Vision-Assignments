function vesselSegmentationPerformance()
    % Load images from the dataset
    testImages = dir('DRIVE/Test/images/*.tif');
    testMaskImages = dir('DRIVE/Test/mask/*.gif');
    testManualImages = dir('DRIVE/Test/1st_manual/*.gif');

    % Initialize headers and data container
    headers = {'PictureName', 'Sensitivity', 'Specificity', 'Accuracy'};
    data = cell(length(testImages) + 1, length(headers));
    data(1, :) = headers;

    % Initialize performance metrics sums
    sumOfSensitivity = 0;
    sumOfSpecificity = 0;
    sumOfAccuracy = 0;

    % Process each image in the dataset
    for i = 1:length(testImages)
        rgbImg = imread(['DRIVE/Test/images/' testImages(i).name]);
        mask = im2double(imread(['DRIVE/Test/mask/' testMaskImages(i).name]));
        manual = imread(['DRIVE/Test/1st_manual/' testManualImages(i).name]);

        % Convert RGB image to grayscale
        grayImg = rgb2gray(rgbImg);

        % Erode mask with a disk structuring element
        seMask = strel('disk', 10);
        mask = imerode(mask, seMask);

        % Extract edges using different methods
        edgeLog = edge(grayImg, "log");
        edgeCanny = edge(grayImg, "canny");

        % Dilate edges
        se = strel("disk", 3);
        dilatedEdgeLog = imdilate(edgeLog, se);
        dilatedEdgeCanny = imdilate(edgeCanny, se);

        % Apply mask to edges
        edgeLog = edgeLog .* mask;
        edgeCanny = edgeCanny .* mask;
        dilatedEdgeLog = dilatedEdgeLog .* mask;
        dilatedEdgeCanny = dilatedEdgeCanny .* mask;

        % Calculate performance metrics
        [TP, TN, FP, FN] = Performance(dilatedEdgeLog, manual);
        sensitivity = TP / (TP + FN);
        specificity = TN / (TN + FP);
        accuracy = (TP + TN) / (TP + TN + FP + FN);

        % Sum the performance metrics
        sumOfSensitivity = sumOfSensitivity + sensitivity;
        sumOfSpecificity = sumOfSpecificity + specificity;
        sumOfAccuracy = sumOfAccuracy + accuracy;

        % Store the results
        data(i + 1, :) = {testImages(i).name, sensitivity, specificity, accuracy};
    end

    % Calculate average performance metrics
    avgSensitivity = sumOfSensitivity / length(testImages);
    avgSpecificity = sumOfSpecificity / length(testImages);
    avgAccuracy = sumOfAccuracy / length(testImages);

    % Display average performance metrics
    disp('Average Sensitivity: ' + string(avgSensitivity));
    disp('Average Specificity: ' + string(avgSpecificity));
    disp('Average Accuracy: ' + string(avgAccuracy));

    % Write results to a file
    writecell(data, 'performance_metrics.csv');
end


