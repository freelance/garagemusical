require 'rubygems'

require 'sinatra/base'
require 'sinatra/session'
require 'mustache/sinatra'

require 'omniauth'

class GarageMusical < Sinatra::Base

  helpers do
    include Rack::Utils
    alias_method :h, :escape_html
  end
  
  use OmniAuth::Builder do
    provider :twitter, 'ZrxnngDLk0AXdOy17ZVqxg', 'LB3ackpiT0fZo0wiVvT4kmVZk8LuyPKOoCx3aYxew'
  end
  
  enable :sessions
  enable :run
  
  set :public, File.dirname(__FILE__) + "/public"
  register Mustache::Sinatra
  require 'views/layout'

  set :mustache, {
    :views     => 'views/',
    :templates => 'templates/'
  }

  register Sinatra::Session
  set :session_fail, '/login'
  set :session_secret, "omgomgsecret!"
  
  get '/' do
    session!

    @session = session
    mustache :index
  end

  get '/login' do
    
    mustache :login
  end
  
  get '/auth/:name/callback' do
    auth = request.env['rack.auth']
    
    session_start!
    session[:key]  = auth['credentials']['secret']
    session[:nick] = auth['user_info']['nickname']
    session[:name] = auth['user_info']['name']
    
    redirect '/'
  end
  
  get '/logout' do
    session_end!
    
    redirect '/'
  end

end