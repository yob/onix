require File.expand_path('../lib/onix2/version', __FILE__)

Gem::Specification.new do |s|
  s.name              = "onix2"
  s.version           = ONIX2::VERSION
  s.summary           = "A convient mapping between ruby objects and the ONIX 2.1 XML specification"
  s.description       = "A convient mapping between ruby objects and the ONIX 2.1 XML specification"
  s.authors           = ["Evgeny Li"]
  s.email             = ["exAspArk@gmail.com"]
  s.has_rdoc          = true
  s.homepage          = "http://github.com/exAspArk/onix2"
  s.rdoc_options     << "--title" << "ONIX - Working with the ONIX XML spec" <<
                        "--line-numbers"
  s.test_files        = Dir.glob("spec/**/*.rb")
  s.files             = Dir.glob("{lib,support,dtd}/**/**/*") + ["README.markdown", "TODO", "CHANGELOG"]

  s.add_dependency('activesupport', '>= 3.0.5')
  s.add_dependency('i18n')
  s.add_dependency('nokogiri', '~>1.4')
  s.add_dependency('representable')
  s.add_dependency('virtus')

  s.add_development_dependency("rake")
  s.add_development_dependency("rspec", ">=2.12")
  s.add_development_dependency("rspec-given")
  s.add_development_dependency("pry")

  s.required_ruby_version = '>= 1.9'
end
