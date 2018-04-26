alfabet = 'abcdefghijklmnopqrstuvwxyz';
datadir = '../datasets/home3';

a = dir(datadir);

file = 'im1';

fnamebild = [datadir filesep file '.jpg'];
fnamefacit = [datadir filesep file '.txt'];

bild = imread(fnamebild);
fid = fopen(fnamefacit);
facit = fgetl(fid);
% % fclose(fid);

%% Train OCR and save in classification_data
%load 'ocrfeaturestrain';
%mdl = fitcknn(X', Y);
load 'ocrsegments';
mdl = ocr_train(S,y,16);
save('classification_data', 'mdl');

% Load the data from the training of the classifier
%load classification_data


%% Try out the segmentation
S = im2segment_2(bild);
% followed by feature extraction for one of the segments
B = S{1};
x = segment2features_2(B);
% followed by classification of the feature
y = features2class(x',mdl);
y
alfabet(y)
%%
if 1,
    figure(1); colormap(gray);
    for k = 1:5;
        imagesc(S{k});
        title(['Classified as class nr: ' num2str(y) ' which corresponds to the character ' upper(alfabet(y))]);
        %disp('tryck p� en tangent');
        pause;
    end;
end;
