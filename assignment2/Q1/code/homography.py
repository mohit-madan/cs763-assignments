import numpy as np
from numpy.linalg import inv

def homography(p1, p2):
	(h,w) = np.shape(p1)
	b = np.resize(p2,(2*h,1)) #modified matrix p2
	print b
	A = np.zeros((2*h,3*w)) #Ax = b
	temp1 = np.concatenate((p1,np.zeros((h,2)),np.ones((h,1)),np.zeros((h,1))),axis = 1)
	temp2 = np.concatenate((np.zeros((h,2)),p1,np.zeros((h,1)),np.ones((h,1))),axis = 1)
	
	A[::2] = temp1[::1]
	A[1::2] = temp2[::1]
	print A
	x = np.dot(A.T,A)#(At.A)-1.At.b
	x = inv(x)
	x = np.dot(x,A.T)
	x = np.dot(x,b)
	return x
