
require 'yaml'

module TnodeModel
  def self.find_all_tests
    tests = []
    filenames = Dir.glob(File.join('**', 'start.rb')).sort!
    filenames.each do |filepath|
      next if filepath.include? '.devel/'
      tests << File.dirname(filepath)
    end
    tests
  end

  def self.find_test_by_id(id)
    dirpath = s2f(id)
    files = Dir.glob(File.join(dirpath, '**', '*.rb')) +
            Dir.glob(File.join(dirpath, '**', '*.md'))
    test = { id: id,
             testname: File.basename(dirpath),
             dirpath: dirpath,
             testfiles: files.sort }
    files = Dir.glob(File.join(dirpath, '**', '*.yaml')) +
            Dir.glob(File.join(dirpath, '**', '*.json'))
    test[:configfiles] = files.sort
    test
  end

  def self.get_config_data(id)
    config = YAML.load_file(File.join(s2f(id), 'config.yaml'))
  end

  private_class_method def self.s2f(string)
    string.gsub('$','/')
  end
end
