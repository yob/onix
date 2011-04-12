require "rubygems"
require "bundler"
Bundler.setup

require 'rake'
require 'rake/rdoctask'
require 'rspec/core/rake_task'
require 'rake/gempackagetask'

desc "Default Task"
task :default => [ :spec ]

desc "Run all rspec files"
RSpec::Core::RakeTask.new("spec") do |t|
  t.rspec_opts  = ["--color", "--format progress"]
end

desc "Generate documentation"
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'ONIX'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README.markdown')
  rdoc.rdoc_files.include('TODO')
  rdoc.rdoc_files.include('CHANGELOG')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

desc "Build the onix gem"
Rake::GemPackageTask.new(eval(File.read('onix.gemspec'))) do |g|
  g.need_zip = true
end
