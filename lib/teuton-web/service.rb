
require 'sinatra/base'

require_relative 'application'
require_relative 'helpers'
require_relative 'route/route_client'
require_relative 'route/route_dir'
require_relative 'route/route_file'
require_relative 'route/route_snode'
require_relative 'formatter/concept_haml_formatter'

# SinatraFrontEnd class:
# * get
# * load_dir
# * load_file
class Service < Sinatra::Base
  use Rack::Session::Pool

  set :root,          File.join( File.dirname(__FILE__), '..', '..' )
  set :views,         File.join( File.dirname(__FILE__), 'views')
  set :public_folder, File.join( File.dirname(__FILE__), 'public')

  helpers  Sinatra::Service::Helpers
  register Sinatra::Service::RouteClient
  register Sinatra::Service::RouteDir
  register Sinatra::Service::RouteFile
  register Sinatra::Service::RouteSnode

  get '/' do
    @mode = :choose
    erb :'/index/choose'
  end

  get '/choose' do
    redirect '/'
  end

  def load_dir(dir)
    @filenames = Dir[dir + "/**"].sort!
  end

  def load_file(filename)
    return open(filename) { |i| i.read }
  end
end
