function [S] = im2segment_3(im)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
old = im;
old_m = mean(im(:))* (.80);

% under approximate
im(im < 120) = 1;
im(im >= 120) = 0;
im = im*255;

%fill the neighbors
[cx, cy] = perimxy(im);
%xdir = [0 1 1 1]; % N NE E SE (negative will be the west)
%ydir = [-1 -1 0 1]; % N NE E SE 
xdir = [0 1 ]; % N NE E SE (negative will be the west)
ydir = [-1 0]; % N NE E SE
for i = 1:max(size(cx)) 
    for dir = 1:2
        % east side 
        x1 = cx(i) + xdir(dir);
        y1 = cy(i) + ydir(dir);
        if (x1 > 0) && (y1 > 0) && (im(x1, y1) ~= 255) && (old(x1,y1) < old_m)
            im(x1,y1) = 255;
        end
        
        % west side
        x1 = cx(i) - xdir(dir);
        y1 = cy(i) - ydir(dir);
        if (x1 > 0) && (y1 > 0) && (im(x1, y1) ~= 255) && (old(x1,y1) < old_m)
            im(x1,y1) = 255;
        end
    end
end

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

