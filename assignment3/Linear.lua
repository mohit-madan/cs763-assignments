 
require 'torch' -- i think this is required 
-- Declaring a class linear
Linear = {}

function Linear:__init( inputSize, outputSize )
	self.output = torch.Tensor( batch_size , outputSize)	-- create the output matrix -not sure
    self.W = torch.Tensor( outputSize, inputSize)						-- create the Weight matrix
    self.B = torch.Tensor( outputSize, 1)
    self.gradW = torch.Tensor( outputSize, inputSize)
    self.gradB = torch.Tensor( outputSize, 1)
    self.gradInput = torch.Tensor ( batch_size , inputSize) --same as the size of the input -not sure
end

function Linear:forward( input )
	self.output = input*self.W:transpose(1,2) --output = weights * input + bias
	return self.output
end

function Linear:backward( input, gradOutput )
	local n = input:size(2)
	local m = gradOutput:size(2)
	numb_ex = gradOutput:size(1)

	k=1

	local dodw = torch.Tensor(m,n*m)
	
	st = 1
	for i=1,m do
		for j=1,n do
			dodw[i][st] = input[k][j]
			st = st + 1
		end
	end
	
	self.gradW = (gradOutput:reshape(1, m) * dodw):reshape(m,n)
	self.gradInput = (gradOutput:reshape(numb_ex,m) * self.W):reshape(input:size(1),n)
	
	-- how to calcukate gradB
	return self.gradInput
end
