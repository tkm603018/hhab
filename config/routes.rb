Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      # users
      # resources :users, only:[:index]
      resources :users, only:[] do
        get :current_user, action: :show, on: :collection
      end

      # 追加
      # login, logout
      resources :user_token, only: [:create] do
        delete :destroy, on: :collection
      end
      # ここまで
    end
  end
  post 'authenticate', to: 'authentication#authenticate'
end
