require_relative 'action'
require_relative 'button'
require_relative 'color'

module Keyboard
  class Keyboard
    def initialize(one_time: false, inline: false)
      @one_time = one_time
      @inline = inline
      @buttons = []
    end

    def row()
      @buttons << []
      return self
    end

    def add(action, color=nil)
      if @buttons.length == 0
        row()
      end
      button = KeyboardButton.from_typed(action, color: color)
      @buttons[-1] << button
      return self
    end

    def get_json()
      _buttons = []
      for row in @buttons
        buttons = []
        for button in row
          buttons << button.get_data()
        end
        _buttons << buttons
      end
      data = {
        'one_time' => @one_time,
        'inline' => @inline,
        'buttons' => _buttons
      }
      return data
    end

    def to_s
      return JSON.generate(get_json())
    end
  end
end