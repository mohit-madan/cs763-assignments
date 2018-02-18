require 'torch'
require 'Linear'
require 'Model'
require 'ReLU'
require 'Criterian'
batch_size = 1
learn_rate = 0.00005

layer = Linear
layer:__init(5,2)
a = torch.rand(1,5)
print(a)
print('train')

OurModel = Model
OurModel:__init()

OurModel:addLayer(layer)

out = OurModel:forward(a)
print(out:size())
gradOutput = torch.rand(1,2)
gI = layer:backward(a,gradOutput)
print(gI)