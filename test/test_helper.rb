ENV['RAILS_ENV'] ||= 'test'
require_relative "../config/environment"
require "rails/test_help"

require "minitest/reporters"
Minitest::Reporters.use!

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize_setup do |worker|
    load "#{Rails.root}/db/seeds.rb"
  end
  
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  # fixtures :all

  # Add more helper methods to be used by all tests here...
  def active_user
    User.find_by(activated: true)
  end

  # 以下、追加
  def api_url(path = "/")
    "#{ENV["BASE_URL"]}/api/v1#{path}"
  end

  # コントローラーのJSONレスポンスを受け取る
  def response_body
    JSON.parse(@response.body)
  end

  # テスト用Cookie（Rack::Test::CookieJar Class）にトークンを保存する
  def logged_in(user)
    cookies[UserAuth.token_access_key] = user.to_token
  end
end
