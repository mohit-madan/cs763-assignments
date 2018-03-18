import numpy as np
from heapq import merge
from sklearn.preprocessing import OneHotEncoder
from sklearn.preprocessing import LabelEncoder
from numpy import array

enc = OneHotEncoder()
b = open("train_data.txt", "r").readlines()
a = 0 
out = {}

for line in b:
	x = np.fromstring(line, dtype=int, sep=' ')
	maxvalue = np.max(x)
	if(maxvalue > a):
		a = maxvalue		

print(a)
def ohe(T):
	temp=np.zeros(a, dtype=int)
	temp[T-1]=1
	return temp

for line in b:
	x = np.fromstring(line, dtype=int, sep=' ')
#	print(len(map(ohe,x)))
#	out = [out,map(ohe,x)]

print (len(out))
'''
thefile = open('out.txt', 'w')

for item in out:
  thefile.write("%s\n" % item)
'''




































