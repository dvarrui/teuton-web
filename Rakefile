# frozen_string_literal: true

require_relative 'tasks/build'
require_relative 'tasks/install'

desc 'Default: check'
task :default do
  Rake::Task['install:check'].invoke
end

desc 'Rake help'
task :help do
  system('rake -T')
end
