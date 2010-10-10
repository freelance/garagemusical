require 'rubygems'
require 'sinatra'
require 'omniauth'
require 'openid/store/filesystem'

use OmniAuth::Builder do
  provider :open_id, OpenID::Store::Filesystem.new('/tmp')
  provider :twitter, 'consumerkey', 'consumersecret'
end

enable :sessions
enable :run

get '/' do
  <<-HTML
  <a href='/auth/twitter'>Sign in with Twitter</a>

  <form action='/auth/open_id' method='post'>
    <input type='text' name='identifier'/>
    <input type='submit' value='Sign in with OpenID'/>
  </form>
  HTML
end

get '/auth/:name/callback' do
  auth = request.env['rack.auth']
  # do whatever you want with the information!
  puts auth.inspect
end
