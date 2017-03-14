# -*- encoding: utf-8 -*-
$LOAD_PATH.push File.expand_path('../lib', __FILE__)

require 'pronto/labelman/version'

Gem::Specification.new do |s|
  s.name = 'pronto-labelman'
  s.version = Pronto::LabelmanVersion::VERSION
  s.platform = Gem::Platform::RUBY
  s.author = 'Amiel Perez'
  s.email = 'perezamiel@yahoo.com'
  s.homepage = 'http://github.org/amielperez/pronto-labelman'
  s.summary = 'Pronto runner for that labels PRs automatically based on rules'

  s.required_rubygems_version = '>= 1.3.6'
  s.license = 'MIT'

  s.files = Dir.glob('{lib}/**/*') + %w(LICENSE README.md)
  s.test_files = `git ls-files -- {spec}/*`.split("\n")
  s.require_paths = ['lib']

  s.add_dependency 'pronto', '~> 0.6'
  s.add_development_dependency 'rake', '~> 10.3'
  s.add_development_dependency 'rspec', '~> 3.0'
  s.add_development_dependency 'rspec-its', '~> 1.0'
end
