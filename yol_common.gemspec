# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'yol_common/version'

Gem::Specification.new do |spec|
  spec.name          = "yol_common"
  spec.version       = YolCommon::VERSION
  spec.authors       = ["luojie2019"]
  spec.email         = ["luojie@yolanda.hk@yeezon.com"]
  spec.summary       = %q{common helpers}
  spec.description   = %q{private gem}
  spec.homepage      = "https://github.com/luojie2019/yol_common"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"

  spec.add_dependency 'oj'
end
