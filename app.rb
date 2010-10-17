require 'rubygems'

require 'sinatra/base'
require 'sinatra/session'
require 'mongomatic'
require 'sinatra/mongomatic'
require 'mustache/sinatra'

require 'omniauth'
require 'quickedit'

require 'models/models.rb'

class GarageMusical < Sinatra::Base

  helpers do
    include Rack::Utils
    alias_method :h, :escape_html
  end
  
  use OmniAuth::Builder do
    provider :twitter, 'ZrxnngDLk0AXdOy17ZVqxg', 'LB3ackpiT0fZo0wiVvT4kmVZk8LuyPKOoCx3aYxew'
  end
  
  use Quickedit
  include Quickedit::Helpers
  
  enable :sessions
  enable :run
  
  register Mustache::Sinatra
  require 'views/layout'

  set :mustache, {
    :views     => 'views/',
    :templates => 'templates/'
  }

  register Sinatra::Session
  set :session_fail, '/login'
  set :session_secret, "lolyou!"

  
  #-- database setup --#
  register Sinatra::Mongomatic

  conn = Mongo::Connection.new("flame.mongohq.com", 27064)
  conn.db("app318810").authenticate("app318810","d6vqgr76urvopntbvyodrg")
  
  mongomatic conn.db("app318810")
  #-^ database setup ^-#
=begin
=end
#  mongomatic Mongo::Connection.new("localhost").db("RMU")
  #-^ database setup 2 ^-#

  get '/' do
    session!

    @session = session
    mustache :index
  end

  get '/login' do
    @entries = User.find()
    
    mustache :login
  end
  
  get '/auth/:name/callback' do
    auth = request.env['rack.auth']
    
    session_start!
    session[:key]  = auth['credentials']['secret']
    session[:nick] = auth['user_info']['nickname']
    session[:name] = auth['user_info']['name']

    User.create_indexes
    begin
      User.new(
        :key  => session[:key],
        :nick => session[:nick],
        :name => session[:name]
      ).insert!
    rescue Exception => e
      puts e
    ensure
      redirect '/'
    end

    redirect '/'
  end
  
  get '/profile' do
    session!
    @session = session
    
    erb :profile
  end
  
  get '/logout' do
    session_end!
    
    redirect '/'
  end

end