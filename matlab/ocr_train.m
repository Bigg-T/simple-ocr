function [model] = ocr_train(imgs, classify_data, featCount)
%ocr_train training the data
%   return a model of the trained data
N = max(size(segment2features_2(imgs{1})));
data = zeros(length(classify_data), N);
for i = 1:length(classify_data)
    data(i,:) = segment2features_2(imgs{i}*255); 
end
%SVM for multi class
%model = fitcecoc(data,classify_data);
%data
model = fitcknn(data,classify_data);
%model = fitcnb((data'), classify_data);
end

