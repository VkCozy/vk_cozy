module Keyboard
  class KeyboardButton
    def initialize(action, color: nil, data: nil)
      @action = action
      @color = color
      @data = data
    end

    def self.from_typed(action, color: nil)
      return self.new(action, color: color, data: nil)
    end

    def self.from_hash(data)
      color = data.key('color')
      keyboard_data = {'action' => data}
      if color.nil?
        keyboard_data['action'].delete('color')
        keyboard_data['color'] = color
      end
      return self.new(self.action, self.color, keyboard_data)
    end

    def get_data
      if not @data.nil?
        return @data
      end
      data = {'action' => @action.get_data()}
      if ['text', 'callback'].include?(@action.type) and not @color.nil?
        data['color'] = @color
      end
      return data
    end
  end
end