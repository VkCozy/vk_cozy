require 'vk_cozy'

bot = VkCozy::Bot.new('GroupToken')

bot.on.message_handler(Filter::YaScan.new('клавиатура'), -> (event, options={}) {
  key = Keyboard::Keyboard.new(inline: true, one_time: false)
  key.add(Keyboard::Callback.new('Callback кнопка', '{}'), Keyboard::Color::POSITIVE).
      add(Keyboard::OpenLink.new('Нажми меня!', 'https://rubygems.org/gems/vk_cozy')).row.
      add(Keyboard::Text.new('Тестовая кнопка'))

  event.api.messages_send(
    peer_id: event.message.peer_id,
    message: 'Держи клавиатуру с разными кнопками',
    random_id: 0,
    keyboard: key
  )
})

bot.run_polling()