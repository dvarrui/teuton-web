
require_relative '../models/snode_model'

module Sinatra
  module Service
    module SnodeController
      def self.registered(app)
        app.get '/snode' do
          @mode = 'snode'
          @list = SnodeModel.get_report_files
          erb :"snode/index"
        end

        # Show filename on raw mode
        app.get '/snode/report/:filename/raw' do
          @mode = 'snode'
          content = SnodeModel.get_raw_content(params[:filename])
          "<pre>#{content}</pre>"
        end

        # Show filename params
        app.get '/snode/report/:filename/config' do
          @mode = 'snode'
          @data = SnodeModel.get_yaml_content(params[:filename])
          erb :"snode/config"
        end

        # Show filename params
        app.get '/snode/report/:filename/results' do
          @mode = 'snode'
          @data = SnodeModel.get_yaml_content(params[:filename])
          erb :"snode/results"
        end

        # Show filename params
        app.get '/snode/report/:filename/logs' do
          @mode = 'snode'
          @data = SnodeModel.get_yaml_content(params[:filename])
          erb :"snode/logs"
        end

        # Show filename using YAML data
        app.get '/snode/report/:filename/targets' do
          @mode = 'snode'
          @data = SnodeModel.get_yaml_content(params[:filename])
          erb :"snode/targets"
        end

        # Show filename using YAML data
        app.get '/snode/report/:filename/target/:id' do
          @mode = 'snode'
          @data = SnodeModel.get_yaml_content(params[:filename])
          @target = SnodeModel.get_target(@data, params[:id])
          erb :"snode/target"
        end
      end
    end
  end
end
