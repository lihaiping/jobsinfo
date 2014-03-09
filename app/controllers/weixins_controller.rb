class WeixinsController < ApplicationController
	# skip_before_filter :verify_authenticity_token
	# before_filter :check_weixin_legality
	
	def index
		render :text => params[:echostr]
	end

	def create
		if params[:xml][:MsgType] == "text"
      			render "echo", :formats => :xml
    		end
	end


end
