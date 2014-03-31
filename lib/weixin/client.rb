# -*- encoding : utf-8 -*-
# Base on the rack-weixin on https://github.com/wolfg1969/rack-weixin

require 'multi_json'
require 'rest-client'

module Weixin
 
  class Client

    attr_accessor :api, :key, :access_token, :expired_at, :endpoint

    def initialize(api, key, access_token = nil, expired_at = nil)
      @api = api
      @key = key
      
      @access_token = access_token
      @expired_at   = (expired_at || Time.now)
      @endpoint     = 'https://api.weixin.qq.com/cgi-bin'
    end  	

    def get_access_token
      if expired?
        authenticate
      end
      @access_token
    end    

    def expired?
   	  Time.now >= @expired_at
    end

    def expired_at
      @expired_at
    end

    def self.authenticate(endpoint, api, key)
      url = "#{endpoint}/token"
      request = RestClient.get url, { :params => { :grant_type => 'client_credential', :appid => api, :secret => key } } rescue nil
      unless request.nil?
        auth = MultiJson.load(request.body)
        unless auth.has_key?('errcode')
          access_token = auth['access_token']
          expired_at   = Time.now + auth['expires_in'].to_i
        end

      end

      return access_token, expired_at
    end

    def authenticate
      @access_token, @expired_at = self.class.authenticate(@endpoint, @api, @key)
    end   

    def user
      WeixinUser.new(@api, @key, get_access_token, @expired_at, @endpoint)
    end 

    def menu
      Menu.new(@api, @key)
    end     

    def message_custom
      MessageCustom.new(@api, @key, get_access_token, @expired_at, @endpoint)
    end      
  end
end