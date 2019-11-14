require_relative 'teuton-web/service'

##
# Module TeutonWeb
module TeutonWeb
  ##
  # Up TeutonWeb service.
  def self.up
    puts "Running TeutonWeb..."
    Service.run!
  end
end
