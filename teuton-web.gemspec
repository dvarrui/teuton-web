require_relative 'lib/teuton_web/application'

Gem::Specification.new do |s|
  s.name        = TeutonWeb::Application::NAME
  s.version     = TeutonWeb::Application::VERSION
  s.date        = '2020-03-20'
  s.summary     = "TeutonWeb is web front end for Teuton software."
  s.description = <<-EOF
  TeutonWeb is web front end for Teuton software
  EOF
  s.extra_rdoc_files = [ 'README.md', 'LICENSE.txt' ] +
                       Dir.glob(File.join('docs','**','*.md'))

  s.license     = 'GPL-3.0'
  s.authors     = ['David Vargas Ruiz']
  s.email       = 'teuton.software@protonmail.com'
  s.homepage    = 'https://github.com/dvarrui/teuton-web'

  s.executables << 'teuton-web'
  s.files       = Dir.glob(File.join('lib','**','*.rb')) +
                  Dir.glob(File.join('docs','**','*.md'))

  s.required_ruby_version = '>= 2.5.0'
  s.add_runtime_dependency 'sinatra', '~> 2.0'
  s.add_runtime_dependency 'teuton', '~> 2.1'
  s.add_runtime_dependency 'teuton-server', '~> 0.0'
  s.add_runtime_dependency 'teuton-client', '~> 0.0'

  s.add_development_dependency 'minitest', '~> 5.11'
  s.add_development_dependency 'rubocop', '~> 0.74'
end
