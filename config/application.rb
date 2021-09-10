require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Hhab
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    
    # Cookieを処理するmeddlewareを追加(APIモードにはデフォルトで入っていない)
    config.middleware.use ActionDispatch::Cookies
    # config.middleware.use Rack::Cors do
    #   allow do
    #     origins '*'
    #     resource '*', :headers => :any, :methods => [:get, :post, :delete, :put, :options]
    #   end
    # end
    
    config.autoload_paths << Rails.root.join('lib')

    # Zeitwerk（ツァイトベルク）にvalidator配下のファイルを読み込ます
    config.autoload_paths += %W(#{config.root}/lib/validator)
    config.api_only = true
  end
end
