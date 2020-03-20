# frozen_string_literal: true

require_relative '../teuton_web'
require_relative 'application'

# Module Command line interface
module CLI
  ##
  # Up TeutonWeb service
  def self.start(argv)
    if %w[version v --version -v].include? argv[0]
      puts "TeutonWeb (version #{TeutonWeb::Application::VERSION})"
      exit 0
    end
    TeutonWeb.up
  end
end
