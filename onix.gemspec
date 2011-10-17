Gem::Specification.new do |s|
  s.name              = "onix"
  s.version           = "0.9.1"
  s.summary           = "A convenient mapping between Ruby objects and the " +
                        "ONIX XML specification"
  s.description       = "ONIX is the standard XML format for electronic data " +
                        "sharing in the book and publishing industries. This " +
                        "library provides a slim layer over the format and " +
                        "simplifies both reading and writing ONIX files in " +
                        "your Ruby applications."
  s.authors           = ["James Healy"]
  s.email             = ["jimmy@deefa.com"]
  s.homepage          = "http://github.com/yob/onix"
  s.rdoc_options     << "--title" << "ONIX - Working with the ONIX XML spec" <<
                        "--line-numbers"
  s.test_files        = Dir.glob("spec/**/*.rb")
  s.files             = Dir.glob("{lib,support,dtd}/**/**/*") + ["README.markdown", "TODO", "CHANGELOG"]

  s.add_dependency('roxml', '~>3.1.6')
  s.add_dependency('activesupport', '>= 3.0.5')
  s.add_dependency('i18n')
  s.add_dependency('nokogiri', '>=1.4')

  s.add_development_dependency("rake")
  s.add_development_dependency("rspec", "~>2.1")
end
