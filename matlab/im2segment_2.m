function [ S ] = im2segment_2(im)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
old = im;
origin_m = mean(im(:)); 
mcolor =  origin_m * (3/4);
im(im < mcolor) = 1;
im(im >= mcolor) = 0; 
im = im*255;    


%labeled the image, and threshold wrong labels
bwl = labelchar(im);
im = bwl.img;
num = bwl.num;

for kk = 1:num
    temp = im;
    temp(temp ~= kk) = 0;
    temp(temp == kk) = 255;
    
    S{kk} = temp;
end

end

