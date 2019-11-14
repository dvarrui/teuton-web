#!/usr/bin/ruby

require 'thor'
require_relative 'application'
require_relative '../teuton-web'

# Command Line User Interface
class TeutonWebCLI < Thor
  map ['h', '-h', '--help'] => 'help'

  map ['u', '-u', '--up'] => 'up'
  desc 'up', 'Start TeutonServer'
  def up
    TeutonWeb.up
  end

  map ['v', '-v', '--version'] => 'version'
  desc 'version', 'show the program version'
  def version
    puts "#{Application::NAME} (version #{Application::VERSION})"
  end
end
