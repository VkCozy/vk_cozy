module Keyboard
  class Color
    include Ruby::Enum

		define :PRIMARY, 'primary'
    define :SECONDARY, 'secondary'
    define :NEGATIVE, 'negative'
    define :POSITIVE, 'positive'
  end
end