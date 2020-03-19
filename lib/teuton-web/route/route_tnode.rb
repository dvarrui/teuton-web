
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
            @tests << filepath
          end
          erb :"tnode/index"
        end

        # Show filename on raw mode
        app.get '/tnode/raw/:filepath' do
          @mode = :tnode
          content = File.read(string_to_filepath(params[:filepath]))
          "<pre>#{content}</pre>"
        end

        # Show filename on raw mode
        app.get '/tnode/show/:id' do
          @mode = :tnode
          list = []
          filenames = Dir.glob(File.join('**', 'start.rb')).sort!
          filenames.each do |filepath|
            next if filepath.include? '.devel/'
            list << filepath
          end
          filepath = list[(params[:id].to_i - 1)]
          dirname = File.dirname(filepath)
          @test = { id: params[:id],
                    filepath: filepath,
                    dirname: dirname,
                    files: Dir.glob(File.join(dirname, '**'))
                  }
          erb :"tnode/show"
        end
      end
    end
  end
end
