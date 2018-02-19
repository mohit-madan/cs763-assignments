require 'torch'
require 'Linear'
require 'Model'
require 'ReLU'
require 'Criterian'
batch_size = 1
learn_rate = 0.0000005

OurModel = Model
OurModel:__init()

--local layer1 = Linear.new()
layer7 = Linear(108*108,54*54)
OurModel:addLayer(layer7)

layer8 = ReLU(54*54,54*54)
OurModel:addLayer(layer8) 	

layer11 = Linear(54*54,27*27)
OurModel:addLayer(layer11)

layer12 = ReLU(27*27,27*27)
OurModel:addLayer(layer12)

layer13 = Linear(27*27,6*6)
--layer5:__init(27*27,6*6)
OurModel:addLayer(layer13)

--print(layer1.W:size())

trainD = torch.DoubleTensor()
train = torch.load('data.bin')
trainD = trainD:resize(train:size()):copy(train)
trainD = torch.reshape(trainD,trainD:size(1),trainD:size(2)*trainD:size(3))

testD = trainD[{{1,100}}]
-- testD = torch.DoubleTensor()
-- test = torch.load('test.bin')
-- print(test:size())
-- testD = testD[{{1,1+255}}]
-- testD = testD:resize(test:size()):copy(test)
-- testD = torch.reshape(testD,testD:size(1),testD:size(2)*testD:size(3))

labels = torch.load('labels.bin')
labels = labels:reshape(labels:size(1),1)


--training 
batch_size = 32
for j=1,10,1 do
for i=1,100,batch_size do
	print(i)
	input = trainD[{{i,i+batch_size-1}}]																																																																																																																																																																																																																					
	SoftMaxInput = OurModel:forward(input)
	cross_entropy_loss = Criterian:forward(SoftMaxInput,labels)	--the calculated loss is a global variable /
	gradLoss = Criterian:backward(SoftMaxInput,labels)
	OurModel:backward(input,gradLoss)
	--OurModel:clearGradParam()
end
 
end

SoftMaxInput_test = OurModel:forward(testD)
predicted_values = Criterian:predict(SoftMaxInput_test)
print(predicted_values)

-- save weights -write code