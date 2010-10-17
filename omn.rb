require 'rubygems'

require 'sinatra/base'
require 'sinatra/session'
require 'sinatra/mongomatic'

require 'omniauth'
require 'openid/store/filesystem'
require 'uri'

require './models/models.rb'

class Teste < Sinatra::Base
  
  register Sinatra::Mongomatic

#  mongomatic Mongo::Connection.new("localhost").db("RMU")
# 
# 
if ENV['MONGOHQ_URL']
  uri = URI.parse(ENV['MONGOHQ_URL'])
  conn = Mongo::Connection.from_uri(ENV['MONGOHQ_URL'])

  mongomatic conn.db(uri.path.gsub(/^\//, ''))
else
  conn = Mongo::Connection.new("flame.mongohq.com", 27064)
  conn.authenticate("app318810","d6vqgr76urvopntbvyodrg")
  
  Mongomatic.db = conn.db("app318810")
end

=begin
  puts User.empty?
  u = User.new(:name => "lols", :age => 12)
  puts u["age"], u.insert
=end
  
  use OmniAuth::Builder do
    provider :open_id, OpenID::Store::Filesystem.new('/tmp')
    provider :twitter, 'ZrxnngDLk0AXdOy17ZVqxg', 'LB3ackpiT0fZo0wiVvT4kmVZk8LuyPKOoCx3aYxew'
  end

  enable :sessions
  enable :run

  get '/' do
    <<-HTML
    <style>
      body {
        margin: auto;
        
        text-align: center;
      }
    </style>
    <h1>Welcome to GarageMusical</h1>
    <h2>the place for all musicians.</h2>
    
    <div style="position: fixed; top: 1em; right: 1em; background: yellow">
      <a href='/auth/twitter'>Sign in with Twitter</a>
    </div>
    HTML
  end

  get '/auth/:name/callback' do
    auth = request.env['rack.auth']
    # do whatever you want with the information!

    u = User.new(
      :name => auth['user_info']['name'],
      :nick => auth['user_info']['nickname'],
      
      :token  => auth['credentials']['token'],
      :secret => auth['credentials']['secret']
    )
    "
    
    <p>#{u.insert}</p>
    
    #{auth['user_info']['name']}<br>
    #{auth['user_info']['nickname']}<br>
    #{auth['credentials']['token']}<br>
    #{auth['credentials']['secret']}
    
        <p></p><p></p>
    ---#{User.find( {'nick' => 'locks'} )}---

    "
  end

  get '/db' do
    cursor = User.find({'nick'=>'locks'})

    html = ""
    cursor.methods.each {|x| html<<"#{x}<br>" }

    html.to_s
#    User.find( {'nick' => 'locks' })
  end

end