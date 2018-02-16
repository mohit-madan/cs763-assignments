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
	gradWeight = {}
	for i = #self.Layers-1, 1, -1 do 
		l_name = self.Layers[i]
		temp = l_name:backward(a[i-1], temp) 
		table.insert(gradWeight,1,l_name:gradW)
	end	
	i=i-1;
	l_name = self.Layers[i]
	temp = l_name:backward(input, temp) 
	table.insert(gradWeight,1,l_name:gradW)
	return temp
end

function Model:dispGradParam( )
	for i= #self.Layers,1,-1 do 
		l_name = self.Layers[i]
		print()
end

function Model:clearGradParam( )
	-- body
end

function Model:addLayer( ... )--layer class object
	-- body
end
