
%%call createFilterBank()
filterBank = createFilterBank();
%disp(size(filterBank)); % = [20 1]
Im = imread('../data/desert/sun_adpbjcrpyetqykvt.jpg');
% the following function will convert the color space of Im from RGB to Lab
filterResponses=extractFilterResponses(Im, filterBank);
