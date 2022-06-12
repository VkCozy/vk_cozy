# VkCozy
vk_cozy является фреймворком для vk api, имеет удобные хэндлеры и фильтры, создан чтобы упростить разработку ботов для вк
## Install
``` sh
gem install vk_cozy
```

## Hello World
Больше примеров смотреть [тут](https://github.com/VkCozy/vk_cozy/tree/main/examples)!
``` ruby
bot = VkCozy::Bot.new('GroupToken') # Initialize Session for group bot

bot.on.message_handler(VkCozy::Text.new('hello'), -> (event) {
  event.answer('Hello World!')
})

bot.run_polling() # Polling start
```
## Multibot
``` ruby
$bots = [
  VkCozy::Bot.new('GroupToken'),
  VkCozy::Bot.new('GroupToken')
]

def run(bot) # Function for start multibot
  bot.on.message_handler(VkCozy::Text.new('hello'), -> (event) {
    event.answer('Hello World!')
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
## Use methods vk
``` ruby
bot = VkCozy::Bot.new('GroupToken')

bot.on.message_handler(VkCozy::Text.new('/test'), -> (event) {
  event.api.messages_send(
    peer_id: event.message.peer_id,
    message: 'use methods vk',
    random_id: 0
  )
  
  puts event.api.request('groups.getById', {}) # Return: hash
  puts event.api.request_thr('groups.getById', {}) # Request in thread, return: Thread class
})

bot.run_polling()
```
## Contributing
Задавайте вопросы в блоке Issues и в [чате VK](https://vk.me/join/AJQ1d6_YniGeFT3wVBroUuBr)

## Лицензия

Copyright © 2021-2022 [DanilProgram](https://github.com/danil-cpu)

Данный проект имеет [MIT](https://github.com/VkCozy/vk_cozy/blob/main/LICENSE) лицензию.
