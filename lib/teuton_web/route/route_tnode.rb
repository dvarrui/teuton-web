
require 'yaml'

module Sinatra
  module Service
    module RouteTnode
      def self.registered(app)
        app.get '/tnode' do
          @mode = 'tnode'
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
          @mode = 'tnode'
          a = s2f(params[:input])
          content = File.read(a)
          "<pre>#{content}</pre>"
        end

        # Show filename on raw mode
        app.get '/tnode/files/:input' do
          @mode = 'tnode'
          dirpath = s2f(params[:input])
          files = Dir.glob(File.join(dirpath, '**', '*.rb')) +
                  Dir.glob(File.join(dirpath, '**', '*.md'))
          @test = { id: params[:input],
                    dirpath: dirpath,
                    files: files.sort
                  }
          files = Dir.glob(File.join(dirpath, '**', '*.yaml')) +
                  Dir.glob(File.join(dirpath, '**', '*.json'))
          @config = { dirpath: dirpath,
                      files: files.sort }
          erb :"tnode/files"
        end

        app.get '/tnode/resume/:input' do
          @mode = 'tnode'
          dirpath = s2f(params[:input])
          files = Dir.glob(File.join(dirpath, '**', '*.rb')) +
                  Dir.glob(File.join(dirpath, '**', '*.yaml')) +
                  Dir.glob(File.join(dirpath, '**', '*.md'))
          @test = { id: params[:input],
                    testname: File.basename(s2f(params[:input])),
                    dirpath: dirpath }
          testname = File.basename(s2f(params[:input]))
          @resume = YAML.load_file(File.join('var', testname, 'resume.yaml'))
          erb :"tnode/resume"
        end

        app.get '/tnode/params/:input' do
          @mode = 'tnode'
          dirpath = s2f(params[:input])
          @test = { id: params[:input],
                    dirpath: dirpath }
          testname = File.basename(s2f(params[:input]))
          @resume = YAML.load_file(File.join('var', testname, 'resume.yaml'))
          erb :"tnode/params"
        end

        # Show filename on raw mode
        app.get '/tnode/reports/:input' do
          @mode = 'tnode'
          dirpath = s2f(params[:input])
          files = Dir.glob(File.join(dirpath, '**', '*.rb')) +
                  Dir.glob(File.join(dirpath, '**', '*.yaml')) +
                  Dir.glob(File.join(dirpath, '**', '*.md'))
          @test = { id: params[:input],
                    dirpath: dirpath }
          testname = File.basename(s2f(params[:input]))
          dirpath = File.join('var', testname)
          files = Dir.glob(File.join(dirpath, '*.txt')) +
                  Dir.glob(File.join(dirpath, '*.json')) +
                  Dir.glob(File.join(dirpath, '*.yaml'))
          @reports = { testname: testname,
                       dirpath: dirpath,
                       files: files.sort }
          erb :"tnode/reports"
        end

        # Show filename using YAML data
        app.get '/tnode/test/:testpath/case/:filename/targets' do
          @mode = 'tnode'
          @testpath = params[:testpath]
          @data = YAML.load_file(s2f(params[:filename]))
          erb :"tnode/case/targets"
        end
      end
    end
  end
end
