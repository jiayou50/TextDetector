function desc = MopsDescriptors(imrgb, X, Y)
%COMPUTEDESCRIPTORS MOPS descriptor

im = im2double(rgb2gray(imrgb));
[h, w] = size(im);
n = length(X);
desc = zeros(n, 64);

f = fspecial('gaussian', [6, 6], 6);
im = imfilter(im, f);

for i = 1 : n
    cx = X(i);
    cy = Y(i);
    for ix = 1 : 8
        x = min(w, max(1, round(cx + (ix-4.5)*5)));
        for iy = 1 : 8
            y = min(h, max(1, round(cy + (iy-4.5)*5)));
            desc(i, (iy-1)*8+ix) = im(y, x);
        end
    end
    desc(i,:) = (desc(i,:) - mean(desc(i,:))) / std(desc(i,:));
end