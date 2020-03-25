
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

    dirpath = File.join('var', test[:testname])
    files = Dir.glob(File.join(dirpath, '*.txt')) +
            Dir.glob(File.join(dirpath, '*.json')) +
            Dir.glob(File.join(dirpath, '*.yaml'))
    test[:reportfiles] = files.sort

    test[:exist] = { configyaml: false, resumeyaml: false }

    a = test[:configfiles].select { |i| i.include?('config.yaml') }
    test[:exist][:configyaml] = true if a.size.positive?

    a = test[:reportfiles].select { |i| i.include?('resume.yaml') }
    test[:exist][:resumeyaml] = true if a.size.positive?

    test
  end

  def self.read_config_data(id)
    filename = File.join(s2f(id), 'config.yaml')
    return { cases: [] } unless File.exist? filename
    YAML.load_file(filename)
  end

  def self.read_resume_data(testname)
    filename = File.join(File.join('var', testname, 'resume.yaml'))
    return :none unless File.exist? filename
    YAML.load_file(filename)
  end

  private_class_method def self.s2f(string)
    string.gsub('$','/')
  end
end
