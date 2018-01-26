%% MyMainScript

tic;
%% Your code here

input_img = imread('../input/rad_checkerbox.jpg');
input_img = im2double(input_img); 

[h,w,d] = size(input_img); %%height and width 

h_2 = floor(h/2);
w_2 = floor(w/2);

r = zeros(h,w);

for i = 1:size(r,1)
    for j = 1:size(r,2)
          r(i,j) = sqrt((((h+1)/2 - i)/h_2).^2 + (((w+1)/2 - j)/w_2).^2);
    end
end

xd_cord = meshgrid(-w_2:w_2,-h_2:h_2)/w_2; %distorted - initial one
yd_cord = meshgrid(-h_2:h_2,-w_2:w_2)'/h_2; %distorted

x_cord = xd_cord; %initialisation
y_cord = yd_cord;

%%iterations for getting the undistorted matrix
for i = 1:10
    distort = (r + 0.5*(r.*r)); %distortion matrix
	
    del_x = x_cord.*(distort);
	del_y = y_cord.*(distort);
	x_cord = xd_cord + del_x;
	y_cord = yd_cord + del_y;
    
    %update the r
    for i = 1:size(r,1)
    for j = 1:size(r,2)
          r(i,j) = sqrt(x_cord(i,j)^2 + y_cord(i,j)^2 );
    end
    end

end    

%%plotting in rgb
final_img(:,:,1) = interp2(xd_cord,yd_cord,input_img(:,:,1),x_cord,y_cord);
final_img(:,:,2) = interp2(xd_cord,yd_cord,input_img(:,:,2),x_cord,y_cord);
final_img(:,:,3) = interp2(xd_cord,yd_cord,input_img(:,:,3),x_cord,y_cord);
 
output = image(final_img);

toc;
