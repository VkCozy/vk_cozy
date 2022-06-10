require_relative 'types/events/user_events'
require_relative 'dispatch/views/user/event'
require_relative 'framework/labeler/user'
require_relative 'polling/user_polling'

module VkCozy
  class User
    attr_reader :api

    def initialize(access_token, version=5.92, api=nil)
      @access_token = access_token
      if api.nil?
        @api = Api.new(access_token, version)
      else
        @api = api
      end
      @polling = VkCozy::UserPolling.new(@api)
      @labeler = VkCozy::UserLabeler.new(@api)
    end

    def on
      return @labeler
    end

    def run_polling
      @polling.listen do |event|
        for update in event['updates']
          begin
            @labeler.filter(update)
          rescue Exception => e 
            raise e
          end
        end
      end
    end
  end
end