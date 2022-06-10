module VkCozy
  class BotLabeler
    attr_reader :api

    def initialize(api)
      @api
      @rules = []
    end

    def filter(event)
      for i in @rules
        f = i[:filter]
        check = f.check_bot(event)
        if check
          if check.is_a?(Hash)
            i[:func].call(event, **check)
          else
            i[:func].call(event)
          end
        end
      end
    end

    def message_handler(filter, func)
      if func.is_a?(Symbol)
        func = method(func)
      end
      @rules << { 
        :func => func,
        :filter => filter
      }
    end
  end
end