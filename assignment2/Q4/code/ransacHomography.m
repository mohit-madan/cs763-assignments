function [ H ] = ransacHomography( x1, x2, thresh )
%RANSACHOMOGRAPHY Summary of this function goes here
%   Detailed explanation goes here

Numb_points = length(x1)
iter = 10; %can also be assumed to be p^-k, but  keeping hyper parameter as of now 
max_inliers =0;
best_Ht = rand(3,3)



for i= 1:iter
    x1 = x1(:,1:2);
    x2 = x2(:,1:2);
    %select the random 4 indexes fo =computing the homography matrix
    randSamp = randi(Numb_points,4,1);
    randx1 = x1(randSamp,:);
    randx2 = x2(randSamp,:);
    
    Ht = homography(randx1,randx2);
    'size of homography'
    size(Ht)
    
    onev = ones(Numb_points,1);     %added ones to compute homography matrix
    x1(:,3) = onev;
    x2(:,3) = onev;
    
    estimatedx2 = Ht*x1';
    lastrow = estimatedx2(3,:);
    div = [lastrow;lastrow;lastrow];
    estimatedx2 = estimatedx2./div;
    estimatedx2 = estimatedx2';
    
    sqError = (x2 - estimatedx2).^2;
    'size of error matrix'
    size(sqError)
    sqError = sum(sqError,2)
    size(sqError)
    inliers = sqError < thresh;
    num_inliers = sum(inliers,1)
    'vsfvsfvs'
    
    max_inliers = max(max_inliers,num_inliers);
    if(max_inliers == num_inliers)
        best_Ht = Ht;
    end    
end
   
H=best_Ht
end

