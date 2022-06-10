require_relative 'types/events/bot_events'
require_relative 'dispatch/views/bot/event'
require_relative 'framework/labeler/bot'
require_relative 'polling/bot_polling'

module VkCozy
	class Bot
		attr_reader :api

		CLASS_BY_EVENT_TYPE = {
			BotEventType::MESSAGE_NEW => BotMessageEvent,
			BotEventType::MESSAGE_REPLY => BotMessageEvent,
			BotEventType::MESSAGE_EDIT => BotMessageEvent
		}

		DEFAULT_EVENT_CLASS = BotEvent

		def initialize(access_token, version=5.92, api=nil)
			@access_token = access_token
			if api.nil?
				@api = Api.new(access_token, version)
			else
				@api = api
			end
			@polling = VkCozy::BotPolling.new(@api)
			@labeler = VkCozy::BotLabeler.new(@api)
		end

		def on
			return @labeler
		end

		def run_polling
			@polling.listen do |event|
				for event_raw in event['updates']
					begin
						@labeler.filter(parse_event(event_raw))
					rescue Exception => e 
						raise e
					end
				end
			end
		end

		private

		def parse_event(event_raw)
			event_class = CLASS_BY_EVENT_TYPE.fetch(
				event_raw['type'],
				DEFAULT_EVENT_CLASS
			)
			return event_class.new(@api, event_raw)
		end
	end
end