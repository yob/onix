begin
  require 'spec'
rescue LoadError
  require 'rubygems'
  require 'spec'
end

require 'rake/rdoctask'
require 'spec/rake/spectask'
require 'rake/gempackagetask'

# allow require of spec/spec_helper
$LOAD_PATH.unshift File.dirname(__FILE__) + '/../'
$LOAD_PATH.unshift File.dirname(__FILE__) + '/lib'

require 'onix'

desc "Default Task"
task :default => [ :spec ]

desc 'Generate documentation'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'Riddle - Ruby Sphinx Client'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('TODO')
  rdoc.rdoc_files.include('CHANGELOG')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

desc "Run the specs under spec"
Spec::Rake::SpecTask.new do |t|
  t.spec_files = FileList['spec/**/*_spec.rb']
end

desc "Generate RCov reports"
Spec::Rake::SpecTask.new(:rcov) do |t|
  t.libs << 'lib'
  t.spec_files = FileList['spec/**/*_spec.rb']
  t.spec_opts = ['-c']
  t.rcov = true
  t.rcov_opts = ['--exclude', 'spec', '--exclude', 'gems', '--exclude', 'riddle']
end

spec = Gem::Specification.new do |s|
  s.name              = "onix"
  s.version           = ONIX::Version::String
  s.summary           = "A convient mapping between ruby objects and the ONIX XML specification"
  s.description       = "A convient mapping between ruby objects and the ONIX XML specification"
  s.author            = "James Healy"
  s.email             = "jimmy@deefa.com"
  s.has_rdoc          = true
  s.rdoc_options     << "--title" << "ONIX - Working with the ONIX XML spec" <<
                        "--line-numbers"
  s.test_files        = FileList["spec/**/*_spec.rb"]
  s.files             = FileList[
    "lib/**/*.rb",
    "README.rdoc",
    "TODO",
    "CHANGELOG",
    "tasks/**/*.rb",
    "tasks/**/*.rake"
  ]
  s.add_dependency('roxml', '2.1')
end

Rake::GemPackageTask.new(spec) do |p|
  p.gem_spec = spec
  p.need_tar = true
  p.need_zip = true
end
