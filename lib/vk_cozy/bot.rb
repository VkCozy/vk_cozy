require_relative 'types/events/bot_events'
require_relative 'dispatch/views/bot/event'
require_relative 'framework/labeler/bot'
require_relative 'polling/bot_polling'
require_relative 'dev/keyboard/keyboard'

module VkCozy
  class Bot
    attr_reader :api

    CLASS_BY_EVENT_TYPE = {
      BotEventType::MESSAGE_NEW => BotMessageEvent,
      BotEventType::MESSAGE_REPLY => BotMessageEvent,
      BotEventType::MESSAGE_EDIT => BotMessageEvent
    }

    DEFAULT_EVENT_CLASS = BotEvent

    def initialize(access_token, version=5.92)
      @access_token = access_token
      @api = Api.new(access_token, version)
      
      @polling = VkCozy::BotPolling.new(@api)
      @labeler = VkCozy::BotLabeler.new(@api)
    end

    def on
      return @labeler
    end

    def on_startup
      puts 'Run polling'
    end

    def run_polling(startup=nil)
      if startup.nil?
        on_startup
      elsif startup.is_a?(Proc)
        startup.call
      else
        startup
      end
      @polling.listen do |event|
        for event_raw in event['updates']
          begin
            event_raw = parse_event(event_raw)
            if @labeler.filter(event_raw)
              next
            end
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