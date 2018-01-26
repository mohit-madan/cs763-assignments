%% MyMainScript

tic;
clear P2D,P3D
%% Your code here
%we are consideriing 10 points 
% 2D Koordinates of 10 Points Plane World
P2D = [327,868;1870,960;1043,1320;1638,1781;689,2399;3587,920;2168,1291;2040,2036;3473,2428;3095,1746];
% 3D Koordinates of 10 Points Object World
P3D = [9,-0.9,7;0,-0.9,7;6,-0.9,5;2,-0.9,2;8,-0.9,0;-0.7,9,7;-0.7,1,5;-0.7,0,0;-0.7,9,0;-0.7,7,3];
num = 6;
numi = 1/num;
P2D = P2D(1:num,:);
P3D = P3D(1:num,:);
P3Do = P3D
P3Do(:,4) = 1;

centroid2 = numi*sum(P2D);
centroid3 = numi*sum(P3D);
%%
T = eye(num) - numi*ones(num); %this matrix makes the centroid as origin 
U = eye(num) - numi*ones(num);

%making the centroid origin
P2D = T*P2D;
P3D = U*P3D;

%avergaae distance as root(2)
m2 = numi*sum(sqrt(sum(P2D.^2,2)));
P2D = sqrt(2)/m2*P2D;

%average distance as root(3)
m3 = numi*sum(sqrt(sum(P3D.^2,2)));
P3D = sqrt(3)/m3*P3D;

%Transformation matrix T 
%T*sqrt(2)/(0.1*sum(sqrt(sum(P2D.^2,2))))

% Homogeneous Coordinates
P2D(:,3) = 1;
P3D(:,4) = 1;


%construct the M matrix
clear M;
j=1;
for i = 1:num
    M(j,:) = [ -P3D(i,:) 0 0 0 0 P2D(i,1)*P3D(i,:) ];
    M(j+1,:) = [0 0 0 0 -P3D(i,:) P2D(i,2)*P3D(i,:) ];
    j=j+2;
end

%apply svd
[U,S,V] = svd(M);

Pcap = V(:,12)
Pcap = reshape(Pcap,[4,3])'

Hcap = P(:,1:3);
hcap = P(:,4);

%estimated value of translation matrix 
Xo = (-1)*inv(Hcap)*hcap;
%Xo = Xo*m3/sqrt(3) + centroid

[R,Q] = rqGivens(inv(Hcap));
%estimates value of rotation matrix
Rcap = R'
Kcap = inv(Q);
%estimate for K
Kcap = Kcap/Kcap(3,3)

%Rcap = Rcap * m3/sqrt(3)
centroid2(1,3) = 1;
estimated = Pcap*P3D' * m2/sqrt(2) + [centroid2' centroid2' centroid2' centroid2' centroid2' centroid2'] ;