
require 'yaml'

module Sinatra
  module Service
    module RouteTnode
      def self.registered(app)
        app.get '/tnode' do
          @mode = :tnode
          @tests = []
          filenames = Dir.glob(File.join('**', 'start.rb')).sort!
          filenames.each do |filepath|
            next if filepath.include? '.devel/'
            @tests << File.dirname(filepath)
          end
          erb :"tnode/index"
        end

        # Show filename on raw mode
        app.get '/tnode/raw/:input' do
          @mode = :tnode
          a = s2f(params[:input])
          content = File.read(a)
          "<pre>#{content}</pre>"
        end

        # Show filename on raw mode
        app.get '/tnode/show/:input' do
          @mode = :tnode
          dirpath = s2f(params[:input])
          @test = { id: params[:input],
                    dirpath: dirpath,
                    files: Dir.glob(File.join(dirpath, '**')),
                    outputdir: File.join('var', File.basename(dirpath))
                  }
          puts @test
          erb :"tnode/show"
        end
      end
    end
  end
end
