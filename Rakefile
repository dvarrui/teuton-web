# frozen_string_literal: true

gems = %w[rainbow thor minitest]

desc 'Default: check'
task default: :check do
end

desc 'Check installation'
task :check do
  check_gems gems
  check_tests
  Rake::Task['build'].invoke
end

desc 'Rake help'
task :help do
  system('rake -T')
end

desc 'Build gem'
task :build do
  puts "[ INFO ] Building gem..."
  system('rm teuton-web-*.*.*.gem')
  system('gem build teuton-web.gemspec')
  puts "[ INFO ] Generating documentation..."
  system('rm -r html/')
  system('yardoc lib/* -o html --files ' +
         Dir.glob(File.join('docs','**','*.md')).join(',') )
end

desc 'Developer installation'
task :developer_install do
  install_gems gems
  create_symbolic_link
end

def check_gems(gems)
  fails = filter_uninstalled_gems(gems)
  puts "[ FAIL ] Gems to install!: #{fails.join(',')}" unless fails == []
end

def check_tests
  testfile = File.join('.', 'tests', 'all.rb')
  a = File.read(testfile).split("\n")
  b = a.select { |i| i.include? '_test' }
  d = File.join('.', 'tests', '**', '*_test.rb')
  e = Dir.glob(d)
  puts "[ FAIL ] Some ruby tests are not executed by" +
       "#{testfile}" unless b.size == e.size
  puts "[ INFO ] Running #{testfile}"
  system(testfile)
end

def filter_uninstalled_gems(list)
  cmd = `gem list`.split("\n")
  names = cmd.map { |i| i.split(' ')[0] }
  fails = []
  list.each { |i| fails << i unless names.include?(i) }
  fails
end

def install_gems list
  fails = filter_uninstalled_gems(list)
  if !fails.empty?
    puts "[ INFO ] Installing gems..."
    fails.each do |name|
      system("gem install #{name}")
    end
  else
    puts '[  OK  ] Gems installed'
  end
end

def create_symbolic_link
  puts '[ INFO ] Creating symbolic link into /usr/local/bin'
  basedir = File.dirname(__FILE__)
  system("ln -s #{basedir}/teuton-server /usr/local/bin/teuton-web")
end
