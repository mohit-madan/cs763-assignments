
require 'torch' -- i think this is required 
-- Declaring a class linear
--require 'class'
--local Linear = class('Linear')
do 
--Linear = class.new('Linear')
local Linear = torch.class('Linear')

function Linear:__init( inputSize, outputSize )
	self.output = torch.Tensor( batch_size , outputSize)	-- create the output matrix -not sure
    self.W = torch.rand( outputSize , inputSize )	*.0001					-- create the Weight matrix
    self.B = torch.rand( batch_size,outputSize) * .0001
    self.gradW = torch.Tensor( outputSize, inputSize)
    self.gradB = torch.Tensor(  batch_size,outputSize)
    self.gradInput = torch.Tensor ( batch_size , inputSize) --same as the size of the input -not sure

end

function Linear:forward( input )
	weight = self.W:transpose(1,2)
	self.output = input*weight + self.B --output = weights * input + bias --to add bias added a column of ones ar the end
	return self.output
end

function Linear:backward( input, gradOutput )
	n = input:size(2)
	m = gradOutput:size(2)
	numb_ex = gradOutput:size(1)																																																																																																																																																																																																												
	self.gradW = gradOutput:transpose(1,2)*input
--	self.gradW = (gradOutput:reshape(numb_ex, m) * dodw):reshape(m,n)
	self.gradInput = (gradOutput:reshape(numb_ex,m) * self.W):reshape(input:size(1),n)
	self.gradB = gradOutput	
	-- how to calcukate gradB
	return self.gradInput
end

end

