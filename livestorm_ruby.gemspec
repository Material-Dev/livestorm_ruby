Gem::Specification.new do |spec|
  spec.name          = "livestorm_ruby"
  spec.version       = "0.3.0"
  spec.authors       = ["harsh-materialplusio"]
  spec.email         = ["harshwardhan.rathore@materialplus.io"]
  spec.summary       = %q{Livestorm API methods for Rails}
  spec.description   = %q{A gem containing Livestorm API methods for use in Rails applications.}
  spec.homepage      = "https://github.com/Material-Dev/livestorm_ruby"
  spec.license       = "MIT"

  spec.files         = Dir['{lib}/**/*'] + ['README.md', 'LICENSE.md']

  spec.add_dependency 'rest-client'

  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'activesupport'
  spec.add_development_dependency 'shoulda'
  spec.add_development_dependency 'webmock'
  spec.add_development_dependency 'factory_bot_rails'
  spec.add_development_dependency 'byebug'
end
