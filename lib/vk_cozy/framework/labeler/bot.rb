module VkCozy

  class Bothandler
    attr_reader :stop

    def initialize(filter, func, stop: true)
      @stop = stop
      @filter = filter
      @func = func
    end

    def check(event)
      check_bot = @filter.check_bot(event)
      if check_bot
        if check_bot.is_a?(Symbol)
          return true
        elsif check_bot.is_a?(Hash)
          @func.call(event, check_bot)
        else
          @func.call(event)
        end
        if @stop
          return true
        end
      end
    end
  end


  class BotLabeler
    attr_reader :api

    def initialize(api)
      @api = api
      @handlers = {'*' => []} # * - обрабатывает события в не зависимости от их типа.
    end

    def get_handlers(type)
      if @handlers[type].nil?
        return []
      else
        return @handlers[type]
      end
    end

    def filter(event)
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

      @handlers[type] << Bothandler.new(filter, func)
    end

    def event_handler(filter, func)
      add_handler(filter, func, type: 'message_event')
    end

    def message_handler(filter, func)
      add_handler(filter, func, type: 'message_new')
    end

    def handler(filter, func)
      add_handler(filter, func)
    end
  end
end