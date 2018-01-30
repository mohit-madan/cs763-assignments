import numpy as np
from numpy.linalg import inv
from homography import homography

p1 = np.array([[844,677],[958,534],[1124,554],[1058,719]])
#print(p1)
p1 = p1
p2 = np.array([[0,44],[0,0],[18,0],[18,44]])
output =  homography(p1,p2)
temp = np.zeros((3,3))

temp[0,0] = output[0,0] 
temp[0,1] = output[1,0]
temp[0,2] = output[4,0]
temp[1,0] = output[2,0]
temp[1,1] = output[3,0]
temp[1,2] = output[5,0]
temp[2,0] = 0
temp[2,1] = 0
temp[2,2] = 1
H = temp

np.savetxt('../output/homography.txt',H,fmt = '%.2f')

a1 = np.array([374,432,1])
a2 = np.array([1140,517,1])
a3 = np.array([1023,808,1])

point1 = np.dot(H,a1.T)
point2 = np.dot(H,a2.T)
point3 = np.dot(H,a3.T)

dim1 = point1 - point2
dim2 = point2 - point3

length = np.sqrt(np.square(dim1[0]) + np.square(dim1[1]))
width = np.sqrt(np.square(dim2[0]) + np.square(dim2[1]))

print (length)
print (width)