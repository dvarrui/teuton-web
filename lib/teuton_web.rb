# frozen_string_literal: true

require_relative 'teuton_web/application'
require_relative 'teuton_web/service'

# Module TeutonWeb
module TeutonWeb
  ##
  # Up TeutonWeb service
  def self.up
    puts '[INFO] Running TeutonWeb ' \
         "(version #{TeutonWeb::Application::VERSION})..."
    Service.run!
  end
end
