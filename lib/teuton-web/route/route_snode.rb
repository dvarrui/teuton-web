
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

        app.get '/snode/report/raw/:filename' do
          @mode = :Snode
          content = File.read(params[:filename])
          "<pre>#{content}</pre>"
        end
      end
    end
  end
end
