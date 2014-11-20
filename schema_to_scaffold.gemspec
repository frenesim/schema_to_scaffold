# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'schema_to_scaffold/version'

Gem::Specification.new do |gem|
  gem.name          = "schema_to_scaffold"
  gem.version       = SchemaToScaffold::VERSION
  gem.authors       = ["João Soares", "Humberto Pinto"]
  gem.email         = ["jsoaresgeral@gmail.com", "hlsp999@gmail.com"]
  gem.description   = <<-EOD
  Command line app which parses a schema.rb file obtained from your rails repo or by running rake:schema:dump
EOD
  gem.summary               = %q{Generate rails scaffold script from a schema.rb file.}
  gem.homepage              = "http://github.com/frenesim/schema_to_scaffold"
  gem.bindir                = "bin"
  gem.files                 = `git ls-files`.split($/)
  gem.executables           = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.require_paths         = ["lib"]
  gem.post_install_message  = "Thanks for installing!"
  gem.licenses              = ['MIT']
  gem.required_ruby_version = '>= 1.9.3'

  gem.add_dependency('activesupport', '>= 3.2.1')
  gem.add_development_dependency('pry', '~> 0.10', '>= 0.10.0')
end
