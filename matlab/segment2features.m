function features = segment2features(I)
% features = segment2features(I)
f1 = sum(I(:));
f3 = sum(I);
f2 = sum(I, 2);

%find the all the pixel in columns that contains a pixel of the character
non0xpos = find(f3 > 0);
%find the all the pixel in rows that contains a pixel of the character
non0ypos = find(f2 > 0);


xrang = [non0xpos(1), non0xpos(end)]; % [start, end] char  : x-range 
yrang = [non0ypos(1), non0ypos(end)]; % [start, end] char  : y-range

halfVert = ceil(sum(yrang) / 2);
halfHorz = ceil(sum(xrang) / 2);

halfFeat = [0 0];
halfFeat(1) = sum(sum(I(yrang(1):1:(halfVert -1), xrang(1):1:(halfHorz-1))));
halfFeat(2) = sum(sum(I(halfVert:1:yrang(2), halfHorz:1:xrang(2))));

thirdFeat = [0 0 0];

%{
sqFeat - sub region of image that contain the character
+---+---+
| 1 | 3
+---+---+
| 2 | 4
+---+---+
%}
sqFeat = [0 0 0 0];
sqF1 = sum(I(yrang(1):1:(halfVert -1), xrang(1):1:(halfHorz-1)));
sqF2 = sum(I(halfVert:1:yrang(2), xrang(1):1:(halfHorz-1)));
sqF3 = sum(I(yrang(1):1:(halfVert -1), halfHorz:1:xrang(2)));
sqF4 = sum(I(halfVert:1:yrang(2), halfHorz:1:xrang(2)));
sqFeat(1) = sum(sqF1);
sqFeat(2) = sum(sqF2);
sqFeat(3) = sum(sqF3);
sqFeat(4) = sum(sqF4);
sqF1N = norm(sqF1,'fro');
sqF2N = norm(sqF2,'fro');
sqF3N = norm(sqF3,'fro');
sqF4N = norm(sqF4,'fro');

my_sq16F = 0;
xint = floor(diff(xrang)/4);
yint = floor(diff(yrang)/4);
x1 = xrang(1);
y1 = yrang(1);

n1 = norm(f2, 'fro');
n2 = norm(sum(I), 'fro');
feat = detectMinEigenFeatures(I);
met = feat.Metric;
floc = feat.Location;

%features = cat(f1, n1, sum(f2), n2, feat.Count,halfFeat(1), halfFeat(2));
features = [f1, n1, sum(f2), n2,sqFeat(1)+sqFeat(3),sqFeat(2)+sqFeat(4),sqFeat(1)+sqFeat(2),sqFeat(4)+sqFeat(3),sqFeat(1), sqFeat(2), sqFeat(3), sqFeat(4),sqF1N,sqF2N,sqF3N,sqF4N];
%features = [n2, sqFeat(1)+sqFeat(3),sqFeat(2)+sqFeat(4),sqFeat(1)+sqFeat(2),sqFeat(4)+sqFeat(3),sqFeat(1), sqFeat(2), sqFeat(3), sqFeat(4),sqF1N,sqF2N,sqF3N,sqF4N];
%[u,s,v]=svd(allX);
%features = u(:,1:2)'*allX;
%{
for i = 1:4
    ys = y1 + ((i-1)*yint); % y start
    ye = y1 + ((i)*yint); % y end
    for j = 1:4
        xs = x1 + ((j-1)*xint);
        xe = x1 + ((j)*xint);
        t_img = I(ys:1:ye, xs:1:xe);
        %sub_nor = norm(sub, 'fro')
        my_idx = (i-1)*4 + j - 1;
        m_img = norm(sum(t_img),'fro');
        %my_sq16F(my_idx) = ;
        % = sum(t_img)
        %features(:, end) = m_img;
    end
end


[a,b] = size(met);
for i = 1:a
    %
    %features(:, end) = floc(i,1);
    %features(:, end) = floc(i,2);
end
%}
end