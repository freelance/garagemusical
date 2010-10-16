require 'rubygems'
#require 'bundler'

#Bundler.require

require 'omn.rb'
#require './app.rb'

use Rack::ShowExceptions

run Teste.new
#run GarageMusical.new