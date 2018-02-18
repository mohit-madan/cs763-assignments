require 'torch'
require 'Linear'
require 'Model'
require 'ReLU'
require 'Criterian'
batch_size = 1
learn_rate = 0.00005

OurModel = Model
OurModel:__init()

--local layer1 = Linear.new()
layer1 = Linear(108*108,54*54)
OurModel:addLayer(layer1)

layer2 = ReLU(54*54,54*54)
OurModel:addLayer(layer2) 	

layer3 = Linear(54*54,27*27)
OurModel:addLayer(layer3)

layer4 = ReLU(27*27,27*27)
OurModel:addLayer(layer4)

layer5 = Linear(27*27,6*6)
--layer5:__init(27*27,6*6)
OurModel:addLayer(layer5)

print(layer1.W:size())

trainD = torch.DoubleTensor()
train = torch.load('data.bin')
trainD = trainD:resize(train:size()):copy(train)
trainD = torch.reshape(trainD,trainD:size(1),trainD:size(2)*trainD:size(3))
labels = torch.load('labels.bin')
labels = labels:reshape(labels:size(1),1)

--training 
for i=1,29000 do
	print(i)
	input = trainD[i]:reshape(1,trainD[i]:size(1))																																																																																																																																																																																																																					
	SoftMaxInput = OurModel:forward(input)
	cross_entropy_loss = Criterian:forward(SoftMaxInput,labels)	--the calculated loss is a global variable /
	gradLoss = Criterian:backward(SoftMaxInput,labels)
	OurModel:backward(input,gradLoss)

end
