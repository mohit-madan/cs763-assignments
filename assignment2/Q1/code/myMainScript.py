import numpy as np
from numpy.linalg import inv
from homography import homography

p1 = np.array([[844,677],[958,534],[1124,554],[1058,719]])
print(p1)
p1 = p1/100
p2 = np.array([[0,44],[0,0],[18,0],[18,44]])
p2=p2/10
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
print output
print H
a = np.array([958,534,1])
a=a/100
result = np.dot(H,a.T)

print result
