Gem::Specification.new do |s|
  s.name        = 'usps_intelligent_barcode'
  s.version     = File.read('VERSION').strip
  s.summary     = 'Generates a USPS Intelligent Mail Barcode.'
  s.description = 'A pure Ruby library to generate a USPS Intelligent Mail barcode. It generates the string of characters to print with one of the USPS Intelligent Mail barcode fonts.'
  s.authors     = ['Wayne Conrad']
  s.email       = 'kf7qga@gmail.com'
  s.homepage    = 'https://github.com/wconrad/usps_intelligent_barcode'
  s.license     = 'MIT'
  s.required_ruby_version = '>= 3.2.0'
  s.files       = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  s.require_paths = ['lib']
  s.add_runtime_dependency 'andand', '~> 1.3'
  s.add_runtime_dependency 'memoizer', '~> 1.0'
  s.add_development_dependency 'prawn', '~> 2.5'
  s.add_development_dependency 'rake', '~> 13.0'
  s.add_development_dependency 'rspec', '~> 3.12'
  s.add_development_dependency 'rspec-its', '~> 2.0'
  s.add_development_dependency 'simplecov', '~> 0.22'
  s.add_development_dependency 'yard', '~> 0.9'
  s.metadata = {
    'source_code_uri' => 'https://github.com/wconrad/usps_intelligent_barcode',
    'bug_tracker_uri' => 'https://github.com/wconrad/usps_intelligent_barcode/issues'
  }
end
