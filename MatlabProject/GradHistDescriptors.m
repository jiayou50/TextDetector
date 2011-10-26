function [ desc ] = GradHistDescriptors( imrgb, X, Y )
%GRADHISTDESCRIPTORS Compute histogram of gradients at given locations.

% For testing
% imrgb = imread('../photos/isr.jpg');
% X = [2,6,43];
% Y = [65,4,100];

im = im2double(rgb2gray(imrgb));
[h,w] = size(im);
n = length(X);

gradx = imfilter(im,[-1,0,1]);
grady = imfilter(im,[-1;0;1]);

% Magnitude of the gradient vector
mag = sqrt(gradx.^2 + grady.^2);

% Angle of the gradient vector
% starts from pointing downwards (0,1) and goes counter-clockwise
ang = asin(grady./max(1e-8,mag)) + pi*(gradx<0) + pi/2;

% Hard assign each gradient to a bin according to its orientation
nBins = 8;
angIdx = max(1,ceil(ang/(2*pi/nBins)));

% Half window size
kWinRadius = 5;

% Compute descriptors at every given locations
desc = zeros(n,nBins);
for i = 1 : n
    xRange = max(1,X(i)-kWinRadius) : min(w,X(i)+kWinRadius);
    yRange = max(1,Y(i)-kWinRadius) : min(h,Y(i)+kWinRadius);
    subMag = mag(yRange,xRange);
    subAngIdx = angIdx(yRange,xRange);
    for j = 1 : nBins
        desc(i,j) = sum(subMag(subAngIdx==j));
    end
end
