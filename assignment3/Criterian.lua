--Criterian = {}

--torch.sum(outputs, dim=1) # size = [nrow, 1]
--= -log(exp(x[class]) / (\sum_j exp(x[j])))
--              = -x[class] + exp(\sum_j exp(x[j]))
do 
local Criterian = torch.class('Criterian')

function Criterian:forward( input, target )
	local exp_input = torch.exp(input)
	local sum_exp_input = torch.sum(exp_input, 2) --size = [nrow,1]
	print(sum_exp_input)
	exp_input_normalised = torch.Tensor(input:size())
	cross_entropy_loss = torch.Tensor(input:size(1)) --initiaising the tensor

	for i=1,input:size(1) do
		exp_input_normalised[i] = exp_input[i]/sum_exp_input[i][1] --dividing each element by total sum and normalising
	end

		
	for j =1,input:size(1) do
		--print(exp_input_normalised[j][target[j][1]+1])
		cross_entropy_loss[j] = -torch.log(exp_input_normalised[j][target[j][1]+1]) --taking -log of the desired target
	end
	print(torch.sum(cross_entropy_loss))
	return cross_entropy_loss
end

function Criterian:backward( input, target )
	gradLoss = exp_input_normalised
	for i=1,input:size(1) do
		gradLoss[i][target[i][1]+1] = gradLoss[i][target[i][1] + 1] - 1 --formula given on the internet
	end
	
	return gradLoss
end

function Criterian:predict( input )
	local exp_input = torch.exp(input)
	local sum_exp_input = torch.sum(exp_input, 2) --size = [nrow,1]
	exp_input_normalised = torch.Tensor(input:size())
	predicted_values = torch.Tensor(input:size(1)) --initiaising the tensor

	for i=1,input:size(1) do
		exp_input_normalised[i] = exp_input[i]/sum_exp_input[i][1] --dividing each element by total sum and normalising
	end		
	
	val,predicted_values = torch.max(exp_input_normalised,2)
	predicted_values = predicted_values - 1

	return predicted_values
end

end