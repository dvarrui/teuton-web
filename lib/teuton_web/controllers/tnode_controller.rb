
require 'yaml'
require_relative '../models/tnode_model'

module Sinatra
  module Service
    module TnodeController
      def self.registered(app)
        app.get '/tnode' do
          @mode = 'tnode'
          @tests = TnodeModel.find_all_tests
          erb :"tnode/index"
        end

        # Show files for :input test
        app.get '/tnode/files/:id' do
          @mode = 'tnode'
          @test = TnodeModel.find_test_by_id(params[:id])
          erb :"tnode/files"
        end

        # Show filename on raw mode
        app.get '/tnode/raw/:id' do
          @mode = 'tnode'
          content = File.read(s2f(params[:id]))
          "<pre>#{content}</pre>"
        end

        app.get '/tnode/cases/:id' do
          @mode = 'tnode'
          @test = TnodeModel.find_test_by_id(params[:id])
          @config = TnodeModel.read_config_data(params[:id])
          erb :"tnode/cases"
        end

        app.get '/tnode/resume/:id' do
          @mode = 'tnode'
          @test = TnodeModel.find_test_by_id(params[:id])
          @resume = TnodeModel.read_resume_data(@test[:testname])
          erb :"tnode/resume"
        end

        app.get '/tnode/params/:id' do
          @mode = 'tnode'
          @test = TnodeModel.find_test_by_id(params[:id])
          @resume = TnodeModel.read_resume_data(@test[:testname])
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
