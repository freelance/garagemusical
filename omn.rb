require 'rubygems'
require 'sinatra/base'
#require 'sinatra/session'
require 'omniauth'
require 'openid/store/filesystem'
require 'sinatra/mongomatic'
require 'models.rb'

class Teste < Sinatra::Base
  
  register Sinatra::Mongomatic

#  mongomatic Mongo::Connection.new("localhost").db("RMU")
  conn = Mongo::Connection.new('flame.mongohq.com', 27064)
  conn.add_auth('RAM','rmu','unicorn')
  Mongomatic.db = conn.db('RMU')

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
    #{puts User.find( {'name' => 'Ben'} )}
    <p></p><p></p>
    
    <p>#{u.insert!}</p>
    
    #{auth['user_info']['name']}<br>
    #{auth['user_info']['nickname']}<br>
    #{auth['credentials']['token']}<br>
    #{auth['credentials']['secret']}"
  end
  
  get '/db' do
    cursor = User.find({'nick'=>'locks'})

    cursor.inspect.to_s + cursor.next
#    User.find( {'nick' => 'locks' })
  end

end