function [filterResponses] = extractFilterResponses(I, filterBank)

% I: an image with size H x W x 3
% filterBank: 4 (filters) x 5 (sizes) = 20 filters generated by
% createFilterBank() [20 1]

% apply filters on each of the colour channel of the image 3 x n = 3n {filter responses}
% returned matrix size: H x W x 3n {figure 7}

I = double(RGB2Lab(double(I)));
[H, W, s] = size(I);%[H   W    3]


%% apply the filters to each colour channel of the image
% the return size of the image should not change after convolution
% ----> padding
% ( filterBank is in type cell, A = cell2mat( C ) converts a cell array into an ordinary array )

[s1, ~] = size(filterBank); % [20 1], each filter is in different size, but odd x odd
filterResponses = zeros(H, W, s*s1); %[H   W     3*20]


% first store the results of the first color channel [L*]
% then [a*] and [b*]
for i = 1:s
    for j= 1:s1
     %  each colour channel * every filter
     %    temp = floor(size(cell2mat(filterBank(j,1)),1)/2); % a scalar
     %    padded = padarray(I(:,:,i),[temp temp],0,'both');   % a padded channel of I
     %    disp(size(cell2mat(filterBank(j,1))));
     %    disp(size(padded));
     %    conv2() with parameter same helps maintain the same size of image 
        filterResponses(:, :, i*j) = conv2( I(:,:,i), cell2mat(filterBank(j,1)) , 'same');
    end
end

%% show the filtered image for different channels
% show the filter size
for i = 1:s1
    disp(filterBank(i , 1));
end

% loop through and save the filter images
for i=1:s*s1
    save_path = '../result/';
    if mod(i, s1)==0
        path = [ save_path, 'q_1_1_channel_' num2str(ceil(i/ s1)) '_filterINDEX_' num2str(s1) '.jpg' ];  
    else
        path = [save_path, 'q_1_1_channel_' num2str(ceil(i/ s1)) '_filterINDEX_' num2str(mod(i, s1)) '.jpg' ];
    end
    
    imwrite(filterResponses(:, :, i), path);
end


%% 
% %% store the filtered image for channel 1 [L*], with gussian filter size [11 11]
% imwrite(filterResponses(:, :, 2),'../data/result/channe1_gussian11.jpg');
% 
% %% store the filtered image for channel 2 [a*], with gussian filter size [11 11]
% imwrite(filterResponses(:, :, 22),'../data/result/channe2_gussian11.jpg');
% 
% %% store the filtered image for channel 3 [b*], with gussian filter size [11 11]
% imwrite(filterResponses(:, :, 42),'../data/result/channe3_gussian11.jpg');

end