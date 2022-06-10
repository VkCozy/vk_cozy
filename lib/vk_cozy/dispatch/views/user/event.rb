module VkCozy
	class UserEvent
		attr_accessor :api, :raw, :type,
					:from_user, :from_chat, :from_group, :from_me, :to_me, 
					:attachments, :message_data,
					:message_id, :timestamp, :text, :peer_id, :flags, :extra, :extra_values, :type_id

		def initialize(api, raw_event)
			@api = api
			@raw = raw_event

			@from_user = false
			@from_chat = false
			@from_group = false
			@from_me = false
			@to_me = false

			begin
				@type = UserEventType.parse(@raw[0])
				list_to_attr(@raw[1, @raw.length], EVENT_ATTRS_MAPPING[@type])
			rescue StandardError => e
				@type = @raw[0]
			end

			if VkCozy::PARSE_PEER_ID_EVENTS.include?(@type)
				parse_peer_id()
			end

			if VkCozy::PARSE_MESSAGE_FLAGS_EVENTS
				parse_message()
			end
		end

		def to_s
			instance_variables.each_with_object({}) do |k, h|
				h[k] = instance_variable_get("#{k}")
			end.to_json
		end

		def answer(text)
			return @api.messages_send(
				peer_id: @peer_id,
				message: text,
				random_id: 0
			)
		end

		private

		def list_to_attr(raw, attrs)
			for i in (0..[raw.length, attrs.length].min)
				instance_variable_set("@#{attrs[i]}", raw[i]) if respond_to? "#{attrs[i]}="
			end
		end

		def parse_peer_id
			if @peer_id < 0
				@from_group = true
				@group_id = peer_id

			elsif @peer_id > 2e9
				@from_chat = true 
				@chat_id = @peer_id-2e9

				if @extra_values and @extra_values.include?('from')
					@user_id = @extra_values['from'].to_i
				end
			else
				@from_user = true 
				@user_id = @peer_id
			end
		end

		def parse_message
			if @type == UserEventType::MESSAGE_NEW

			end
		end
	end
end