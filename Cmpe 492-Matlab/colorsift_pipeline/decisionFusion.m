load annotation
load('/Users/ilhan/Documents/MATLAB/colorsift/results/salient-sparse-opponentsift-ransac-onlyO/results.mat')

load('/Users/ilhan/Documents/MATLAB/colorsift/bovw/fc7_matchResults.mat')

topResults = zeros(1199,2);
for i=1:1199
    if modiIdx(i,1) == 1
        [sortedResults_ransac, sortIdx_ransac] = sort(ransacResults(i, :), 'descend');
        [sortedResults_fc7, sortIdx_fc7] = sort(matchResults(i, :), 'ascend');
        if strcmp(annotation(i,3),annotation(sortIdx_ransac(1),1)) > 0
            topResults(i,1) = 1;
        end
        % Get top-5
        for j=1:5
            if strcmp(annotation(i,3),annotation(sortIdx_ransac(j),1)) > 0
                topResults(i,2) = 1;
            end
        end
    end
end

accuracies = zeros(13,2);
for i=1:13
    accuracies(i,1) = sum(topResults(logical(annotation_numerical(:,i+1)),1))/size(topResults(logical(annotation_numerical(:,i+1)),1),1);
    accuracies(i,2) = sum(topResults(logical(annotation_numerical(:,i+1)),2))/size(topResults(logical(annotation_numerical(:,i+1)),1),1);
end