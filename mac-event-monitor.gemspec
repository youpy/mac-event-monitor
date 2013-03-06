# -*- encoding: utf-8 -*-
require File.expand_path('../lib/mac-event-monitor/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["youpy"]
  gem.email         = ["youpy@buycheapviagraonlinenow.com"]
  gem.description   = %q{A Library to Monitor User Interactions}
  gem.summary       = %q{A Library to Monitor User Interactions}
  gem.homepage      = ""

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "mac-event-monitor"
  gem.extensions    = ["ext/event_monitor/extconf.rb"]
  gem.require_paths = ["lib"]
  gem.version       = Mac::EventMonitor::VERSION

  gem.add_development_dependency('rspec', ['~> 2.8.0'])
  gem.add_development_dependency('mac-robot')
  gem.add_development_dependency('eventmachine')
  gem.add_development_dependency('rake')
end
