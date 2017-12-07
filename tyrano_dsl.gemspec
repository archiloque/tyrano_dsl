lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tyrano_dsl/version'

Gem::Specification.new do |spec|
  spec.name          = 'tyrano_dsl'
  spec.version       = TyranoDsl::VERSION
  spec.authors       = ['Julien Kirch']

  spec.summary       = 'TyranoBuilder DSL'
  spec.description   = 'A DSL to generate TyranoBuilder games from human-readable ruby'
  spec.homepage      = 'https://github.com/archiloque/tyrano_dsl'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'bin'
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.14'
  spec.add_development_dependency 'yard', '~> 0.9.12'
  spec.add_development_dependency 'redcarpet', '~> 3.4.0'
  spec.add_development_dependency 'simplecov', '~> 0.15.1'
end
