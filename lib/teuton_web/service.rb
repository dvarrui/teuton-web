# frozen_string_literal: true

require 'sinatra/base'

require_relative 'application'
require_relative 'controllers/snode_controller'
require_relative 'controllers/tnode_controller'
require_relative 'helpers/main_helper'
require_relative 'models/environment_model'

##
# Service Sinatra class
class Service < Sinatra::Base
  use Rack::Session::Pool

  set :root,          File.join(File.dirname(__FILE__), '..', '..')
  set :views,         File.join(File.dirname(__FILE__), 'views')
  set :public_folder, File.join(File.dirname(__FILE__), 'public')

  helpers  Sinatra::Service::MainHelper
  register Sinatra::Service::SnodeController
  register Sinatra::Service::TnodeController

  get '/' do
    @mode = 'choose'
    @env = { tnode: EnvironmentModel.tnode?, 
             snode: EnvironmentModel.snode? }
    erb :'/index/choose'
  end

  get '/choose' do
    redirect '/'
  end
end
