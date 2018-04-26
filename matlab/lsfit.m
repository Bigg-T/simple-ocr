function [ my_y ] = lsfit( x,y )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

N = length(x);
%calculation needed to construct the matrix
xxs = sum(x.^2);
yys = sum(y.^2);
xs = sum(x);
ys = sum(y);
xys = sum(x.*y);
kl = (inv([xxs xs; xs N])) * [xys; ys]; % [slope yintecept]
xi1 = [x; (ones(1,N))]';
my_y = (xi1*kl);

end

