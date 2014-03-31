require 'weixin/oauth'

class Mobile::SubscriptionsController < Mobile::ApplicationController

	STATE = 'jobsinfo123'

	def setting
		# For test
		@user = User.first
		@jobs = @user.jobs

		# if STATE == params[:state]
		# 	if params[:code].present?
		# 		oauth = Weixin::OAuth.new(@config.app_id, @config.app_secret)
		# 		json = oauth.exchange_token(params[:code])

		# 		@user = User.find_by(openid: json["openid"])
		# 		@jobs = @user.jobs
		# 	else
		# 		redirect_to mobile_unauthorize_path
		# 	end
		# else
		# 	url = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=#{@config.app_id}&redirect_uri=#{request.original_url}&response_type=code&scope=snsapi_base&state=#{STATE}#wechat_redirect"
  #       		redirect_to url
		# end
	end

	def set
		
	end

	def unauthorize
		render text: "未授权, 无法完成订阅."
	end

end
