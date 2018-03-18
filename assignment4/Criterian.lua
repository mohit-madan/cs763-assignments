require 'nn'
require 'torch'

do 

local Criterian = torch.class('Criterian')

function Criterian:forward( input, target )			--input is a column vector of size 2*1
	local exp_input = torch.exp(input)
	sum_exp_input = torch.sum(exp_input, 1) 	--size = [nrow,1]	

	cross_entropy_loss = -torch.log(sum_exp_input[target+1][1]) --taking -log of the desired target

	return cross_entropy_loss
end

function Criterian:backward( input, target )
	gradLoss = sum_exp_input
	
	gradLoss[target + 1][1] = gradLoss[target + 1][1] - 1  

	return gradLoss
end

function Criterian:predict( input )	
	val,predicted_values = torch.max(input,1)
	predicted_values = predicted_values - 1

	return predicted_values
end

end