import numpy as np
from numpy.linalg import inv
from homography import homography

p1 = np.array([[844,677,1],[958,534,1],[1124,554,1],[1058,719,1]])
# print(p1)
# p1 = p1/100
p2 = np.array([[0,44,1],[0,0,1],[18,0,1],[18,44,1]])
# p2=p2/10
H =  homography(p1,p2)

# print output
#print H
x1 = np.array([374,432,1])
x2 = np.array([1140,517,1])
x3 = np.array([1023,808,1])

out1 = np.dot(H,x1.T)
out2 = np.dot(H,x2.T)
out3 = np.dot(H,x3.T)
out1 = out1/out1[2]
out2 = out2/out2[2]
out3 = out3/out3[2]


print out1 -out2
print out2 -out3


