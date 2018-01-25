%% MyMainScript

tic;
%% Your code here
% 2D Koordinates of 10 Points Plane World
PW = [327,868;1870,960;1043,1320;1638,1781;689,2399;3587,920;2168,1291;2040,2036;3473,2428;3095,1746]';
% 3D Koordinates of 10 Points Object World
OW = [9,-0.9,7;0,-0.9,7;6,-0.9,5;2,-0.9,2;8,-0.9,0;-0.7,9,7;-0.7,1,5;-0.7,0,0;-0.7,9,0;-0.7,7,3]';
%Homogeneous Coordinates
PW(3,:) = 1;
OW(4,:) = 1;


centroidP = mean(PW,2)
centroidO = mean(OW,2)

%Translation in Plane around centroid
T = eye(3);
T(1,3) = -centroidP(1);
T(2,3) = -centroidP(2);
 
PW = T*PW

%Translation in Object world around centroid
U = eye(4);
U(1,4) = -centroidO(1);
U(2,4) = -centroidO(2);
U(3,4) = -centroidO(3);

OW = U*OW

%get mean Eucledian distance for Plane
eucSum = 0;
for i = 1 : size(PW,2)
    eucSum = eucSum + norm(PW(1:2,i) ,2);
end
eucMeanP = eucSum/size(PW,2);
    
scaleP = eucMeanP / sqrt(2);

S = eye(2) / scaleP;
S(3,3) = 1

PW = S*PW

%get mean Eucledian distance for Object World
eucSum = 0;
for i = 1 : size(OW,2)
    eucSum = eucSum + norm(OW(1:3,i) ,2);
end
eucMeanO = eucSum/size(OW,2);
    
scaleO = eucMeanO / sqrt(3);

SO = eye(3) / scaleO;
SO(4,4) = 1;

OW = SO*OW

% Transformations T and U are:
T = S*T
U = SO*U


toc;
