# frozen_string_literal: true

require 'singleton'

##
# Global parameters
module TeutonWeb
  class Config
    include Singleton
    attr_accesor :param

    def initialize
      @param = { mode: :choose }
    end
  end
end
