module VkCozy
  class BotEvent
    attr_reader :api, :raw, :t, :type, :obj, :object, :client_info, :message, :group_id
    def initialize(api, event_raw)
      @api = api
      @raw = event_raw

      @type = event_raw['type']
      @t = @type 

      @object = event_raw['object'].to_dot
      @obj = @object

      @message = @obj['message']

      @client_info = @obj['client_info']

      @group_id = @raw['group_id']
      
    end

    def [] key
      instance_variable_get("@#{key}")
    end

    def to_s
      "BotEvent(#{@raw.to_s})"
    end
  end

  class BotMessageEvent < BotEvent
    attr_reader :from_user, :from_chat, :from_group, :chat_id
    def initialize(api, event_raw)
      super(api, event_raw)
      @from_user = false
      @from_chat = false
      @from_group = false


      peer_id = @raw['object']['peer_id']
      if peer_id.nil?
        peer_id = @raw['object']['message']['peer_id']
      end

      if peer_id < 0
        @from_group = true
      elsif peer_id < 2e9
        @from_user = true
      else
        from_user = true
        @chat_id = peer_id - 2e9
      end
    end

    def answer(text)
      return @api.messages_send(
        peer_id: @message.peer_id,
        message: text,
        random_id: 0
      )
    end

    def to_s
      "BotMessageEvent(#{@raw.to_s})"
    end
  end
end