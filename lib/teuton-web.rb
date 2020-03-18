require_relative 'teuton-web/application'
require_relative 'teuton-web/service'

# Module TeutonWeb
module TeutonWeb
  ##
  # Up TeutonWeb service
  def self.up
    puts "Running TeutonWeb (version #{TeutonWeb::Application::VERSION})..."
    Service.run!
  end
end
