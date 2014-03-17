require 'grape'

module Api
	class Weixin < Grape::API

		module Helpers

			def routers
				{
					subscribe: :subscribe ,
          				unsubscribe: :unsubscribe,

					reply_sx: :go_info_internship,
					click_internship: :go_info_internship,

					reply_xy: :go_info_campus,
					click_campus: :go_info_campus,

					reply_sh: :go_info_social,
					click_social: :go_info_social,

					reply_ms: :go_guides_audition
					click_audition: :go_guides_audition

					reply_jl: :go_guides_resume,
					click_resume: :go_guides_resume,

					reply_dy: :go_subscriptions,
					click_subscriptions: :go_subscriptions,

					reply_bz: :go_help,
					reply_?: :go_help,
					click_help: :go_help
				}
			end

		end
		
	end

end