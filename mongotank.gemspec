# -*- encoding: utf-8 -*-
require File.expand_path('../lib/mongotank', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Abhishiv Saxena"]
  gem.email         = ["abhishiv@gmail.com"]
  gem.description   = %q{Mongoid and IndexTank sitting in a tree}
  gem.summary   = %q{Mongoid and IndexTank sitting in a tree}
  gem.homepage      = 'http://github.com/abhishiv/mongotank'
  gem.add_dependency('hashie')
  gem.add_dependency('indextank')

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "mongotank"
  gem.require_paths = ['lib']
  gem.version       = MongoTank::VERSION

end
