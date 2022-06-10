module VkCozy
	class BaseFilter
		def check_user(event) # Method check for user-bot
			raise 'Method check_user not implemented'
		end

		def check_bot(event) # Method check for group-bot
			raise 'Method check_bot not implemented'
		end
	end

	class Text < BaseFilter
		def initialize(regex, **kwargs)
			@regex = regex
			@raw = kwargs
		end

		def check_user(event)
			if event.type == VkCozy::UserEventType::MESSAGE_NEW

				if event.from_me
					return false
				end
				if event.text == @regex
					return true
				else
					return false
				end
			else
				return false
			end
		end

		def check_bot(event)
			if event.type == VkCozy::BotEventType::MESSAGE_NEW
				if event.message.text == @regex
					return true
				else
					return false
				end
			else
				return false
			end
		end
	end
end