function features = segment2features_2(I)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    [R, ~, size_r, ~] = rs_cim(I, 50);
    
    f1 = segment2features(R);
    
    Rstats2 = regionprops(logical(I),'EulerNumber');
    
    Rstats = ... 
        regionprops(logical(R),'Area','Centroid', ...
                    'EulerNumber', 'Extrema','Solidity');
    %
    f2 = [max(Rstats.Area), min(Rstats2.EulerNumber), max(Rstats.EulerNumber), max(Rstats.Solidity)];
    
    mser_obj = detectMSERFeatures(~logical(R), 'RegionAreaRange', [300 1000]);
    mser_count = mser_obj.Count;
    
    %[X Y] = perimxy(R);
    %[A, B, C, lerr, terr, f] = tlsfit(X, Y);
    %coeff = round([A, B, C]);
    
    features = [size_r f1 f2 mser_count];
    %hold on;
    %figure(i)
    %plot(Px, Py ,'bo');
    %[x y] = perimxy(R);
    %g2f = fit(x, y,'gauss2');
    %plot(f);
    %plot(Rstats.Extrema{1,1}(:,1), Rstats.Extrema{1,1}(:,2), 'r*');
    %features = [(coeffvalues(g2f)) f1];

end

