function [ labeled ] = labelchar(bild)
%labelchar give different label logical segmented image
%   Threshold the region that could not be a image.
% return [(the labeled image) (total number of label)]

%label the connected region
[im, num] = bwlabel(logical(bild));
%get the area of the connected region
stats = regionprops(im,'Area');
%convert (areas) struct to array
carea = [stats.Area];
%thresholding the bad segment
threshold = mean(carea) * (1/3);
junk = find(carea < threshold);
if (length(junk) > 0)
    for i = 1:length(junk)
        im(im == junk(i)) = 0; % junk region -> set region to 0
    end
end
bad_holes = ceil(threshold*0.25);
im = bwareaopen(~logical(im), bad_holes,4);

[im, num] = bwlabel(~im); %relabel num is the number of label

labeled = struct('img', im, 'num', num);
end

