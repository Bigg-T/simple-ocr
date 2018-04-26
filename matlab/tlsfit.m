function [A, B, C, lerr, terr, fit] = tlsfit(x, y)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

f = @(a, b, c) sum(a.*x + b.*y+c); % minimize function

N = length(x);
%calculation needed to construct the matrix
xxs = sum(x.^2);
yys = sum(y.^2);
xs = sum(x);
ys = sum(y);
xys = sum(x.*y);

findc = @(a,b) -(1/N)*(a*xs + b*ys); %calc c
% construct the matrix derived from Lagrange function's partial derivative
a11 = xxs - (1/N)*xs*xs;
a12 = xys-(1/N)*xs*ys;
a21 = xys - (1/N)*xs*ys;
a22 = yys - (1/N)*ys*ys;

A = [a11, a12; a21, a22]; 
[V, ~] = eig(A);
eig1 = V(:,1); %eig values 1 - solution 1
eig2 = V(:,2); %eig values 2 - solution 2

%a1, b1
ab1 = A*eig1;
a1 = ab1(1);
b1 = ab1(2);
c1 = findc(a1,b1);

ab2 = A*eig2; %a2 b2
a2 = ab2(1);
b2 = ab2(2);
c2 = findc(a2,b2);

fit1 = -(a1*x/b1) - c1/b1;
fit2 = -(a2*x/b2) - c2/b2;

% is the minimun, therefore it's the total least squared
isC1less = f(a1,b1,c1) < f(a2,b2,c2);
if (isC1less)
    A = a1;
    B = b1;
    C = c1;
    fit = -(a1*x/b1) - c1/b1;
    % The least square error (sum of squared vertical errors)
    lerr = sum((abs(y - fit)).^2);
    % The total least square error (sum of squared orthogonal errors)
    terr = sum((abs(a1*x + b1*y + c1) ./ sqrt((a1^2) + (b1^2))).^ 2);
else
    A = a2;
    B = b2;
    C = c2;
    fit = -(a2*x/b2) - c2/b2;
    % The least square error (sum of squared vertical errors)
    lerr = sum((abs(y - fit)).^2);
    % The total least square error (sum of squared orthogonal errors)
    terr = sum((abs(a2*x + b2*y + c2) ./ sqrt((a2^2) + (b2^2))).^ 2);
end

end

