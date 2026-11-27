# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'candy_check/version'

Gem::Specification.new do |spec|
  spec.name          = 'candy_check'
  spec.version       = CandyCheck::VERSION
  spec.authors       = ['Jonas Thiel']
  spec.email         = ['jonas@thiel.io']
  spec.summary       = 'Check and verify in-app receipts'
  spec.homepage      = 'https://github.com/jnbt/candy_check'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = Gem::Requirement.new('>= 4.0')

  spec.add_dependency 'activesupport', '>= 7.0'
  spec.add_dependency 'google-apis-androidpublisher_v3', '0.39.0'
  spec.add_dependency 'multi_json',        '~> 1.10'
  spec.add_dependency 'thor',              '~> 1.1'

  spec.add_development_dependency 'minitest',      '~> 6.0'
  spec.add_development_dependency 'minitest-mock', '~> 5.27'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake',          '~> 13.0'
  spec.add_development_dependency 'rubocop',       '~> 1.92'
  spec.add_development_dependency 'timecop',       '~> 0.9'
  spec.add_development_dependency 'webmock',       '~> 3.0'
  spec.metadata['rubygems_mfa_required'] = 'true'
end
