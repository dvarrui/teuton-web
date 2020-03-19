
require 'yaml'

module Sinatra
  module Service
    module RouteSnode
      def self.registered(app)
        app.get '/snode' do
          @mode = :Snode
          @current = Dir.pwd
          @list = []
          filenames = Dir.glob(File.join(@current, "**")).sort!
          filenames.each do |filepath|
            item = { filename: File.basename(filepath) }
            stat = File.stat(filepath).ctime
            ctime = { year: stat.year, month: stat.month, day: stat.day,
                      hour: stat.hour, min: stat.min, sec: stat.sec }
            timestamp = format("%<year>04d-%<month>02d-%<day>02d %<hour>02d:%<min>02d:%<sec>02d", ctime)
            item[:timestamp] = timestamp
            item[:link] = true
            item[:link] = false unless item[:filename].start_with? 'case-'
            item[:ext] = File.extname(item[:filename])
            item[:grade] = ''
            item[:show] = false
            if item[:ext] == '.yaml' && item[:link]
              item[:show] = true
              data = YAML.load_file(filepath)
              item[:grade] = data[:results][:grade]
            elsif item[:ext] == '.txt' && item[:link]
              data = File.read(filepath).split("\n")
              item[:grade] = data[data.size-2].split(' ')[3]
            end
            @list << item
          end
          erb :"snode/index"
        end

        # Show filename on raw mode
        app.get '/snode/report/:filename/raw' do
          @mode = :Snode
          content = File.read(params[:filename])
          "<pre>#{content}</pre>"
        end

        # Show filename params
        app.get '/snode/report/:filename/config' do
          @mode = :Snode
          @data = YAML.load_file(params[:filename])
          erb :"snode/config"
        end

        # Show filename using YAML data
        app.get '/snode/report/:filename/targets' do
          @mode = :Snode
          @data = YAML.load_file(params[:filename])
          erb :"snode/targets"
        end

        # Show filename using YAML data
        app.get '/snode/report/:filename/target/:id' do
          @mode = :Snode
          @data = YAML.load_file(params[:filename])
          erb :"snode/target"
        end

        # Show filename params
        app.get '/snode/report/:filename/results' do
          @mode = :Snode
          @data = YAML.load_file(params[:filename])
          erb :"snode/results"
        end
      end
    end
  end
end
