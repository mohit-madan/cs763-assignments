require 'torch'
require 'Linear.lua'
require 'Model.lua'
require 'Relu.lua'
require 'Criterion.lua'
layer1 = Linear:__init(108*108,54*54)
layer2 = Relu:__init(54*54,54*54)
layer3 = Linear:__init(54*54,27*27)
layer4 = Relu:__init(27*27,27*27)
layer5 = Linear:__init(27*27,10*10)

OurModel = Model:__init()
OurModel:addLayer(layer1)
OurModel:addLayer(layer2)
OurModel:addLayer(layer3)
OurModel:addLayer(layer4)
OurModel:addLayer(layer5)

train = torch.load('train.bin')
train = torch.reshape(train,train:size(1),train:size(2)*train:size(3))
labels = torch.load('labels.bin')

--training 
SoftMaxInput = OurModel:forward(train)
cross_entropy_loss = Criterion:forward(SoftMaxInput,labels)	--the calculated loss is a global variable /
gradLoss = Criterion:backward(SoftMaxInput,labels)

OurModel:backward(train,gradLoss)

