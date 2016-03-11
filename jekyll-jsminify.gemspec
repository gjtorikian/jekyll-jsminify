# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'jekyll-jsminify'
  spec.version       = '0.3.0'
  spec.authors       = ['Garen J. Torikian']
  spec.email         = ['gjtorikian@gmail.com']
  spec.summary       = %q{A JavaScript and CoffeeScript minifier for Jekyll.}
  spec.homepage      = 'https://github.com/gjtorikian/jekyll-jsminify'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/).grep(%r{(lib/)})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'uglifier', '~> 2.5'

  spec.add_development_dependency 'jekyll', '>= 2.0'
  spec.add_development_dependency 'jekyll-coffeescript', '>= 1.0'
  spec.add_development_dependency 'bundler', '~> 1.5'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
end
