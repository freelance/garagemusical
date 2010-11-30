require 'rubygems'

require 'sinatra/base'
require 'sinatra/session'
require 'mustache/sinatra'

require 'mongomatic'
require 'uri'
require 'omniauth'

require 'lol.rb'
require 'models/models.rb'

class GarageMusical < Sinatra::Base

  helpers do
    include Rack::Utils
    alias_method :h, :escape_html
  end
  
  set :public, File.dirname(__FILE__) + '/public'

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
  set :session_secret, "THIS SEKRIT, OK"

  
  #-- database setup --#
    init_db()
  #-^ database setup ^-#

  get '/' do
    session!
    
    @user = User.find_one({"_id"=>session[:id]})
    @posts = Posting.all

    mustache :index
  end
  
  get '/reply/:id' do
    id = BSON::ObjectId(params[:id])
    post = Posting.find_one({"_id" => id})
    
    
    <<-HTML
    <a href="/">back</a>

    <p>
      title: #{post['title']}<br>
      body: #{post[:body]}<br>
      creator: #{User.find_one({"_id"=>post['creator']})[:name]} @ #{post[:last_edit]}
    </p>

      <form action="/reply/:id" method="POST">
        <textarea rows="10" cols="30" type="textarea" name="response">I am interested in this classified.</textarea>
        <input type="submit" value="reply">
      </form>
      </div>
    HTML
  end
  post '/reply/:id' do
  end
  
  get '/temp' do
    @posts = Posting.all.to_a

    mustache :temp
  end

  get '/login' do
    @entries = User.find()
    
    mustache :login
  end
  
  get '/auth/:name/callback' do
    auth = request.env['rack.auth']
    
    User.new(
        :key  => auth['credentials']['secret'],
        :nick => auth['user_info']['nickname'],
        :name => auth['user_info']['name']
    ).insert

    session_start!
    session[:id] = User.find_one( {:nick => auth['user_info']['nickname']} )["_id"]

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
  get '/profile/new' do
    
  end
  
  get '/logout' do
    session_end!
    
    redirect '/'
  end
  
  get '/post/edit/:id' do
    session!

    id = BSON::ObjectId(params[:id])
    @post = Posting.find_one({ "_id" => id })

    mustache :edit_post
  end

end
