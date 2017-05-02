% Ilhan Adiyaman
% 2015700000
% 21.04.2015
%
% Bu dosyada zaten SIFT'ler hesaplanm?? ve mat dosyas? olarak
% kaydedilmi? olarak varysad?m.
%
% S?rayla RANSAC ile matching yap?p sonu?lar? hesaplamak i?in
% kullan?yorum.

clear ; close all; clc
% 
% Load annotation data from prepared mat file
load annotation
% 
% 
% 
% Load descriptors of all dataset
%load features/sparseSalientOPPONENTSIFT(uint8)
%load features/sparseSalienceSIFT
%load features/sparseOPPONENTSIFT(uint8)
%load features/sparseCSIFT
%load features/sparseSIFT

% t = cputime;
% ransacResults = zeros(1199, 1199);
% inlinerResults = zeros(1199, 1199);
% matchResults = zeros(1199, 1199);
% for i=1:1199
%     if modiIdx(i,1) == 1
%         for j=1:1199
%             if origIdx(j,1) == 1             
%                 %[accuracy, inliner, total] = applyRansac(denseSIFT(j,:),denseSIFT(i,:));
%                 tic;
%                 [accuracy, inliner, total] = applyRansac(sparseSIFT{j},sparseSIFT{i});
%                 %[accuracy, inliner, total] = applyRansac(sparseSIFT(j,:),sparseSIFT(i,:));
%                 toc;
%                 ransacResults(i,j) = accuracy;  
%                 inlinerResults(i,j) = inliner;    
%                 matchResults(i,j) = total; 
%             end
%         end
%     end
%     if mod(i,50) == 0
%         disp(i);
%     end
% end
% e = cputime-t


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


