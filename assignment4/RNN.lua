require 'torch'
require 'nn'

do
local RNN = torch.class('RNN')

function RNN:__init( input_dim , hidden_dim )
	self.W = torch.rand( input_dim+hidden_dim , hidden_dim )*0.001
	self.V = torch.rand( 2, hidden_dim) --output weight
	self.B = torch.rand( 1, hidden_dim)
	self.gradW = torch.Tensor( input_dim+hidden_dim , hidden_dim )
	self.gradW1 = torch.Tensor( input_dim , hidden_dim )
	self.gradW2 = torch.Tensor( hidden_dim , hidden_dim )
	self.gradB = torch.Tensor( 1, hidden_dim)
	self.gradV = torch.Tensor(2, hidden_dim)
	self.hidden_dim = hidden_dim
	self.input_dim = input_dim 
end

function RNN:forward( input )
	--total number of time steps
	T = input:size(1)
	h = torch.zeros(T, self.hidden_dim)
	h0 = torch.zeros(1, self.hidden_dim)

	h[{{1}}] = (torch.tanh(self.W:transpose(1,2) * torch.cat(input[{{1}}]:transpose(1,2),h0:transpose(1,2),1))):transpose(1,2) + self.B
	for i =2,T do
		h[{{i}}] = (torch.tanh(self.W:transpose(1,2) * torch.cat(input[{{i}}]:transpose(1,2),h[{{i-1}}]:transpose(1,2),1))):transpose(1,2) + self.B--concatenating along columns
		
	end
	self.h = h
	self.h0 = h0
	out = self.V * h[{{T}}]:transpose(1,2) --output is a vector of 2x1  
	return out
end

function RNN:backward( input , gradOutput )
	-- body
	--gradOutput is of size 2*1
	dhnext = torch.zeros(1,self.hidden_dim)
	dh = torch.zeros(1,self.hidden_dim)
	dhraw = torch.zeros(1,self.hidden_dim)
	T = input:size(1)

	self.gradV = gradOutput*self.h[{{T}}]  --2*1 * 1*hidden_dim
	dh = (V:transpose(1,2) * gradOutput):transpose(1,2) + dhnext		--1*hidden

	for i=1,20 do 
		dhraw = torch.cmul((1 - np.pow(self.h[{{T+1-i}}],2)), dh)	--1*hidden
		self.gradB = self.gradB + dhraw			--1*hidden

		if(T==i) then
			self.gradW2 = self.gradW2 +  self.h0:transpose(1,2) * dhraw		--hid*hid	
		else				
			self.gradW2 = self.gradW2 +  self.h[{{T-i}}]:transpose(1,2) * dhraw		--hid*hid
		end

		self.gradW1 = self.gradW1 + input[{{T+1-i}}]:transpose(1,2)*dhraw		--input*hidden
		W2 = self.W1[{{self.input_dim+1,self.hidden_dim}}]		--hidd*hdd
		dhnext = dhraw * W2
	end

	self.gradW = torch.cat(self.gradW1.self.gradW2,1)

	--update params
	learn_rate = .001
	self.W  = self.W - learn_rate*self.gradW
	self.V = self.V - learn_rate*self.gradV
	self.B = self.B - learn_rate*self.gradB
	
	return self.gradW
end