require 'rubygems'
require 'sinatra/base'
require 'mustache/sinatra'

class GaragemMusical < Sinatra::Base
  
  set :public, File.dirname(__FILE__) + "/public"
  register Mustache::Sinatra
  require 'views/layout'
  
  set :mustache, {
    :views     => 'views/',
    :templates => 'templates/'
  }
  
  helpers do
    include Rack::Utils
    alias_method :h, :escape_html
  end
  
  get '/' do
    
    mustache :index
  end

end