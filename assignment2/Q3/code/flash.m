tic

%
% Flash
%
%

%setup original and noisy version of moving image
original_flash = imread('../input/flash1.jpg');
%grayscale
original_flash = rgb2gray(original_flash);
%original_flash = original_flash(1:256,1:256);

noisy_flash = imread('../input/noflash1.jpg');
%grayscale
noisy_flash = rgb2gray(noisy_flash);
%noisy_flash = noisy_flash(1:256,1:256);
noisy_flash = addNoise(noisy_flash,23.5,-3, 8);

%pad original image
[x_orig,y_orig] = size(original_flash);
[x_noisy,y_noisy] = size(noisy_flash);
%for odd sizevalues
x_pad_pre = double( idivide(int16(x_noisy-x_orig),2) );
x_pad_post = (x_noisy-x_orig) - x_pad_pre;
y_pad_pre = double( idivide(int16(y_noisy-y_orig),2) );
y_pad_post = (y_noisy-y_orig) - y_pad_pre;

original_flash = padarray(original_flash, [x_pad_pre y_pad_pre],'pre');
original_flash = padarray(original_flash, [x_pad_post y_pad_post],'post');

figure(5)
imshow(original_flash);
title('original');
size(original_flash)

figure(6)
imshow(noisy_flash);
title('noisy');
size(noisy_flash)

%brute force range
angles = [-60:60];
x_translation = [-12:12];

% get joint entropy
Entropy = zeros(size(angles,2),size(x_translation,2));

im1 = original_flash;
im2 = noisy_flash;

for i = 1: size(angles,2)
    for j = 1:size(x_translation,2)
        im2_mod = rotateTranslate(im2, angles(i), x_translation(j));
        
        histogram = histcounts2(im1,im2_mod,10);
        distribution = histogram / numel(im1);
        %remove zeros for logarithmic calculations and is now 1D
        distribution_no_zeros = distribution(histogram > 0);
        Entropy(i,j) = -nansum(distribution_no_zeros.*log2(distribution_no_zeros));
    end
end

%plot joint entropy
figure(7);
surf(x_translation,angles,Entropy);
title('Joint Entropy');

%find smallest entropy
[min_entropy,idx] = min(Entropy(:));
[angle_idx, translation_idx] = ind2sub(size(Entropy),idx)
min_angle = angles(angle_idx)
min_translation = x_translation(translation_idx)
min_im2 = rotateTranslate(im2, min_angle,min_translation); 

figure(8)
imshow(min_im2);
title('estimation');

toc