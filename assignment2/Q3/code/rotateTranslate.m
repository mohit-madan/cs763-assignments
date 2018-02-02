function out = rotateTranslate( in, angle, x_translation )

%rotate + translate image
in = imrotate(in,angle,'crop');
in = imtranslate(in,[x_translation, 0],'OutputView','same');

out = in;