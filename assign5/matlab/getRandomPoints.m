function [points] = getRandomPoints(I, alpha)
    [H, W, ~] = size(I);
    points = [randi(H, alpha,1), randi(W, alpha,1)];
end

