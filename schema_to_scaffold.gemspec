# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'schema_to_scaffold/version'

Gem::Specification.new do |gem|
  gem.name          = "schema_to_scaffold"
  gem.version       = SchemaToScaffold::VERSION
  gem.authors       = ["Humberto Pinto", "João Soares"]
  gem.email         = ["h.lsp999@gmail.com", "jsoaresgeral@gmail.com"]
  gem.description   = <<-EOD
  Command line app for windows and linux which parses a schema.rb file obtained from your rails repo or by running rake:schema:dump
EOD
  gem.summary       = %q{Generate rails scaffold script from a schema.rb file.}
  gem.homepage      = "http://github.com/frenesim/schema_to_scaffold"
  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency "active_support"
end
