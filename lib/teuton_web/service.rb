# frozen_string_literal: true

require 'sinatra/base'

require_relative 'application'
require_relative 'helpers'
require_relative 'route/route_snode'
require_relative 'route/route_tnode'

##
# Service Sinatra class
class Service < Sinatra::Base
  use Rack::Session::Pool

  set :root,          File.join(File.dirname(__FILE__), '..', '..')
  set :views,         File.join(File.dirname(__FILE__), 'views')
  set :public_folder, File.join(File.dirname(__FILE__), 'public')

  helpers  Sinatra::Service::Helpers
  register Sinatra::Service::RouteSnode
  register Sinatra::Service::RouteTnode

  get '/' do
    @mode = 'choose'
    erb :'/index/choose'
  end

  get '/choose' do
    redirect '/'
  end
end
