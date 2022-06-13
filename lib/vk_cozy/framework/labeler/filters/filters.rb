module Filter
  class BaseFilter
    def check_user(event) # Method check for user-bot
      raise 'Method check_user not implemented'
    end

    def check_bot(event) # Method check for group-bot
      raise 'Method check_bot not implemented'
    end
  end

  class MockedFilter < BaseFilter
    def check_bot(event)
      return true
    end

    def user_bot(event)
      return true
    end
  end

  class YaScan < BaseFilter
    def initialize(pattern, flags: Regexp::IGNORECASE)
      @flags = flags
      @pattern = valid_pattern(pattern) # Pattern example: my name is <name> 
    end

    def valid_pattern(pattern)
      arguments = pattern.scan(/<([\w_]*)>/).flatten
      for i in arguments
        pattern = pattern.sub("<#{i}>", "(?<#{i}>.*)")
      end
      return Regexp.new(pattern, @flags)
    end

    def check_text(text) # Text example: my name is Volk
      text_match = @pattern.match(text)
      if text_match.nil?
        return false
      end
      return Hash[ text_match.names.zip( text_match.captures ) ] # Return: {'name' => 'Volk'}
    end

    def check_bot(event)
      check_text(event.message.text)
    end

    def check_user(event)
      if event.from_me
        return false
      end
      check_text(event.text)
    end
  end

  class Text < BaseFilter
    def initialize(regex)
      @regex = regex
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