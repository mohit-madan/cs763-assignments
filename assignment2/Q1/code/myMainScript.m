
p1 = [[844,677];[958,534];[1124,554];[1058,719]];

p2 = [[0,44];[0,0];[18,0];[18,44]];
H =  homography(p1,p2);

save('../output/homography.mat','H');

a1 = [374,432,1];
a2 = [1140,517,1];
a3 = [1023,808,1];

point1 = H*a1';
point2 = H*a2';
point3 = H*a3';

point1 = point1./point1(3);
point2 = point2./point2(3);
point3 = point3./point3(3);

dim1 = point1 - point2;
dim2 = point2 - point3;

length = sqrt(dim1(1).*dim1(1) + dim1(2).* dim1(2));
width = sqrt(dim2(1).*dim2(1) + dim2(2).* dim2(2));

length
width
