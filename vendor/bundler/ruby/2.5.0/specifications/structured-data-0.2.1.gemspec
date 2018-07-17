# -*- encoding: utf-8 -*-
# stub: structured-data 0.2.1 ruby lib

Gem::Specification.new do |s|
  s.name = "structured-data".freeze
  s.version = "0.2.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["AKAMATSU Yuki".freeze]
  s.bindir = "exe".freeze
  s.date = "2017-04-27"
  s.description = "Generate JSON+LD for Google Structured Data".freeze
  s.email = ["y.akamatsu@ukstudio.jp".freeze]
  s.homepage = "https://github.com/ukstudio/structured-data".freeze
  s.rubygems_version = "2.7.7".freeze
  s.summary = "A generator of structured data for SEO".freeze

  s.installed_by_version = "2.7.7" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<actionpack>.freeze, [">= 0"])
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.13"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 10.0"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 3.0"])
    else
      s.add_dependency(%q<actionpack>.freeze, [">= 0"])
      s.add_dependency(%q<bundler>.freeze, ["~> 1.13"])
      s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
      s.add_dependency(%q<rspec>.freeze, ["~> 3.0"])
    end
  else
    s.add_dependency(%q<actionpack>.freeze, [">= 0"])
    s.add_dependency(%q<bundler>.freeze, ["~> 1.13"])
    s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.0"])
  end
end
