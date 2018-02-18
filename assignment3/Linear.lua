
require 'torch' -- i think this is required 
-- Declaring a class linear
Linear = {}

function Linear:__init( inputSize, outputSize )
	self.output = torch.Tensor( 64 , outputSize)	-- create the output matrix -not sure
    self.W = torch.Tensor( outputSize, inputSize)						-- create the Weight matrix
    self.B = torch.Tensor( outputSize, 1)
    self.gradW = torch.Tensor( outputSize, inputSize)
    self.gradB = torch.Tensor( outputSize, 1)
    self.gradInput = torch.Tensor ( 64 , inputSize) --same as the size of the input -not sure
end

function Linear:forward( input )
	self.output = self.W * input + self.B --output = weights * input + bias
	return self.output
end

function Linear:backward( input, gradOutput )
	local n = input:size(1)
	local m = gradOutput:size(1)
	
	local dodw = torch.Tensor(m,n*m)
	
	st = 1
	for i=1,m do
		for j=1,n do
			dodw[i][st] = input[j]
			st = st + 1
		end
	end
	
	self.gradW = (gradOutput:reshape(1, m) * dodw):reshape(m,n)
	self.gradInput = (gradOutput:reshape(1,m) * self.W):reshape(n,1)
-- how to calcukate gradB
	return self.gradInput
end
