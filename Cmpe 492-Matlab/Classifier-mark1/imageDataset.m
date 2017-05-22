imgSets = init_dataset('model_1');

% determine the smallest amount of images in a category
minSetCount = min([imgSets.Count]);

% Use partition method to trim the set.
imgSets = partition(imgSets,minSetCount,'randomize');

[trainingSets, validationSets] = partition(imgSets, 0.3, 'randomize');
[trainingSets_m2, validationSets_m2] = partition(imgSets, 0.7, 'randomize');
extractor = @getHogFeatures;
bag_hog = bagOfFeatures(trainingSets, 'CustomExtractor',extractor);
bag = bagOfFeatures(trainingSets);


categoryClassifier = trainImageCategoryClassifier(trainingSets, bag);
categoryClassifier_hog = trainImageCategoryClassifier(trainingSets, bag_hog);
confMatrix_training = evaluate(categoryClassifier, trainingSets);
confMatrix_validation = evaluate(categoryClassifier, validationSets);

confMatrix_training_hog = evaluate(categoryClassifier_hog, trainingSets);
confMatrix_validation_hog = evaluate(categoryClassifier_hog, validationSets);

% Compute average accuracy
accuracy_surf = mean(diag(confMatrix_validation));
accuracy_hog = mean(diag(confMatrix_validation_hog));

categoryClassifier_m2 = trainImageCategoryClassifier(trainingSets_m2, bag);
categoryClassifier_hog_m2 = trainImageCategoryClassifier(trainingSets_m2, bag_hog);
%imds = imageDatastore(fullfile('/Users/yigitozgumus/Desktop/Cmpe492/CmpE492Final/Cmpe 492-Matlab/Classifier-mark1/data',categories), 'LabelSource', 'foldernames');
%tbl = countEachLabel(imds);
%minSetCount = min(tbl{:,2}); % determine the smallest amount of images in a category
% Use splitEachLabel method to trim the set.
%imds = splitEachLabel(imds, minSetCount, 'randomize');

% Notice that each set now has exactly the same number of images.
%countEachLabel(imds)

%[trainingSet, validationSet] = splitEachLabel(imds, 0.3, 'randomize');

%bag = bagOfFeatures(trainingSet);