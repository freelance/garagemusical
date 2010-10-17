require 'rubygems'

require 'sinatra/base'
require 'sinatra/session'
require 'mustache/sinatra'

require 'mongomatic'
require 'uri'
require 'omniauth'

require 'models/models.rb'

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
#  register Sinatra::Mongomatic


  if ENV['MONGOHQ_URL']
    uri = URI.parse( ENV['MONGOHQ_URL'] )
    conn = Mongo::Connection.from_uri( ENV['MONGOHQ_URL'] )
    Mongomatic.db = conn.db( uri.path.gsub(/^\//, '') )
  else
    conn = Mongo::Connection.new("flame.mongohq.com", 27064)
    conn.db("app318810").authenticate("app318810","d6vqgr76urvopntbvyodrg")
    Mongomatic.db = conn.db("app318810")
  end
    
  #-^ database setup ^-#

  get '/' do
    session!

    @user = User.find_one({"_id"=>session[:id]})
    @posts = Posting.find
    mustache :index
  end

  get '/login' do
    @entries = User.find()
    
    mustache :login
  end
  
  get '/auth/:name/callback' do
    auth = request.env['rack.auth']

    user_id = User.find_one({:nick => auth['user_info']['nickname']})
    if user_id.nil?
      user_id = User.new(
        :key  => auth['credentials']['secret'],
        :nick => auth['user_info']['nickname'],
        :name => auth['user_info']['name']
      ).insert
    end
    
    session_start!
    session[:id] = user_id["_id"]

    redirect '/'
  end
  
  post '/posting' do
    Posting.new({
      :title      => params[:title],
      :instrument => params[:instrument],
      :body       => params[:body],
      :last_edit  => Time.now,
      :creator    => session[:id]
    }).insert
    
    redirect '/'
  end
  
  get '/profile' do
    session!
    @user = User.find_one({"_id"=>session[:id]})
    @postings = Posting.find({"creator"=>session[:id]}).to_a

    mustache :profile
  end
  
  get '/logout' do
    session_end!
    
    redirect '/'
  end
  
  get '/post/edit/:id' do
    @posting = Posting.find_one({"_id"=>params[:id]})
    
    mustache :edit_post
  end

end