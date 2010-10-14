require 'rubygems'
require 'sinatra/base'
require 'omniauth'
require 'openid/store/filesystem'

class Teste < Sinatra::Base
use OmniAuth::Builder do
  provider :open_id, OpenID::Store::Filesystem.new('/tmp')
#  provider :twitter, 'Hug9xynciWO5lAOK9VkQ', 'HKiHJuaw5U7vm4dX9SJQ1UF5OFs6238j1NcyfO4Y4'
  provider :twitter, 'ZrxnngDLk0AXdOy17ZVqxg', 'LB3ackpiT0fZo0wiVvT4kmVZk8LuyPKOoCx3aYxew'

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
end