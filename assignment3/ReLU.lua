require 'torch'
ReLU = {}

function ReLU:__init( inputSize, outputSize )
    self.gradW = torch.Tensor( outputSize, inputSize)
end

function ReLU:forward( input )
	self.output = (input + abs(input))/2 --returns max(0,input)
end

function ReLU:backward( input , gradOutput )
	local gradReLU = (torch.cdiv(input, torch.abs(input)) + 1)/2 --pointwise division
	self.gradInput = torch.cmul(gradOutput , gradReLU);	--
	return self.gradInput 
end
