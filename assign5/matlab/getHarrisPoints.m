function [points] = getHarrisPoints(I, alpha, k)
[H, ~, ~] = size(I);

%% first, convert the image into gray scale

I = double(rgb2gray(I)); % converted to the gray scale intensity image


%% get the image gradients, (x and y)
% Using Sobel gradient operator
[Gx,Gy] = imgradientxy(I);
%imshowpair(Gx,Gy,'montage')
%title('Directional Gradients Gx and Gy, Using Sobel Method')
[Ixx, Ixy] = imgradientxy(Gx);
[Iyx, Iyy] = imgradientxy(Gy);

 %% M is the sum of Ixx...,etc in the window
 sumM = ones(3, 3);
 Mxx = reshape(conv2(Ixx, sumM, 'same'),[],1);
 Myx = reshape(conv2(Iyx, sumM, 'same'),[],1);
 Mxy = reshape(conv2(Ixy, sumM, 'same'),[],1);
 Myy = reshape(conv2(Iyy, sumM, 'same'),[],1);
 detM = Mxx(:,1).*Myy(:,1)-Mxy(:,1).*Myx(:,1);
 ktrM = k*(Mxx(:,1) + Myy(:,1)).^2;
 R = detM - ktrM;
%% get the k biggest
[~,idx]=sort(R,'descend');
% get back the index in matrix
a = idx(1:alpha,1);
points = [a-H*(ceil(a/H)-1),ceil(a/H)];

end
 
%% {thrashed} pad the matrix for the window, every pixel has a window, after cnvolution, get one value
% choose the windiw size to be 3 x 3
% Gx = padarray(Gx,[1 1],'both');
% Gy = padarray(Gy,[1 1],'both');
% for i=2:H+1
%     for j=2:W+1
%         Ixx=conv2(Gx(i-1:i+1, i-1:i+1),Gx(i-1:i+1, i-1:i+1), 'valid');
%         Ixy=conv2(Gx(i-1:i+1, i-1:i+1),Gy(i-1:i+1, i-1:i+1), 'valid');
%         Iyx=conv2(Gy(i-1:i+1, i-1:i+1),Gx(i-1:i+1, i-1:i+1), 'valid');
%         Iyy=conv2(Gy(i-1:i+1, i-1:i+1),Gy(i-1:i+1, i-1:i+1), 'valid');
%         M = [Ixx Iyx; Ixy Iyy];
%         
%     end
% end
% a = conv2(Gx(1:3, 1:3),Gx(1:3, 1:3), 'valid');
% disp(Gx(1:3, 1:3));
% disp(a);
%% calculate the response function from the covariance matrix




