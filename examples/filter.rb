require 'vk_cozy'

bot = VkCozy::Bot.new('GroupToken')

class LengthFilter < Filter::BaseFilter # Создадим фильтр, проверяющий длину сообщения.
  def initialize(length_msg)
    @length_msg = length_msg
  end

  def check_bot(event) # Функция для проверки, если ботом является группа.
    return event.message.text.length < @length_msg
  end

  def check_user(event) # Функция для проверки, если ботом является пользователь.
    return event.text.length < @length_msg
  end
end

bot.on.message_handler(Filter::YaScan.new('my name is <name>'), -> (event, options={}) {
  event.answer("Ваше имя: #{options['name']}!")
})

bot.on.message_handler(LengthFilter.new(10), -> (event) {
  event.answer('Ваше сообщение короче 10!')
})

bot.on.message_handler(Filter::YaScan.new('<text>'), -> (event, options={}) {
  event.answer("Вы написали: #{options['text']}!")
})

bot.run_polling()