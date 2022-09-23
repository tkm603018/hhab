Rails.application.routes.draw do
  get 'categories/index'
  get 'categories/show'
  get 'categories/new'
  get 'categories/create'
  get 'categories/edit'
  get 'categories/update'
  get 'categories/destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  unless Rails.env.production?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  root :to => 'welcome#index'
  get '/welcome' => 'welcome#index'
  get '/logged_in' => 'admin#index'
  get '/login' => 'sessions#unsigned'
  get '/monthly', to: 'monthly#index'
  get '/archive/', to: 'archive#index'
  get '/archive/:slug', to: 'archive#subindex'
  get '/archive/:slug/:subslug', to: 'archive#subsubindex'
  
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
  resources :categories, only: [:index, :new, :create, :edit, :update, :destroy]

end
