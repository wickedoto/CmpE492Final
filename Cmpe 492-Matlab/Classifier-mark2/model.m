%% Model preparations
net = alexnet;
Layers = net.Layers;
[dataset, originals] = init_dataset('alexnet');
Labels = dataset.Labels;
load categories;
load original_categories
dataset.ReadFcn = @(filename)readAndPreprocessImage(filename);
training_layer = 'fc7';
%% Create new Dataset
mkdir('Dataset');
cd Dataset;
for i=1:numel(categories)
    name = char(categories(i));
    mkdir(name);
end
cd ..;
%% Original Dataset Location
mkdir('originals');
cd originals;
for i=1:numel(original_categories)
    name = char(original_categories(i));
    mkdir(name);
end
cd ..;
%% File Resizing
for index =1:numel(categories)
    sub_data = dataset.Files(logical(dataset.Labels == char(categories(index))));
    foldername = strcat('Dataset/',char(categories(index)),'/');
    for i = 1:numel(sub_data)
        I = readAndPreprocessImage(char(sub_data(i)));
        [pathstr,name,ext] = fileparts(char(sub_data(i))); 
        imwrite(I, [foldername strcat(name,ext)]);
    end
end
%% Original File Resizing
%% File Resizing
for index =1:numel(original_categories)
    sub_data = originals.Files(logical(originals.Labels == char(original_categories(index))));
    foldername = strcat('originals/',char(original_categories(index)),'/');
    for i = 1:numel(sub_data)
        I = readAndPreprocessImage(char(sub_data(i)));
        [pathstr,name,ext] = fileparts(char(sub_data(i))); 
        imwrite(I, [foldername strcat(name,ext)]);
    end
end
%% Creation of the new data
[new_dataset, originals] = init_dataset('model_2','full');
load training_features
load original_features_all
%% Feature Extraction
%original_features = activations(net,originals,training_layer);
all_training_features = activations(net,new_dataset,training_layer);
%% load all_training_features
Generic_data = [];
Generic_data_mark2 = [];
Generic_labels = [];
global_index = 1;
for index=1:numel(original_categories(1:7)) % Original Category Selection
    org_feature = original_features(index,:);
    for cat=1:numel(categories(1:8)) % Pairwise Category Selection
        data_x(1,:) = org_feature; % Original Feature vector
        sub_data = new_dataset.Files(logical(new_dataset.Labels == char(categories(cat)))); % Category Dataset
        sub_features = all_training_features(logical(new_dataset.Labels == char(categories(cat))),:); % Category feature vector set
        for dat=1:numel(sub_data)
            test_feature = sub_features(dat,:);
            Generic_data(:,:,global_index)= [org_feature; test_feature];
            Generic_data_mark2(global_index,:) = org_feature - test_feature;
            if(strcmp(char(original_categories(index)),char(categories(cat))))
                Generic_labels(global_index) = 1; 
            else
                Generic_labels(global_index) = 0;
            end
            global_index = global_index +1;
        end       
    end
end
%% Train test split
classifier = fitcecoc(Generic_data_mark2, Generic_labels);
%% Train the svm