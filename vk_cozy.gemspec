require File.expand_path('lib/vk_cozy/version', __dir__)
$LOAD_PATH.push File.expand_path('../lib', __FILE__)

Gem::Specification.new do |s|
  s.name = 'vk_cozy'
  s.version = VkCozy::VERSION
  s.default_executable = "vk_cozy"

  s.authors = ['Danil Konenko']
  s.email = 'googloldanil@gmail.com'
  s.homepage = 'https://github.com/VkCozy/vk_cozy'
  s.summary = 'Vk.com API Client'
  s.description = 'framework for Vk.api'
  s.license = 'MIT'

  s.files = [
    "lib/vk_cozy.rb", "Gemfile", 'lib/vk_cozy/bot.rb', 'lib/vk_cozy/user.rb',
    'lib/vk_cozy/types/events/bot_events.rb', 'lib/vk_cozy/types/events/user_events.rb',
    'lib/vk_cozy/polling/bot_polling.rb', 'lib/vk_cozy/polling/user_polling.rb',
    'lib/vk_cozy/framework/labeler/bot.rb', 'lib/vk_cozy/framework/labeler/user.rb',
    'lib/vk_cozy/framework/labeler/filters/filters.rb', 'lib/vk_cozy/dispatch/views/bot/event.rb',
    'lib/vk_cozy/dispatch/views/user/event.rb', 'lib/vk_cozy/api/api.rb'
  ]
  s.require_paths = ["lib"]

  s.add_development_dependency('inum')
  s.add_development_dependency('ruby-enum')
  s.add_development_dependency('hash_dot')
end