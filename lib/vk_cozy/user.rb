require_relative 'types/events/user_events'
require_relative 'dispatch/views/user/event'
require_relative 'framework/labeler/user'
require_relative 'polling/user_polling'

module VkCozy
  class User
    attr_reader :api

    def initialize(access_token, version=5.92)
      @access_token = access_token
      @api = Api.new(access_token, version)
      
      @polling = VkCozy::UserPolling.new(@api)
      @labeler = VkCozy::UserLabeler.new(@api)
    end

    def on
      return @labeler
    end

    def on_startup
      puts 'Run polling'
    end

    def run_polling(startup=nil)
      if startup.nil?
        on_startup
      elsif startup.is_a?(Proc)
        startup.call
      else
        startup
      end

      @polling.listen do |event|
        for update in event['updates']
          begin
            if @labeler.filter(update)
              next
            end
          rescue Exception => e 
            raise e
          end
        end
      end
    end
  end
end