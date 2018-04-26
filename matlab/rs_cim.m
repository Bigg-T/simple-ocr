function [im, p_height, sp, feat] = rs_cim(img, imh)
%rs_cim resize image of a segmented img of a character
%   Detailed explanation goes here
    img = logical(img);
    stat = regionprops(img,'SubarrayIdx','Orientation', 'EulerNumber');
    sr = stat.SubarrayIdx;
    sr1 = sr{1}; % row -> y ->height
    sr2 = sr{2}; % col -> x -> width
    
    % find the height and width
    width = diff([sr2(1) sr2(end)]);
    height = diff([sr1(1) sr1(end)]);
    
    %the porprotional heights
    p_height = round((imh * width) / height);
    
    %resize image
    img_char = logical(img(sr1, sr2));
    im = imresize(img_char, [imh p_height])*255;
    
    %ratio of image
    sp = (width - height) * (height/ width);
    
    %feat before distored
    feat = [max(stat.Orientation), min(stat.EulerNumber), max(stat.EulerNumber)];
    
end

