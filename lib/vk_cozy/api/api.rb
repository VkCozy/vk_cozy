require 'json'
require 'uri'
require 'net/http'
require "resolv-replace"

class Api
  attr_accessor :access_token, :version

  SCHEME = 'https'
  HOST = 'api.vk.com'
  PATH = '/method/'
  PORT = 443

  def initialize(access_token, version=5.92)
    @access_token = access_token
    @version = version
  end

  def request_thr(method_vk, data)
    thr = Thread.new {
      request(method_vk, data)
    }
    thr.run
  end

  def request(method_vk, data)
    data = data.to_hash
    data = data.merge(v: version)
    data = data.merge(access_token: access_token)
    data.each do |argument, value|
      data[argument] = value.join(',') if value.is_a?(Array)
    end
    http_response = Net::HTTP.post_form(url_for_method(method_vk), data).body
    # return unless http_response.present?
    json_response = JSON.parse(http_response)
    if json_response['error']
      raise json_response['error']['error_msg']
    end
    json_response
  end

  def url_for_method(method_vk)
    URI.parse("#{SCHEME}://#{HOST}#{PATH}#{method_vk}")
  end

  def method_missing name, **kwargs
    return request(name.to_s.sub('_', '.'), kwargs)['response']
  end
end