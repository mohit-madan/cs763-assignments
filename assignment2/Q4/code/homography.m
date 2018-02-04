function [ H ] = homography( p1, p2 )
%HOMOGRAPHY Summary of this function goes here
%   Detailed explanation goes here
   
    len_p1 = length(p1);
    M = zeros(2*len_p1,9);
    j=1;
    
    for i = 1:len_p1
        M(j,:) = [p1(i,:) 1 0 0 0 -p2(i,1)*[p1(i,:) 1] ];
        M(j+1,:) = [0 0 0 p1(i,:) 1 -p2(i,2)*[p1(i,:) 1] ];
        j=j+2;
    end

    [~,~,V] = svd(M);
    
    H = reshape(V(:,9),[3,3])';
end


