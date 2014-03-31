#encoding: utf-8
require 'rest-client'

module Weixin

	class OAuth

		attr_accessor :appid, :secret, :endpoint

		def initialize(appid, secret)
			@appid = appid
			@secret = secret

			@endpoint = 'https://api.weixin.qq.com/sns/oauth2'
		end

		def exchange_token(code)
			url = '#{@endpoint}/access_token'
			reponse = RestClient.get url, { :params => { :appid => @appid, :secret => @secret, :code => code, :grant_type => 'authorization_code' } }
			json = JSON.parse(reponse)
		end

	end

end
