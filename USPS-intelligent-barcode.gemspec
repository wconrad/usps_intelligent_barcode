# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "USPS-intelligent-barcode"
  s.version = "0.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Wayne Conrad"]
  s.date = "2012-12-27"
  s.description = "A pure Ruby gem to generate a USPS Intelligent Mail barcode.  It generates the string of characters to print with one of the USPS Intelligent Mail barcode fonts."
  s.email = "wayne@databill.com"
  s.extra_rdoc_files = [
    "LICENSE.md",
    "README.rdoc"
  ]
  s.files = [
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.md",
    "README.rdoc",
    "Rakefile",
    "USPS-intelligent-barcode.gemspec",
    "VERSION",
    "examples/example.rb",
    "lib/USPS-intelligent-barcode.rb",
    "lib/USPS-intelligent-barcode/BarMap.rb",
    "lib/USPS-intelligent-barcode/BarPosition.rb",
    "lib/USPS-intelligent-barcode/Barcode.rb",
    "lib/USPS-intelligent-barcode/BarcodeId.rb",
    "lib/USPS-intelligent-barcode/CharacterPosition.rb",
    "lib/USPS-intelligent-barcode/CodewordMap.rb",
    "lib/USPS-intelligent-barcode/Crc.rb",
    "lib/USPS-intelligent-barcode/MailerId.rb",
    "lib/USPS-intelligent-barcode/NumericConversions.rb",
    "lib/USPS-intelligent-barcode/RoutingCode.rb",
    "lib/USPS-intelligent-barcode/SerialNumber.rb",
    "lib/USPS-intelligent-barcode/ServiceType.rb",
    "lib/USPS-intelligent-barcode/autoload.rb",
    "lib/USPS-intelligent-barcode/bar_to_character_mapping.yml",
    "lib/USPS-intelligent-barcode/codeword_to_character_mapping.yml",
    "spec/BarMap_spec.rb",
    "spec/BarPosition_spec.rb",
    "spec/BarcodeId_spec.rb",
    "spec/Barcode_spec.rb",
    "spec/CharacterPosition_spec.rb",
    "spec/CodewordMap_spec.rb",
    "spec/Crc_spec.rb",
    "spec/MailerId_spec.rb",
    "spec/NumericConversions_spec.rb",
    "spec/RoutingCode_spec.rb",
    "spec/SerialNumber_spec.rb",
    "spec/ServiceType_spec.rb",
    "spec/spec_helper.rb"
  ]
  s.homepage = "http://github.com/wconrad/USPS-intelligent-barcode"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.17"
  s.summary = "Generates a USPS Intelligent Mail Barcode."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<andand>, ["~> 1.3"])
      s.add_runtime_dependency(%q<memoizer>, ["~> 1.0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.12"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.8"])
    else
      s.add_dependency(%q<andand>, ["~> 1.3"])
      s.add_dependency(%q<memoizer>, ["~> 1.0"])
      s.add_dependency(%q<rspec>, ["~> 2.12"])
      s.add_dependency(%q<jeweler>, ["~> 1.8"])
    end
  else
    s.add_dependency(%q<andand>, ["~> 1.3"])
    s.add_dependency(%q<memoizer>, ["~> 1.0"])
    s.add_dependency(%q<rspec>, ["~> 2.12"])
    s.add_dependency(%q<jeweler>, ["~> 1.8"])
  end
end

