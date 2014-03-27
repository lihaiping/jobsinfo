class Mobile::InformationController < Mobile::ApplicationController

	layout 'weixin'

	def index
		render :text => params[:echostr]
	end

	def create
		@fromUserName = params[:xml][:FromUserName]
		@toUserName = params[:xml][:ToUserName]
		@msgType = "text"
		@content = params[:xml][:Content]
		if params[:xml][:MsgType] == "text"
			render "echo", :formats => :xml
		end
	end
	
end
