function y = features2class(x,data);


y = predict(data,x');
%[y, ~] = predict(data,x');
