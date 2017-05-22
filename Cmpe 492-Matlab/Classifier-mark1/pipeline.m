%% Data Initializations
image_dataset = init_dataset('model_1');
image_dataset_alex = init_dataset('alexnet');
%% Preprocessing for classification
minSetCount = min([imgSets.Count]);
% Use partition method to trim the set.
imgSets = partition(imgSets,minSetCount,'randomize');
[trainingSets, validationSets] = partition(imgSets, 0.3, 'randomize');
extractor = @getHogFeatures;
bag_hog = bagOfFeatures(trainingSets, 'CustomExtractor',extractor);
bag = bagOfFeatures(trainingSets);
%% Preprocessing for Alexnet
net = alexnet;
net.Layers;
image_dataset_alex.ReadFcn = @(filename)readAndPreprocessImage(filename);
tbl = countEachLabel(image_dataset_alex);
minSetCount_a = min(tbl{:,2}); 
%Use splitEachLabel method to trim the set.
image_dataset_alex = splitEachLabel(imds, minSetCount_a, 'randomize');
[trainingSet, validationSet] = splitEachLabel(image_dataset_alex, 0.7, 'randomize');
layer = 'fc7';
trainingFeatures = activations(net,trainingSet,layer);
testFeatures = activations(net,validationSet,layer);
trainingLabels = trainingSet.Labels;
testLabels = validationSet.Labels;
%% Training for classification
categoryClassifier = trainImageCategoryClassifier(trainingSets, bag);
categoryClassifier_hog = trainImageCategoryClassifier(trainingSets, bag_hog);
%% Training for Alexnet
classifier = fitcecoc(trainingFeatures, trainingLabels);
%% Evaluation of Classification
confMatrix_validation = evaluate(categoryClassifier, validationSets);
confMatrix_validation_hog = evaluate(categoryClassifier_hog, validationSets);
%% Evaluation of Alexnet
predictedLabels = predict(classifier, testFeatures);
confMat = confusionmat(testLabels, predictedLabels);
%% Accuracy Classification
accuracy_surf = mean(diag(confMatrix_validation));
accuracy_hog = mean(diag(confMatrix_validation_hog));
%% Accuracy Alexnet
confMat = bsxfun(@rdivide,confMat,sum(confMat,2))
mean(diag(confMat))