# VkCozy
framework for Vk Api
## Install
``` sh
gem install vk_cozy
```

## Hello World
``` ruby
bot = VkCozy::Bot.new('token_api') # Initialize Session for group bot

bot.on.message_handler(VkCozy::Text.new('/test'), -> (event) {
  event.answer('Im run!')
})

bot.run_polling() # Polling start
```
## Multibot
``` ruby
$bots = [
  VkCozy::Bot.new('token_api'),
  VkCozy::Bot.new('token_api')
]

def run(bot) # Function for start bot
  bot.on.message_handler(VkCozy::Text.new('/test'), -> (event) {
    event.answer('Im run!')
  })
  
  bot.run_polling() # Polling start
end

threads = []
$bots.each do |bot|
  threads << Thread.new do
    run(bot)
  end
end

threads.each(&:join) # Run thread
```
