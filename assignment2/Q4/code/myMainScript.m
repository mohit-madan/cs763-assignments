%% MyMainScript
clear all;

tic;
%% Your code here
input_img1 = imread('/home/sachin/GitRepos/cs763-assignments/assignment2/Q4/input/monument/1.JPG');
input_img1 = im2double(input_img1); 
figure
imshow(input_img1)
input_img2 = imread('/home/sachin/GitRepos/cs763-assignments/assignment2/Q4/input/monument/2.JPG');
input_img2 = im2double(input_img2); 
thresh=1000;

for j=1:3
    
    size_img1 = size(input_img1(:,:,j));
    
    imshow(input_img1(:,:,j))
    size_img2 = size(input_img2(:,:,j));
    points1 = detectSURFFeatures(input_img1(:,:,j));
    points2 = detectSURFFeatures(input_img2(:,:,j));

    [features1,pts1] = extractFeatures(input_img1(:,:,j),points1)
    [features2,pts2] = extractFeatures(input_img2(:,:,j),points2)

    indexPairs = matchFeatures(features1,features2);
    matchedPoints1 = pts1(indexPairs(:,1));
    matchedPoints2 = pts2(indexPairs(:,2));

    x1 = matchedPoints1.Location;
    x2 = matchedPoints2.Location;
    
%     figure; showMatchedFeatures(input_img1(:,:,j),input_img2(:,:,j),matchedPoints1,matchedPoints2);
%     legend('matched points 1','matched points 2');
    H = ransacHomography( x1, x2, thresh )   
    
    %% apply homography
    [h,w,d] = size(input_img1(:,:,j)); %%height and width 
    
    x_cord = meshgrid(1:w,1:h); %distorted - initial one
    y_cord = meshgrid(1:h,1:w)';  %distorted
    
    for i=1:h
        for r=1:w
            v = H*[x_cord(i,r); y_cord(i,r) ;1];
            v = v/v(3,1);
            xf_cord(i,r) = v(1,1);
            yf_cord(i,r) = v(2,1);
        end
    end
    
    rec_img1 = interp2(x_cord,y_cord,input_img1(:,:,1),xf_cord,yf_cord);
    rec_img1(isnan(rec_img1)) =0;
    subplot(2,2,3)
    imshow(rec_img1(:,:,1))
    title('im1 applied homography')
    %% making panorama
   
    I1 = rec_img1;
    I2 = input_img2(:,:,j);
    size1 = size(I1);
    size2 = size(I2);
    leftlimit = size1(2)*.75;
    rightlimit = size1(2);
    yd=round(size1(1)/7);
    j
    pano = zeros(size1(1)+yd,size1(2) + size2(2) - size1(2)*.25 );
    pano(yd+1:size1(1)+yd,1:leftlimit) = I1(:,1:leftlimit);
    size1
    pano(yd+1:size1(1),leftlimit+1:rightlimit) = 0.5*I1(1:size1(1)-yd,leftlimit+1:rightlimit) + .5*I2(yd+1:size2(1),1:size1(2)*.25);
    pano(1:size1(1),rightlimit:size1(2) + size2(2) - size1(2)*.25 ) = I2(:,size1(2)*.25:size2(2));
    
    subplot(2,2,j)
    imshow(pano)
    title('answer final')
    
    if(j==1)
        s = size(pano);
        final_image = zeros(s(1),s(2),3);
    end
    final_image(:,:,j) = pano;
end

subplot(2,2,4)
imshow(final_image)


toc;

