
require 'yaml'
require_relative 'snode_utils'

module Sinatra
  module Service
    module SnodeController
      def self.registered(app)
        app.get '/snode' do
          @mode = 'snode'
          @list = SnodeUtils.get_snode_report_files
          erb :"snode/index"
        end

        # Show filename on raw mode
        app.get '/snode/report/:filename/raw' do
          @mode = 'snode'
          content = File.read(params[:filename])
          "<pre>#{content}</pre>"
        end

        # Show filename params
        app.get '/snode/report/:filename/config' do
          @mode = 'snode'
          @data = YAML.load_file(params[:filename])
          erb :"snode/config"
        end

        # Show filename params
        app.get '/snode/report/:filename/results' do
          @mode = 'snode'
          @data = YAML.load_file(params[:filename])
          erb :"snode/results"
        end

        # Show filename params
        app.get '/snode/report/:filename/logs' do
          @mode = 'snode'
          @data = YAML.load_file(params[:filename])
          erb :"snode/logs"
        end

        # Show filename using YAML data
        app.get '/snode/report/:filename/targets' do
          @mode = 'snode'
          @data = YAML.load_file(params[:filename])
          erb :"snode/targets"
        end

        # Show filename using YAML data
        app.get '/snode/report/:filename/target/:id' do
          @mode = 'snode'
          @data = YAML.load_file(params[:filename])
          @target = nil
          first = nil
          @data[:groups].each do |group|
            group[:targets].each do |target|
              first = target if target[:target_id].to_i == 1
              @target = target if target[:target_id] == params[:id]
            end
          end
          puts first
          puts @target
          @target = first if @target.nil?
          erb :"snode/target"
        end
      end
    end
  end
end
