%function [ desc ] = GradHistDescriptors( imrgb, X, Y )
%GRADHISTDESCRIPTORS Compute histogram of gradients at given locations.

imrgb = imread('../photos/isr.jpg');

im = im2double(rgb2gray(imrgb));
[h,w] = size(im);
n = size(X);

gradx = imfilter(im,[-1,0,1]);
grady = imfilter(im,[-1;0;1]);
% Magnitude of the gradient vector
mag = sqrt(gradx.^2 + grady.^2);
% Angle of the gradient vector
% starts from pointing downwards (0,1) and goes counter-clockwise
ang = asin(grady./max(1e-8,mag)) + pi*(gradx<0) + pi/2;

%%
imagesc(ang.*(mag>0.05));
%colormap('gray');