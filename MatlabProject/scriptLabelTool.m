%% Choose files to label
[filename,pathname] = uigetfile('*.*','Pick files','MultiSelect','on');
nFiles = length(filename);
if (~iscell(filename))
    nFiles = 1;
    filename = {filename};
end
for i = 1 : nFiles
    filename{i} = fullfile(pathname,filename{i});
end

%% Open each file for labeling
regionid = 1;
regionpath = './Data/';
for i = 1 : nFiles
    % Show up image
    im = imread(filename{i});
    clf;
    imshow(im);
    hold on;
    % Ask for areas to extract
    while (true)
        [x,y] = ginput(2);
        x = round(x);
        y = round(y);
        plot(x,y,'r*');
        if (length(x)~=2)
            break;
        end
        % Write out selected area
        region = im(min(y):max(y),min(x):max(x),:);
        while (true)
            regionname = fullfile(regionpath,[int2str(regionid),'.jpg']);
            if (~exist(regionname,'file'))
                break;
            end
            regionid = regionid + 1;
        end
        imwrite(region,regionname,'jpg');
    end
end
