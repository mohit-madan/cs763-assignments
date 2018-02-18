require 'torch'
Model = {}

function Model:__init(  )
	Model.Layers = {}
end


function Model:forward( input )
	local temp = input
	a={}
	for i, l_name in ipairs(self.Layers) do
		temp = l_name:forward(temp) --stored for back propagation
		table.insert(a,temp)
	end	
	return temp
end

function Model:backward( input, gradOutput )
	local temp =gradOutput
	gradWeights = {}
	for i = #self.Layers-1, 1, -1 do 
		l_name = self.Layers[i]
		temp = l_name:backward(a[i-1], temp) 
		l_name.W = l_name.W - learn_rate*temp
		table.insert(gradWeights,1,l_name.gradW)--check whether l_name.gradW is correct or l_name:gradW
	end	

	i=1;
	l_name = self.Layers[i]
	temp = l_name:backward(input, temp) 
	table.insert(gradWeights,1,l_name.gradW)		--check whether l_name.gradW is correct or l_name:gradW
	return temp
end

function Model:dispGradParam( )
	for i= #self.Layers,1,-1 do 
		l_name = self.Layers[i]
		print(l_name.gradW)
	end
end

function Model:clearGradParam( )
	for i= #self.Layers,1,-1 do 
		l_name = self.Layers[i]
		local size1 = l_name.gradW:size(1)
		local size2 = l_name.gradW:size(2)
		l_name.gradW = torch.Tensor( size1, size2):zero()
	end
end

function Model:addLayer( new_layer )--layer class object
	table.insert(Model.Layers, new_layer)
end
	