require File.expand_path('lib/vk_cozy/version', __dir__)
$LOAD_PATH.push File.expand_path('../lib', __FILE__)

Gem::Specification.new do |s|
	s.name = 'vk_cozy'
	s.version = VkCozy::VERSION
	s.default_executable = "vk_cozy"

	s.authors = ['Danil Konenko']
	s.email = 'googloldanil@gmail.com'
	s.homepage = 'https://rubygems.org/gems/hola'
	s.summary = 'Vk.com API Client'
	s.description = 'framework for Vk.api'
	s.license = 'MIT'

	s.files = ["lib/vk_cozy.rb", "Gemfile"]
	s.require_paths = ["lib"]

	s.add_development_dependency('inum')
	s.add_development_dependency('ruby-enum')
	s.add_development_dependency('hash_dot')
end