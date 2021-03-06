Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/admin' => 'admin#index'
  get '/monthly', to: 'monthly#index'
  get '/archive/', to: 'archive#index'
  get '/archive/:slug', to: 'archive#subindex'
  get '/archive/:slug/:subslug', to: 'archive#subsubindex'
  
  
  resources :items, only: [:index, :edit, :new, :create, :update, :destroy]
  resources :users, only: [:new, :create, :update]
  resources :sessions, only: [:create, :destroy]
  resource :user_profile, only: [:show]


  root :to => 'top#index'
  get '/:slug', to: 'top#show'
  get '/:slug/months', to: 'top#months'
  get '/:slug/months/:month', to: 'top#items'
end
