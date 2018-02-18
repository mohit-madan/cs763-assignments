require 'torch'
require 'Linear'
require 'Model'
require 'ReLU'
require 'Criterian'
batch_size = 1
learn_rate = 0.00005

layer1 = Linear
layer1:__init(108*108,54*54)
-- layer2 = ReLU:__init(54*54,54*54)
-- layer3 = Linear:__init(54*54,27*27)
-- layer4 = ReLU:__init(27*27,27*27)
-- layer5 = Linear:__init(27*27,10*10)

OurModel = Model
OurModel:__init()

OurModel:addLayer(layer1)
--OurModel:addLayer(layer2)
--OurModel:addLayer(layer3)
--OurModel:addLayer(layer4)
--OurModel:addLayer(layer5)
trainD = torch.DoubleTensor()
train = torch.load('data.bin')
trainD = trainD:resize(train:size()):copy(train)
trainD = torch.reshape(trainD,trainD:size(1),trainD:size(2)*trainD:size(3))
labels = torch.load('labels.bin')
labels = labels:reshape(labels:size(1),1)

--training 
for i=1,30 do
	input = trainD[i]:reshape(1,trainD[i]:size(1))
	print(input)
	SoftMaxInput = OurModel:forward(input)
	print("frstsuce")
	print(SoftMaxInput:size())
	cross_entropy_loss = Criterian:forward(SoftMaxInput,labels)	--the calculated loss is a global variable /
	gradLoss = Criterian:backward(SoftMaxInput,labels)

	OurModel:backward(train,gradLoss)

end
