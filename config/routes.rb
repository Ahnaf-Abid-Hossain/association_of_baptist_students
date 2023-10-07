Rails.application.routes.draw do
  resources :prayer_requests
  resources :meeting_notes

  # TODO: update this with only the routes we need
  resources :links

  # -=-=-=-=-
  # New routing
  root 'users#index'

  resources :users do
    resources :meeting_notes
  end

  resources :users
  get '/search', to: 'users#temp_search', as: :search_user

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  devise_scope :user do
    get 'users/sign_in', to: 'users/sessions#new', as: :new_user_session
    get 'users/sign_out', to: 'users/sessions#destroy', as: :destroy_user_session
  end
end
