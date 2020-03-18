# frozen_string_literal: true

##
# Utils functions
module Utils
  def self.gems
    %w[sinatra minitest yard rubocop]
  end

  def self.check_gems(gems)
    fails = filter_uninstalled_gems(gems)
    puts "[ FAIL ] Gems to install!: #{fails.join(',')}" unless fails == []
  end

  def self.check_tests
    testfile = File.join('.', 'tests', 'all.rb')
    a = File.read(testfile).split("\n")
    b = a.select { |i| i.include? '_test' }
    d = File.join('.', 'tests', '**', '*_test.rb')
    e = Dir.glob(d)
    puts "[ FAIL ] Some ruby tests are not executed by #{testfile}" \
         unless b.size == e.size
    puts "[ INFO ] Running #{testfile}"
    system(testfile)
  end

  def self.filter_uninstalled_gems(list)
    cmd = `gem list`.split("\n")
    names = cmd.map { |i| i.split(' ')[0] }
    fails = []
    list.each { |i| fails << i unless names.include?(i) }
    fails
  end

  def self.install_gems(list)
    fails = filter_uninstalled_gems(list)
    if !fails.empty?
      puts '[ INFO ] Installing gems...'
      fails.each do |name|
        system("gem install #{name}")
      end
    else
      puts '[  OK  ] Gems installed'
    end
  end

  def self.create_symbolic_link
    puts '[ INFO ] Creating symbolic link into /usr/local/bin'
    basedir = File.dirname(__FILE__)
    system("ln -s #{basedir}/teuton-server /usr/local/bin/teuton-web")
  end
end
