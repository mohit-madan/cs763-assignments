import numpy as np
from numpy.linalg import inv

def homography(p1, p2):
	(h,w) = np.shape(p1)
	# b = np.resize(p2,(2*h,1)) #modified matrix p2
	# print b
	temp = np.reshape(p2[:,[0,1]] ,(2*h,1))
	A1 = np.zeros((2*h,2*w)) #Ax = b
	A2 = np.zeros((2*h,w))
	temp1 = np.concatenate((p1,np.zeros((h,3))),axis = 1) #,-p1*temp[:,np.newaxis]
	temp2 = np.concatenate((np.zeros((h,3)),p1),axis = 1)
	
	A1[::2] = temp1[::1]
	A1[1::2] = temp2[::1]
	
	A2[::2]  = -p1[::1]
	A2[1::2] = -p2[::1]
	A2 = A2 * temp
	A = np.concatenate((A1,A2),axis = 1)
	U,S,V = np.linalg.svd(A,full_matrices = True)

	x = np.reshape(V[:,8],(3,3)).T	

	# print A
	# x = np.dot(A.T,A)#(At.A)-1.At.b
	# x = inv(x)
	# x = np.dot(x,A.T)
	# x = np.dot(x,b)
	return x

