require 'sinatra'
require 'json'
require 'redis'
require 'omniauth'
require 'omniauth-facebook'
R = Redis.new
get '/' do 
  <<-HTML
      <a href='/auth/facebook'>Sign in with facebook</a>
      <a href='/logout'>Logout</a>
  HTML
end

get '/auth/facebook/callback' do 
  @auth = env['omniauth.auth']
  if !R.get(@auth['uid'])
    R.set(@auth['uid'], {"name"=>@auth['info']['name'], "email"=>@auth['info']['email'], "location"=>@auth['info']['location'], "favorites"=>[1,2, 3]}.to_json)
  end
  user = JSON.parse(R.get(@auth['uid']))
  #["provider", "uid", "info", "credentials", "extra"]
  " #{@auth['uid']} | #{user['name']} | #{user['email']} | #{user['location']} | #{user['favorites']}" 
end

get '/logout' do 
end


