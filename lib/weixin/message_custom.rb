# -*- encoding : utf-8 -*-
# Base on the rack-weixin on https://github.com/wolfg1969/rack-weixin

require 'multi_json'
require 'rest-client'

module Weixin

  class MessageCustom < Api

    def gw_path(method)
      "/message/custom/#{method}?access_token=#{access_token}"
    end

    def gw_url(method)
      "#{endpoint}" + gw_path(method)
    end

    def send(message)
      response = RestClient.post gw_url('send'), MultiJson.dump(message) rescue nil
      check_response(response)
    end

  end

end
