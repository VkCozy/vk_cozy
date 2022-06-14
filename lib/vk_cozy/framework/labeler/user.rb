module VkCozy

  class UserHandler
    def initialize(filter, func, stop: true)
      @filter = filter
      @func = func
      @stop = stop
    end

    def check(event)
      check_user = @filter.check_user(event)
      if check_user
        if check_user.is_a?(Symbol)
          return true
        elsif check_user.is_a?(Hash)
          @func.call(event, check_user)
        else
          @func.call(event)
        end

        if @stop
          return true
        end
      end
    end
  end

  class UserLabeler
    attr_reader :api

    def initialize(api)
      @api = api
      @handlers = {'*' => []}
    end

    def get_handlers(type)
      if @handlers[type].nil?
        return []
      else
        return @handlers[type]
      end
    end

    def filter(event_raw)
      event = VkCozy::UserEvent.new(@api, event_raw)
      puts event
      for handler in get_handlers(event.type) + get_handlers('*')
        if handler.check(event)
          return true
        end
    	end
    end

    def add_handler(filter, func, type: '*')
      if func.is_a?(Symbol)
        func = method(func)
      end

      if @handlers[type].nil?
        @handlers[type] = []
      end

      @handlers[type] << UserHandler.new(filter, func)
    end

    def message_handler(filter, func)
      add_handler(filter, func, type: VkCozy::UserEventType::MESSAGE_NEW)
    end

    def handler(filter, func)
      add_handler(filter, func)
    end
	end
end