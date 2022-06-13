require 'vk_cozy'
require 'base64'

bot = VkCozy::Bot.new('GroupToken')

bot.on.message_handler(Filter::YaScan.new('/e <text>'), -> (event, options={}) {
  event.answer('Зашифровал ваше сообщение!')
  event.answer(Base64.encode64(options['text']))
})

bot.on.message_handler(Filter::YaScan.new('<text>'), -> (event, options={}) {
  begin
    decode = Base64.decode64(options['text'])
    event.answer('Расшифровал!')
    event.answer(decode)
  rescue
    event.answer('Произошла ошибка, возможо сообщение не зашифровано!')
  end
})

bot.run_polling()