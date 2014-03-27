require 'grape'
require 'active_support'
require 'json'

module Weixin
	class Api < Grape::API
		format :txt

		@@cdata = '<![CDATA[TXT]]>'

		helpers do

			def authenticate!(token, timestamp, nonce, signature)
				hasNil = token.nil? || timestamp.nil? || nonce.nil? || signature.nil?
				error!('Unauthorized', 401) if hasNil
				tmpStr = [token, timestamp, nonce].sort.join
				error!('Unauthorized', 401) unless	signature == Digest::SHA1.hexdigest(tmpStr)	
			end

			def reply_base
				{
					:ToUserName => @@cdata.gsub('TXT', params[:xml][:ToUserName]),
					:FromUserName => @@cdata.gsub('TXT', params[:xml][:FromUserName]),
					:CreateTime => Time.now.to_i
				}
			end

			def reply_text(content)
				{
					:MsgType => @@cdata.gsub('TXT', 'text'),
					:Content => @@cdata.gsub('TXT', content)
				}
			end

			def routers
				{
					:click_subscribe => 'subscribe',
          				:click_unsubscribe => 'unsubscribe',

					:reply_? => 'help',
					:click_help => 'help',

					:reply_1 => 'internship_recruit',
					:click_internship_recruit => 'internship_recruit',

					:reply_2 => 'campus_recruit',
					:click_campus_recruit => 'campus_recruit',

					:reply_3 => 'social_recruit',
					:click_social_recruit => 'social_recruit',

					:reply_4 => 'audition_guide',
					:click_audition_guide => 'audition_guide',

					:reply_5 => 'resume_guide',
					:click_resume_guide => 'resume_guide',

					:reply_6 => 'jobs_subscription',
					:click_jobs_subscription => 'jobs_subscription'
				}
			end

			def mount_route
				msg_type = params[:xml][:MsgType]
				msg_content = params[:xml][:Content]
				event = params[:xml][:Event]
				event_key = params[:xml][:EventKey]

        			return :reply_? if ["?", "？"].include?(msg_content)
        			return ("reply_" + msg_content).to_sym if ["1", "2", "3", "4" , "5", "6"].include?(msg_content)
			        return ("click_" + msg_type.downcase).to_sym if ["subscribe", "unsubscribe"].include?(msg_type)
				return ("click_" + event_key.downcase).to_sym if ["INTERNSHIP_RECRUIT", "CAMPUS_RECRUIT", 
					"SOCIAL_RECRUIT", "AUDITION_GUIDE", "RESUME_GUIDE", "JOBS_SUBSCRIPTION", "HELP"].include?(event_key)
			end

			def subscribe
				content = JobsInfo::Application.config.subscribe + JobsInfo::Application.config.help
				reply = reply_base.merge(reply_text(content))
				JSON.parse(reply.to_json).to_xml(:root => 'root')
			end

			def unsubscribe
				
			end

			def help
				content = JobsInfo::Application.config.help
				reply = reply_base.merge(reply_text(content))
				JSON.parse(reply.to_json).to_xml(:root => 'root')
			end

			def internship_recruit
				
			end

			def campus_recruit
				
			end

			def social_recruit
				
			end

			def audition_guide
				
			end

			def resume_guide
				
			end

			def jobs_subscription
				
			end

			def default
				
			end

		end

		namespace :weixin_io do

			desc 'Check the signature.'
			# params do
			# 	requires :timestamp, type: String, desc: "Timestamp."
			# 	requires :nonce, type: String, desc: "Nonce."
			# 	requires :signature, type: String, desc: "Signature."
			# end
			before do
				token = JobsInfo::Application.config.token
				authenticate!(token, params[:timestamp], params[:nonce], params[:signature])
			end

			desc 'Return the echostr when authenticated.'
			get do
				params[:echostr]
			end

			post do
				# Add xml content into params
				params[:xml] = Hash.from_xml(request.body.read)["xml"]
				begin
					router = mount_route
					send routers[router]
				rescue Exception => e
					# TODO
				end

			end
		end

	end

end