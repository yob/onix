Gem::Specification.new do |s|
  s.name              = "onix"
  s.version           = "0.9.5"
  s.summary           = "A convient mapping between ruby objects and the ONIX XML specification"
  s.description       = "A convient mapping between ruby objects and the ONIX XML specification"
  s.authors           = ["James Healy"]
  s.email             = ["jimmy@deefa.com"]
  s.has_rdoc          = true
  s.homepage          = "http://github.com/yob/onix"
  s.rdoc_options     << "--title" << "ONIX - Working with the ONIX XML spec" <<
                        "--line-numbers"
  s.test_files        = Dir.glob("spec/**/*.rb")
  s.files             = Dir.glob("{lib,support,dtd}/**/**/*") + ["README.markdown", "TODO", "CHANGELOG"]

  s.add_dependency('roxml', '~>3.3.1')
  s.add_dependency('activesupport', '>= 3.0.5')
  s.add_dependency('i18n')
  s.add_dependency('andand')
  s.add_dependency('nokogiri', '~>1.4')

  s.add_development_dependency("rake")
  s.add_development_dependency("rspec", "~>2.1")
end
