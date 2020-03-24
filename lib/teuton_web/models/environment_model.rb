
require_relative 'snode_model'

module EnvironmentModel
  ##
  # exists Snode enviroment?
  # @return Boolean
  def self.snode?
    SnodeModel.find_files.size.positive?
  end

  ##
  # exists Tnode enviroment?
  # @return Boolean
  def self.tnode?
    system('teuton version')
  end
end
