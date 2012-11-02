# -*- encoding: utf-8 -*-
require File.expand_path('../lib/secret_data/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Alexander Wenzowski"]
  gem.email         = ["alexander@wenzowski.com"]
  gem.description   = %q{A helper class for silencing secret data.}
  gem.summary       = <<-EOF
    SecretData loads sensitives strings from YAML, ENV, or Hash and 
    automatically generates a placeholder string that is safe to publsh
    publicly, yet descriptive enough not to inhibit debugging.
  EOF
  gem.homepage      = "https://github.com/wenzowski/secret_data"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "secret_data"
  gem.require_paths = ["lib"]
  gem.version       = SecretData::VERSION
end
