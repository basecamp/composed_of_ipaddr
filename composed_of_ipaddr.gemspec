Gem::Specification.new do |s|
  s.name      = 'composed_of_ipaddr'
  s.version   = '1.0.1'
  s.author    = 'Basecamp'
  s.email     = 'support@basecamp.com'
  s.homepage  = 'https://github.com/basecamp/composed_of_ipaddr'
  s.summary   = 'Compose an IPAddr from an underlying 4-byte integer'
  s.license   = 'MIT'

  s.required_ruby_version = '>= 1.8.7'

  s.add_runtime_dependency 'activerecord', '>= 2.3'
  s.add_runtime_dependency 'concerning', '~> 1.1'

  s.add_development_dependency 'rake', '~> 10.1'
  s.add_development_dependency 'minitest', '~> 5.1'
  s.add_development_dependency 'sqlite3', '~> 1.3'

  root = File.dirname(__FILE__)
  s.files += Dir["#{root}/lib/**/*"]
  s.test_files = Dir["#{root}/test/**/*"]
end
