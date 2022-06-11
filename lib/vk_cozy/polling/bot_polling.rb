module VkCozy
  class BotPolling
    def initialize(api, group_id=nil, wait=25, rps_delay=0)
      @api = api
      if group_id.nil?
        @group_id = @api.request('groups.getById', {})['response'][0]['id']
      else
        @group_id = group_id
      end

      @rps_delay = rps_delay
      @stop = false
    end

    def get_server
      return @api.request('groups.getLongPollServer', {:group_id => @group_id})['response']
    end

    def get_event(server)
      uri = URI.parse('%s?act=a_check&key=%s&ts=%s&wait=%s&rps_delay=%s' % [server['server'], server['key'], server['ts'], @wait, @rps_delay])
      http_response = Net::HTTP.get(uri)
      return JSON.parse(http_response)
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