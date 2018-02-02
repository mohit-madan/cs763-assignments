function noisy = addNoise( original, angle, translation, noise )


%convert to double to allow calculations with noise
noisy = double(original);
noise = randi([-noise,noise],size(noisy));
noisy = noisy + noise;

%fix under- and overflow
noisy(noisy < 0) = 0;
noisy(noisy > 255) = 255;

%rotate + translate image
noisy = imrotate(noisy,angle);
noisy = imtranslate(noisy,[translation, 0],'OutputView','full');

%convert back to uint8
noisy = uint8(noisy);
