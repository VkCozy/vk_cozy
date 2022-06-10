module VkCozy
	class UserPolling
		def initialize(api=nil, user_id=nil, mode=234, wait=25, rps_delay=0, error_handler=nil)
			@api = api
			if user_id.nil?
				@user_id = @api.request('users.get', {})['response'][0]['id']
			else
				@user_id = user_id
			end
			@mode = mode 
			@wait = wait
			@rps_delay = rps_delay
			@stop = false
		end

		def get_event(server)
			uri = URI.parse('https://%s?act=a_check&key=%s&ts=%s&wait=%s&mode=%s&rps_delay=%s&version=%s' % [server['server'], server['key'], server['ts'], @wait, @mode, @rps_delay, 3])
			http_response = Net::HTTP.get(uri)
			return JSON.parse(http_response)
		end

		def get_server
			return @api.request('messages.getLongPollServer', {})['response']
		end

		def listen
			server = get_server
			until @stop do
				event = get_event(server)
				if not event['ts']
					server = get_server
					next
				end
				server['ts'] = event['ts']
				yield event
			end
		end
	end
end