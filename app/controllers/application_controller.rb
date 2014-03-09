class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  skip_before_filter :verify_authenticity_token
  before_filter :check_signature

  # Check the signature to confirm this GET request is from the weixin server
  def check_signature
  	# Sort according to dictionary
  	token = Rails.configuration.token
  	timestamp = params[:timestamp]
  	nonce = params[:nonce]
	tmpStr = [ token, timestamp, nonce ].sort.join
  	signature = params[:signature]
    	render :text => "Forbidden", :status => 403 unless signature == Digest::SHA1.hexdigest(tmpStr)	
    	end
  end

end
