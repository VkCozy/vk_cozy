require 'vk_cozy'

bot = VkCozy::Bot.new('GroupToken')

bot.on.message_handler(Filter::YaScan.new('клавиатура'), -> (event, options={}) {
  key = Keyboard::Keyboard.new(inline: true, one_time: false)
  key.add(Keyboard::Callback.new('1', '{"num": 1}'), Keyboard::Color::POSITIVE).
      add(Keyboard::Callback.new('2', '{"num": 2}'), Keyboard::Color::POSITIVE).
      add(Keyboard::Callback.new('3', '{"num": 3}'), Keyboard::Color::POSITIVE)

  event.api.messages_send(
    peer_id: event.message.peer_id,
    message: 'Нажми на кнопку, а я скажу тебе, что было на кнопке!',
    random_id: 0,
    keyboard: key
  )
})

# MockedFilter - является фильтром-заглушкой
bot.on.event_handler(Filter::MockedFilter.new, -> (event) {
  event.answer("Число: #{event.obj.payload.num}")
})

bot.run_polling()