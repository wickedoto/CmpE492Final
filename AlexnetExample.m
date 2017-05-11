net = alexnet;
net.Layers;

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
                'seurat_sundey_afternoon_on_la_grande_jatte_parody',...
                'randomImages'};
            
imds = imageDatastore(fullfile('C:\Users\Cagla Aksoy\Desktop\Bitirme Projesi\Classifier-mark1\data',categories), 'LabelSource', 'foldernames');

% Set the ImageDatastore ReadFcn
imds.ReadFcn = @(filename)readAndPreprocessImage(filename);

tbl = countEachLabel(imds);
minSetCount = min(tbl{:,2}); % determine the smallest amount of images in a category

%Use splitEachLabel method to trim the set.
imds = splitEachLabel(imds, minSetCount, 'randomize');
%countEachLabel(imds);

[trainingSet, validationSet] = splitEachLabel(imds, 0.7, 'randomize');

layer = 'fc7';
trainingFeatures = activations(net,trainingSet,layer);
testFeatures = activations(net,validationSet,layer);

trainingLabels = trainingSet.Labels;
testLabels = validationSet.Labels;

% Train multiclass SVM classifier using a fast linear solver, and set
% 'ObservationsIn' to 'columns' to match the arrangement used for training
% features.
classifier = fitcecoc(trainingFeatures, trainingLabels);

% Pass CNN image features to trained classifier
predictedLabels = predict(classifier, testFeatures);


% Tabulate the results using a confusion matrix.
confMat = confusionmat(testLabels, predictedLabels);

% Convert confusion matrix into percentage form
confMat = bsxfun(@rdivide,confMat,sum(confMat,2))

% Display the mean accuracy
mean(diag(confMat))

% 
% idx = [1 4 7 10];
% figure
% for i = 1:numel(idx)
%     subplot(2,2,i)
% 
%     I = readimage(validationSet,idx(i));
%     label = predictedLabels(idx(i));
% 
%     imshow(I)
%     title(char(label))
%     drawnow
% end

