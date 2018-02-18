Criterian = {}

--torch.sum(outputs, dim=1) # size = [nrow, 1]
--= -log(exp(x[class]) / (\sum_j exp(x[j])))
--              = -x[class] + exp(\sum_j exp(x[j]))

function Criterian:forward( input, target )
	local exp_input = torch.exp(input)
	local sum_exp_input = torch.sum(exp_input, 2) --size = [nrow,1]
	local exp_input_normalised = torch.Tensor(input:size())
	cross_entropy_loss = torch.Tensor(target:size()) --initiaising the tensor


	for i=1,input:size(1) do
		exp_input_normalised[i] = exp_input[i]/sum_exp_input[i][1] --dividing each elemet by total sum
	end

		
	for j =1,input:size(1) do
		cross_entropy_loss[j] = -torch.log(exp_input_normalised[j][target[j][1]]) --taking -log of the desired target
	end

	return cross_entropy_loss
end

function Criterian:backward( input, target )
	gradLoss = torch.Tensor(target:size())
	for i=1,input:size(1) do
		gradLoss[i] = torch.autograd.grad(cross_entropy_loss[i][1], input[i])		
	end
	return gradLoss
end