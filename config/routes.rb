Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  unless Rails.env.production?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  get '/admin' => 'admin#index'
  get '/monthly', to: 'monthly#index'
  get '/archive/', to: 'archive#index'
  get '/archive/:slug', to: 'archive#subindex'
  get '/archive/:slug/:subslug', to: 'archive#subsubindex'
  
  # resources :stores, only: [:index, :show, :create, :destroy]
  get 'stores/:title', to: 'stores#show'
  get 'stores/', to: 'stores#index'
  delete 'stores/:title', to: 'stores#destroy'
  post 'stores/:title', to: 'stores#create'

  resources :items, only: [:index, :edit, :new, :create, :update, :destroy]

  resources :users, only: [:new, :create, :update]
  resources :sessions, only: [:create, :destroy]
  resource :user_profile, only: [:show]
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]

  root :to => 'top#index'
  get '/:slug', to: 'top#show'
  get '/:slug/months', to: 'top#months'
  get '/:slug/months/:month', to: 'top#items'

end
