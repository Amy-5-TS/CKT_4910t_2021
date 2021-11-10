


I1 = imread('../data/desert/sun_adpbjcrpyetqykvt.jpg');
I2 = imread('../data/bedroom/sun_aaxfqfzrjwrlfwuf.jpg');
I3 = imread('../data/rainforest/sun_absitpbkzyrvmnem.jpg');

%% get random points from the image
alpha = 100;
points = getRandomPoints(I, alpha);
disp(points);


%% get Harris corner detected points from the image
k=0.05;
[points1] = getHarrisPoints(I1, alpha, k);
[points2] = getHarrisPoints(I2, alpha, k);
[points3] = getHarrisPoints(I3, alpha, k);



%% plot the first image
figure 
imshow(I1); 
hold on; 
plot(points1(:, 2), points1(:, 1), 'x');

%% plot the second image

figure 
imshow(I2); 
hold on; 
plot(points2(:, 2), points2(:, 1), 'x');

%% plot the third image

figure 
imshow(I3); 
hold on; 
plot(points3(:, 2), points3(:, 1), 'x');
