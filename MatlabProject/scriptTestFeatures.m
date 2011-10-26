%% Load image
im = imread('../photos/img_0005.jpg');
[h,w,~] = size(im);

%% Feature locations
[X,Y] = meshgrid(5:20:w-5,5:20:h-5);

%% Extract features
%features = MopsDescriptors(im,X(:),Y(:));
features = GradHistDescriptors(im,X(:),Y(:));

%% test
idx = kmeans(features,8);
imagesc(reshape(idx,122,163));