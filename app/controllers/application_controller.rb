
# class ApplicationController < ActionController::API
#   include ActionController::Cookies
#   include UserAuth::Authenticator
  
#   before_action :authenticate_request
#   attr_reader :current_user

#   private

#   def authenticate_request
#     @current_user = AuthorizeApiRequest.call(request.headers).result
#     render json: { error: 'Not Authorized' }, status: 401 unless @current_user
#   end
# end

# class ApplicationController < ActionController::Base
# end
class ApplicationController < ActionController::API

  # 301リダイレクト(本番環境のみ有効)
  before_action :moved_permanently, if: :is_redirect

  include ActionController::Cookies
  include UserAuth::Authenticator

  # 以下、追加
  private

    # リダイレクト条件に一致した場合trueを返す
    def is_redirect
      target = "herokuapp.com"
      # include? => 文字列に引数の文字列が含まれている場合trueを返す
      Rails.env.production? && ENV["BASE_URL"] && request.host.include?(target)
    end

    # 301リダイレクトを行う
    def moved_permanently
      redirect_to "#{ENV["BASE_URL"]}#{request.path}", status: 301
    end
end
