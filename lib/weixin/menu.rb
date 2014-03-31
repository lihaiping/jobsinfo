# -*- encoding : utf-8 -*-
# Base on the rack-weixin on https://github.com/wolfg1969/rack-weixin

require 'multi_json'
require 'rest-client'

module Weixin

  class Menu
    def initialize(api, key)
      @api = api
      @key = key

      @access_token = nil
      @expired_at   = Time.now
      @endpoint     = 'https://api.weixin.qq.com/cgi-bin'
    end

    def access_token
      if Time.now >= @expired_at
        authenticate
      end
      @access_token
    end

    def gw_path(method)
      "/menu/#{method}?access_token=#{access_token}"
    end

    def gw_url(method)
      "#{@endpoint}" + gw_path(method)
    end

    def get
      request = RestClient.get gw_url('get') rescue nil
      MultiJson.load(request.body) unless request.nil?
    end

    def add(menu)
      request = RestClient.post gw_url('create'), MultiJson.dump(menu) #rescue nil
      unless request.nil?
        errcode = MultiJson.load(request.body)['errcode']
        return true if errcode == 0
      end
      false
    end

    def delete
      request = RestClient.get gw_url('delete') #rescue nil
      unless request.nil?
        errcode = MultiJson.load(request.body)['errcode']
        return true if errcode == 0
      end
      false
    end

    def authenticate
      url = "#{@endpoint}/token"
      request = RestClient.get url, { :params => { :grant_type => 'client_credential', :appid => @api, :secret => @key } } rescue nil
      unless request.nil?
        auth = MultiJson.load(request.body)
        unless auth.has_key?('errcode')
          @access_token = auth['access_token']
          @expired_at   = Time.now + auth['expires_in'].to_i
        end
        @access_token
      end
    end
  end

end
