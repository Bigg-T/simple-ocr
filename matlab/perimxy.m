function [X, Y] = perimxy(bild)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
[Y, X] = find(bwperim(bild));

%{
this method is slower
B = bwboundaries(I1);
Y = B{1}(:,1);
X = B{1}(:,2);
%}
end

