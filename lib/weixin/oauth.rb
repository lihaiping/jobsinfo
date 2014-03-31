#encoding: utf-8
require 'rest-client'
require 'multi_json'

module Weixin

	class OAuth

		def initialize(appid, secret)
			@appid = appid
			@secret = secret

			@endpoint = 'https://api.weixin.qq.com/sns/oauth2'
		end

		def exchange_token(code)
			url = "#{@endpoint}/access_token"
			request = RestClient.get url, { :params => { :appid => @appid, :secret => @secret, :code => code, :grant_type => 'authorization_code' } }
			MultiJson.load(request.body)
		end

	end

end
