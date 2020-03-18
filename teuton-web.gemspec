require_relative 'lib/teuton-web/application'

Gem::Specification.new do |s|
  s.name        = TeutonWeb::Application::NAME
  s.version     = TeutonWeb::Application::VERSION
  s.date        = '2020-03-18'
  s.summary     = "TeutonWeb UNDER CONSTRUCTION!"
  s.description = <<-EOF
  TeutonWeb (Teuton Software project).
  UNDER CONSTRUCTION!
  EOF
  s.extra_rdoc_files = [ 'README.md' ] +
                       Dir.glob(File.join('docs','**','*.md'))

  s.license     = 'GPL-3.0'
  s.authors     = ['David Vargas Ruiz']
  s.email       = 'teuton.software@protonmail.com'
  s.homepage    = 'https://github.com/dvarrui/teuton-web'

  s.executables << 'teuton-web'
  s.files       = Dir.glob(File.join('lib','**','*.rb')) +
                  Dir.glob(File.join('docs','**','*.md'))

  s.add_runtime_dependency 'sinatra', '~> 2.0'

  s.add_development_dependency 'minitest', '~> 5.11'
end
