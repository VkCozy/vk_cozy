require 'vk_cozy'

bot = VkCozy::Bot.new('GroupToken')

bot.on.message_handler(VkCozy::YaScan.new('клавиатура'), -> (event, options={}) {
  key = Keyboard::Keyboard.new(inline: true, one_time: false)
  key.add(Keyboard::Text.new('кнопка'), Keyboard::Color::PRIMARY).
      add(Keyboard::Text.new('кнопка'), Keyboard::Color::SECONDARY).row.
      add(Keyboard::Text.new('кнопка'), Keyboard::Color::NEGATIVE).
      add(Keyboard::Text.new('кнопка'), Keyboard::Color::POSITIVE)

  event.api.messages_send(
    peer_id: event.message.peer_id,
    message: 'Держи цветную клавиатуру!',
    random_id: 0,
    keyboard: key
  )
})

bot.run_polling()