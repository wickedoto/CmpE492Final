categories = {'american_gothic_parody',...
                'arnolfinis_wedding_parody',...
                'birth_of_venus_parody',...
                'death_of_marat_parody',...
                'girl_with_a_pearl_earring_parody',...
                'las_meninas_parody',...
                'last_supper_parody',...
                'melting_watches_the_persistence_of_memory_parody',...
                'mona_lisa_parody',...
                'munch_scream_parody',...
                'seurat_sundey_afternoon_on_la_grande_jatte_parody'};
project_path = '/Users/yigitozgumus/Desktop/Cmpe492/CmpE492Final/Cmpe 492-Matlab/Classifier-mark1';
imgSets = [ imageSet(fullfile( '/Users/yigitozgumus/Desktop/Cmpe492/CmpE492Final/Cmpe 492-Matlab/Classifier-mark1\data', 'american_gothic_parody')), ...
 imageSet(fullfile('/Users/yigitozgumus/Desktop/Cmpe492/CmpE492Final/Cmpe 492-Matlab/Classifier-mark1\data', 'arnolfinis_wedding_parody')), ...
 imageSet(fullfile('/Users/yigitozgumus/Desktop/Cmpe492/CmpE492Final/Cmpe 492-Matlab/Classifier-mark1\data', 'birth_of_venus_parody')), ...
 imageSet(fullfile('/Users/yigitozgumus/Desktop/Cmpe492/CmpE492Final/Cmpe 492-Matlab/Classifier-mark1\data',  'death_of_marat_parody')), ...
 imageSet(fullfile('/Users/yigitozgumus/Desktop/Cmpe492/CmpE492Final/Cmpe 492-Matlab/Classifier-mark1\data',  'girl_with_a_pearl_earring_parody')), ...
 imageSet(fullfile('/Users/yigitozgumus/Desktop/Cmpe492/CmpE492Final/Cmpe 492-Matlab/Classifier-mark1\data',  'las_meninas_parody')), ...
 imageSet(fullfile('/Users/yigitozgumus/Desktop/Cmpe492/CmpE492Final/Cmpe 492-Matlab/Classifier-mark1\data',  'last_supper_parody')), ...
 imageSet(fullfile('/Users/yigitozgumus/Desktop/Cmpe492/CmpE492Final/Cmpe 492-Matlab/Classifier-mark1\data', 'melting_watches_the_persistence_of_memory_parody')), ...
 imageSet(fullfile('/Users/yigitozgumus/Desktop/Cmpe492/CmpE492Final/Cmpe 492-Matlab/Classifier-mark1\data',  'mona_lisa_parody')), ...
 imageSet(fullfile('/Users/yigitozgumus/Desktop/Cmpe492/CmpE492Final/Cmpe 492-Matlab/Classifier-mark1\data', 'seurat_sundey_afternoon_on_la_grande_jatte_parody')) ]; 

% determine the smallest amount of images in a category
minSetCount = min([imgSets.Count]);

% Use partition method to trim the set.
imgSets = partition(imgSets,minSetCount,'randomize');

[trainingSets, validationSets] = partition(imgSets, 0.3, 'randomize');



% Find the first instance of an image for each category
% americangothic = find(trainingSet.Labels == 'american_gothic_parody', 1);
% 
% figure
% 
% subplot(1,3,1);
% imshow(readimage(trainingSet,americangothic))

% extractor = @getHogFeatures;
% bag = bagOfFeatures(imageSet(trainingSet.Files), 'CustomExtractor',extractor);
%bag = bagOfFeatures(trainingSets);

% 
% img = readimage(imds, 1);
% figure
% imshow(img)
% featureVector = encode(bag, img);
% 
% % Plot the histogram of visual word occurrences
% figure
% bar(featureVector)
% title('Visual word occurrences')
% xlabel('Visual word index')
% ylabel('Frequency of occurrence')


%categoryClassifier = trainImageCategoryClassifier(trainingSets, bag);

%confMatrix1 = evaluate(categoryClassifier, trainingSets);

%confMatrix2 = evaluate(categoryClassifier, validationSets);

% Compute average accuracy
%mean(diag(confMatrix2));


%imds = imageDatastore(fullfile('/Users/yigitozgumus/Desktop/Cmpe492/CmpE492Final/Cmpe 492-Matlab/Classifier-mark1/data',categories), 'LabelSource', 'foldernames');
%tbl = countEachLabel(imds);
%minSetCount = min(tbl{:,2}); % determine the smallest amount of images in a category
% Use splitEachLabel method to trim the set.
%imds = splitEachLabel(imds, minSetCount, 'randomize');

% Notice that each set now has exactly the same number of images.
%countEachLabel(imds)

%[trainingSet, validationSet] = splitEachLabel(imds, 0.3, 'randomize');

%bag = bagOfFeatures(trainingSet);