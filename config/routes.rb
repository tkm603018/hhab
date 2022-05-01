Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root :to => 'top#index'
  get '/overview', to: 'overview#index'
  get '/monthly', to: 'monthly#index'
  resources :items, only: [:index, :show, :new, :create, :update, :destroy]
  resources :users, only: [:index, :show, :new, :create, :update]
  resources :sessions, only: [:create, :destroy]
  resource :user_profile, only: [:show]

  # namespace :api do
  #   namespace :v1 do
  #     # users
  #     # resources :users, only:[:index]
  #     resources :users, only:[] do
  #       get :current_user, action: :show, on: :collection
  #     end

  #     # 追加
  #     # login, logout
  #     resources :user_token, only: [:create] do
  #       delete :destroy, on: :collection
  #     end
  #     # ここまで
  #   end
  # end
  # post 'authenticate', to: 'authentication#authenticate'
end
