n_iter = 20;
Template_frame = imread('/home/krishna/Desktop/Sachin/HW5/input/1.jpg');
Template_frame = padarray(Template_frame,[3,3],'both');
Present_frame = imread('/home/krishna/Desktop/Sachin/HW5/input/4.jpg');
Present_frame = padarray(Present_frame,[3,3],'both');
[p1,p2] = size(Present_frame);

points = detectHarrisFeatures(Template_frame);
Hpnts = round(points.Location);%1st column = y cord and 2nd column = x cord 

smooth = imgaussfilt(Template_frame,2);
[Gtx,Gty] = imgradientxy(smooth);
all_eigen = [];

for i = 1:size(Hpnts,1)
    %ith feature point
    H = 0;
    for j = -3:3
        for k = -3:3
            x = Hpnts(i,1);
            y = Hpnts(i,2);
            Ix = Gtx(y,x);
            Iy = Gty(y,x); 
            h = [x*Ix y*Ix Ix x*Iy y*Iy Iy]';
            H = H + h*h';
        end
    end
    e = eig(H);
    all_eigen = [all_eigen; e'];
end

tau = mean(all_eigen);
%%

%let there be detected points now\
final_pnts = [584,279];%say


p = [1 0 0 0 1 0];%a1 a2 b1 a3 a4 b2
for i = 1:1
    for j = 1:n_iter
        j
        tform = affine2d([p(1) p(4) 0;p(2) p(5) 0; p(3) p(6) 1]);
        Present_frame_w = imwarp(Present_frame,tform);
        Present_frame_w = imresize(Present_frame_w,[p1,p2]);

        TP = [final_pnts(i,1) , final_pnts(i,2) , 1]';

        T = Template_frame(TP(2,1)-3:TP(2,1)+3 , TP(1,1)-3:TP(1,1)+3);  
%         subplot(2,2,1)
%         imshow(T)

        I_w = Present_frame_w(TP(2,1)-3:TP(2,1)+3 , TP(1,1)-3:TP(1,1)+3);  
%         subplot(2,2,2)
%         imshow(I_w)
        [m,n] = size(I_w);
        diff = T - I_w; %T(x) - I(w)

        smooth = imgaussfilt(I_w,2);
        [gradIx,gradIy] = imgradientxy(smooth);

        %computing gradI * dW/dp....[x*Ix,y*Ix,Ix,x*Iy,y*Iy,Iy]
        second_factor = [];
        for j = 1:n             % j is x
            for k = 1:m         % k is y
               second_factor = [second_factor ; [gradIx(k,j)*j  gradIx(k,j)*k gradIx(k,j) gradIy(k,j)*j gradIy(k,j)*k gradIy(k,j)]]; 
            end
        end

        Sum = zeros(1,6);
        g = 1;
        for j=1:n
            for k=1:m
                Sum = Sum + double(diff(k,j)) * second_factor(g); %double for data type
                g=g+1;
            end
        end



        H = 0;
        i=1;
        for j = -3:3
            for k = -3:3
                x = final_pnts(i,1) ;
                y = final_pnts(i,2);
                Ix = Gtx(y,x);
                Iy = Gty(y,x); 
                h = [x*Ix y*Ix Ix x*Iy y*Iy Iy]';
                H = H + h*h';
            end
        end
        
        Sum
        del_p = Sum * inv(H);%you do this sachin
        p = p+del_p
    end
end
        