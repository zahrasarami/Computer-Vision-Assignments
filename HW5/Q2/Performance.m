function [TP, TN, FP, FN] = performance(predicted, groundTruth)
    % Convert images to binary
    predicted = logical(predicted);
    groundTruth = logical(groundTruth);

    % Calculate True Positives, True Negatives, False Positives, False Negatives
    TP = sum(predicted & groundTruth, 'all');
    TN = sum(~predicted & ~groundTruth, 'all');
    FP = sum(predicted & ~groundTruth, 'all');
    FN = sum(~predicted & groundTruth, 'all');
end