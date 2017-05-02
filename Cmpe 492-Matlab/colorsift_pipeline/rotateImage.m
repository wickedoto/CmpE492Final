clear ; close all; clc

load annotation

IMAGE_FULL_PATH = '~/Documents/MATLAB/colorsift/All-resized';
IMAGE_EXTENSION = '.jpg';
DATA_SET_SIZE = 1199;

%Create cell array to store full paths
fullPaths = cell(DATA_SET_SIZE, 1);
for i = 1:DATA_SET_SIZE
    file_name = strcat(annotation(i,1), '.jpg'); 
    full_path = fullfile(IMAGE_FULL_PATH, file_name);
    fullPaths{i} =  full_path{1};
end

% rotatedSparseSIFT = cell(1728, 1);
% k = 1;
% for i = 1:DATA_SET_SIZE
%     if origIdx(i,1) == 1
%         I = imread(fullPaths{i});
%         file_name = strcat(annotation(i,1), '.jpg'); 
%         for j=1:12
%             rotated = imrotate(I, 30*j);
%             path = strcat('rotated/',annotation(i,1)); 
%             path = strcat(path,'_'); 
%             path_rotated = strcat(path,int2str(30*j)); 
%             file_rotated = strcat(path_rotated,'.jpg'); 
%             file_rotated
%             imwrite(rotated,char(file_rotated));
%             [f,d] = computeSIFT(char(file_rotated), 'standart', 'sparse', i);
%             rotatedSparseSIFT{k} = {f, d};
%             k = k + 1;
%         end
%         if mod(i,50) == 0
%             disp(i)
%         end
%     end
% end

load features/sparseSIFT
load rotatedSparseSIFT
ransacResults = zeros(1199, 1199);
inlinerResults = zeros(1199, 1199);
matchResults = zeros(1199, 1199);

for i=1:1199
    if modiIdx(i,1) == 1 && rotIdx(i,1) == 1
        k = 1;
        for j=1:1199
            if origIdx(j,1) == 1
                accuracy_big = 0;
                inliner_big = 0;
                total_big = 0;
                for t = 1:12
                    [accuracy, inliner, total] = applyRansac(rotatedSparseSIFT{k},sparseSIFT(i,:));
                    if accuracy > accuracy_big
                        accuracy_big = accuracy;
                        inliner_big = inliner;
                        total_big = total;
                    end
                    k = k + 1;
                end
                ransacResults(i,j) = accuracy_big;  
                inlinerResults(i,j) = inliner_big;    
                matchResults(i,j) = total_big; 
            end
        end
    end
    if mod(i,50) == 0
        disp(i);
    end
end


for i=1:1199
    for j=1:1199
        if inlinerResults(i,j) < 13
            ransacResults(i,j) = 0;
        end
    end
end


topResults = zeros(1199,2);
for i=1:1199
    if modiIdx(i,1) == 1
        [sortedResults, sortIdx] = sort(ransacResults(i, :), 'descend');
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