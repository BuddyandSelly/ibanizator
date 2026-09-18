# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name = 'ibanizator'
  s.version = '0.4.15'
  s.licenses = ['MIT']

  s.summary = <<-SUMMARY
    An IBAN generator/validator and BIC generator for german accounts.
  SUMMARY
  s.description = <<-DESCRIPTION
    ibanizator generates the correct IBAN for given account number and bank number
    for german accounts. It is possible to validate given international IBANS.
    Calculates also the BIC and bank names for given german bank codes.
  DESCRIPTION

  s.homepage = 'https://github.com/softwareinmotion/ibanizator'

  s.authors = ['Julien Gantner', 'David Seeherr']
  s.email = 'julien.gantner@softwareinmotion.de'

  s.files = Dir.glob('lib/**/*') + %w[license.md README.md db/blz.txt]

  s.required_ruby_version = '>= 3.2'

  s.add_dependency 'adamantium', '>= 0.2'
  # equalizer 1.0.0 does not work with adamantium, see the README
  s.add_dependency 'equalizer', '~> 0.0.11'

  s.add_development_dependency 'bundler', '>= 2.4'
  s.add_development_dependency 'rake', '~> 13.0'
  s.add_development_dependency 'rspec', '~> 3.13'
  s.add_development_dependency 'rubocop', '~> 1.90'
  s.add_development_dependency 'simplecov', '~> 1.1'
  s.metadata['rubygems_mfa_required'] = 'true'
end
