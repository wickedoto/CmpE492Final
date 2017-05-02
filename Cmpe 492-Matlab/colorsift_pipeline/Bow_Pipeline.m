% clear ; close all; clc
% 
% Load annotation data from prepared mat file
load annotation

% for i=1:1199
%     for j=1:1199
%         if matchResults(i,j) == 100
%             matchResults(i,j) = 10000;
%         end
%     end
% end


topResults = zeros(1199,2);
for i=1:1199
    if modiIdx(i,1) == 1
        [sortedResults, sortIdx] = sort(matchResults(i, :), 'ascend');
        if strcmp(annotation(i,3),annotation(sortIdx(1),1)) > 0
            topResults(i,1) = 1;
        end
        % Get top-5
        for j=1:5
            if strcmp(annotation(i,3),annotation(sortIdx(j),1)) > 0
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
