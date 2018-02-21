require 'torch'

do 
local ReLU = torch.class('ReLU')

function ReLU:__init( inputSize, outputSize )
    self.gradW = torch.zeros( outputSize, inputSize)
    self.W = torch.zeros( outputSize, inputSize)
    self.B = torch.zeros( batch_size,outputSize)
    self.gradB = torch.zeros(  batch_size,outputSize)
end

function ReLU:forward( input )
	self.output = (input + torch.abs(input))/2 --returns max(0,input)
	return self.output
end

function ReLU:backward( input , gradOutput )
	--print(input)
	local gradReLU = (torch.cdiv(input, torch.abs(input)) + 1)/2 --pointwise division
	self.gradInput = torch.cmul(gradOutput , gradReLU);	--
	return self.gradInput 
end

end