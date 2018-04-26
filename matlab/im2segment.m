function [S] = im2segment(im)
% [S] = im2segment(im)

% nrofsegments = 5;% original num was 4
m = size(im,1);
n = size(im,2);

%sum all pixel the column and create an 
total = sum(im) > (249*m);
%
seg_range = find(total<1);
seg_pos = find(diff(seg_range) > 1); % indice is relative to seg_range
[~, col] = size(seg_pos);
seg = []; % [start end]

%total using difference to determine seg, last seg doesn't have diff, so
%add 1 to include the last segment
nrofsegments = col + 1; 

% under aproximate with segmentation of char, go wider by 2pixel on R/L side
% to compansate for earlier computation
% the first and last segment handle differently
seg(1,1) = seg_range(1,1) - 2;
seg(1,2) = seg_range(1,seg_pos(1,1)) + 2;
for i = 2:col 
    % plus is next in the give index of prev
    seg(i,1) = seg_range(1,seg_pos(1,i-1) + 1) - 2;
    seg(i,2) = seg_range(1, seg_pos(1,i)) + 2;
end
seg(col+1,1) = seg_range(1,seg_pos(1,col) + 1) - 2;
seg(col+1,2) = seg_range(1, end) + 2;

%modify the matrix to show a specific of segment of a picture
for kk = 1:nrofsegments
    copy = im;
    %getting the range of where the letters in the picture
    start_seg = seg(kk,1);
    end_seg = seg(kk,2);
    
    %invert bg color - the inactive part of the picture to black
    copy(:, 1:start_seg) = copy(:, 1:start_seg)*0;
    copy(:, end_seg:end) = copy(:, end_seg:end)*0;
    
    %invert color of char - but will have gray scaling 
    copy(:, (start_seg + 1):(end_seg - 1)) = 255 - copy(:, (start_seg + 1):(end_seg - 1));
    %use boolean comparison to weather pixel is black or white, 1 should be
    %white, so multiply by 255 to complete white out the all pixel part of
    %the character
    copy(:, (start_seg + 1):(end_seg - 1)) = 255*(copy(:, (start_seg + 1):(end_seg - 1)) > 120);
    
    %final answer of result of the picture
    S{kk} = copy;
end
