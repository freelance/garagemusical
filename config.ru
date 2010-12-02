require 'rubygems'
require 'bundler'

Bundler.require

require './app.rb'

use Rack::ShowExceptions

run GarageMusical.new
