require 'torch'
require 'Linear'
require 'RNN'
require 'ReLU'
require 'Criterian'

input_dim = 340

OurRNN = RNN
OurRNN:__init(input_dim,input_dim/2)
