JobsInfo::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # Code is not reloaded between requests.
  config.cache_classes = true

  # Eager load code on boot. This eager loads most of Rails and
  # your application in memory, allowing both thread web servers
  # and those relying on copy on write to perform better.
  # Rake tasks automatically ignore this option for performance.
  config.eager_load = true

  # Full error reports are disabled and caching is turned on.
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Enable Rack::Cache to put a simple HTTP cache in front of your application
  # Add `rack-cache` to your Gemfile before enabling this.
  # For large-scale production use, consider using a caching reverse proxy like nginx, varnish or squid.
  # config.action_dispatch.rack_cache = true

  # Disable Rails's static asset server (Apache or nginx will already do this).
  config.serve_static_assets = false

  # Compress JavaScripts and CSS.
  config.assets.js_compressor = :uglifier
  # config.assets.css_compressor = :sass

  # Do not fallback to assets pipeline if a precompiled asset is missed.
  config.assets.compile = false

  # Generate digests for assets URLs.
  config.assets.digest = true

  # Version of your assets, change this if you want to expire all your assets.
  config.assets.version = '1.0'

  # Specifies the header that your server uses for sending files.
  # config.action_dispatch.x_sendfile_header = "X-Sendfile" # for apache
  # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' # for nginx

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  # config.force_ssl = true

  # Set to :debug to see everything in the log.
  config.log_level = :info

  # Prepend all log lines with the following tags.
  # config.log_tags = [ :subdomain, :uuid ]

  # Use a different logger for distributed setups.
  # config.logger = ActiveSupport::TaggedLogging.new(SyslogLogger.new)

  # Use a different cache store in production.
  # config.cache_store = :mem_cache_store

  # Enable serving of images, stylesheets, and JavaScripts from an asset server.
  # config.action_controller.asset_host = "http://assets.example.com"

  # Precompile additional assets.
  # application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
  # config.assets.precompile += %w( search.js )

  # Ignore bad email addresses and do not raise email delivery errors.
  # Set this to true and configure the email server for immediate delivery to raise delivery errors.
  # config.action_mailer.raise_delivery_errors = false

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation can not be found).
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners.
  config.active_support.deprecation = :notify

  # Disable automatic flushing of the log to improve performance.
  # config.autoflush_log = false

  # Use default logging formatter so that PID and timestamp are not suppressed.
  config.log_formatter = ::Logger::Formatter.new

  # For using path helper in grape
  routes.default_url_options = { host: "http://jobsinfo.herokuapp.com" }

  config.host = "http://jobsinfo.herokuapp.com"

  # Weixin appID
  config.app_id = "wx074ca22d91b63108"

  # Weixin appsecret
  config.app_secret = "89e17e1138fa04e2dee1e35af6ec7355"

  # Weixin api configuration token
  config.token = "h2tng64uied3q11awk"

  # Text for subscription
  config.subscribe =  "您好, 欢迎关注 Jobs Info.\n"

  # Text for help
  config.help = "回复对应数字符号, 或点击菜单获取消息.\n目前支持的功能如下:\n\n--- 招聘资讯 ---\n  1. 实习招聘\n  2. 校园招聘\n  3. 社会招聘\n\n--- 求职助手 ---\n  4. 面试宝典\n  5. 简历模板\n\n----- 更多 -----\n  6. 订阅职位\n  ?. 使用帮助\n"

  # Text for jobs subscription
  config.jobs_subscription = "订阅职位用于筛选出您关注职位的招聘资讯.\n"
  # Text for unknow message type
  config.unknow = "未知消息类型."

  # Text for no records
  config.no_records= "未找到符合条件的资讯信息."

  # Hash for function
  config.function = {
      :internship_recruit => "1",
      :campus_recruit => "2",
      :social_recruit => "3",
      :audition_guide => "4",
      :resume_guide => "5",
      :jobs_subscription => "6",
      :help => "?"
    }

end
