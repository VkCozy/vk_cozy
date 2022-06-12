module Keyboard
  class BaseAction
    attr_reader :type
    
    def get_data
      instance_variables.each_with_object({}) do |k, h|
        var = instance_variable_get("#{k}")
        if not var.nil?
          h[k.to_s.gsub('@', '')] = var
        end
      end
    end
  end

  class Text < BaseAction
    def initialize(label, payload: nil)
      @type = 'text'

      @label = label
      @payload = payload
    end
  end

  class OpenLink < BaseAction
    def initialize(label, link, payload: nil)
      @type = 'open_link'

      @label = label
      @link = link
      @payload = payload
    end
  end

  class Location < BaseAction
    def initialize(payload: nil)
      @type = 'location'

      @payload = payload
    end
  end

  class VkPay < BaseAction
    def initialize(payload: nil, hash: nil)
      @type = 'vkpay'

      @payload = payload
      @hash = hash
    end
  end

  class VkApps < BaseAction
    def initialize(app_id, owner_id, payload: nil, label: nil, hash: nil)
      @type = 'open_app'

      @app_id = app_id
      @owner_id = owner_id
      @payload = payload
      @label = label
      @hash = hash
    end
  end


  class Callback < BaseAction
    def initialize(label, payload)
      @type = 'callback'

      @label = label
      @payload = payload
    end
  end
end