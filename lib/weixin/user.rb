# -*- encoding : utf-8 -*-
# Base on the rack-weixin on https://github.com/wolfg1969/rack-weixin

require 'multi_json'
require 'rest-client'

module Weixin

  class User < Api

    def gw_path(method)
      "/user/#{method}?access_token=#{access_token}"
    end

    def info(openid, lang = nil)
      url = "#{gw_url('info')}&openid=#{openid}"
      url = "#{url}&lang=#{lang}" if lang.present?

      request = RestClient.get url rescue nil
      MultiJson.load(request.body) unless request.nil?
    end

  end

end
