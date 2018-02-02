%
% Experiment
%
%

%rotations = [30:10:60];
rotation = 125;
%rotation = 90;
translation = 0;
%noises = [10:10:80]
noises = [8]

for noise = noises

    %setup original and noisy version of moving image
    original_barbara = imread('../input/barbara.png');
    noisy_barbara = imread('../input/negative_barbara.png');
    noisy_barbara = addNoise(noisy_barbara,rotation,translation,noise);

    %pad original image
    [x_orig,y_orig] = size(original_barbara);
    [x_noisy,y_noisy] = size(noisy_barbara);
    %for odd sizevalues
    x_pad_pre = double( idivide(int8(x_noisy-x_orig),2) );
    x_pad_post = (x_noisy-x_orig) - x_pad_pre;
    y_pad_pre = double( idivide(int8(y_noisy-y_orig),2) );
    y_pad_post = (y_noisy-y_orig) - y_pad_pre;

    original_barbara = padarray(original_barbara, [x_pad_pre y_pad_pre],'pre');
    original_barbara = padarray(original_barbara, [x_pad_post y_pad_post],'post');
    size(noisy_barbara)
    size(original_barbara)

    figure
    imshow(original_barbara);
    title('original');
    figure
    imshow(noisy_barbara);
    title('noisy');
    %size(noisy_barbara)

    %brute force range
    angles = [-60:60];
    x_translation = [-12:12];

    % get joint entropy
    Entropy = zeros(size(angles,2),size(x_translation,2));

    im1 = original_barbara;
    im2 = noisy_barbara;

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
    figure
    surf(x_translation,angles,Entropy);
    title(noise);

    %find smallest entropy
    [min_entropy,idx] = min(Entropy(:));
    [angle_idx, translation_idx] = ind2sub(size(Entropy),idx)
    min_angle = angles(angle_idx)
    min_translation = x_translation(translation_idx)
    min_im2 = rotateTranslate(im2, min_angle,min_translation); 

    figure
    imshow(min_im2);
    title(noise);
end