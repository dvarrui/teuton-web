
module Sinatra
  module Service
    module RouteSnode
      def self.registered(app)
        app.get '/snode' do
          @mode = :Snode
          @current = File.join(Dir.pwd)
          load_dir @current
          erb :"snode/index"
        end
      end
    end
  end
end
