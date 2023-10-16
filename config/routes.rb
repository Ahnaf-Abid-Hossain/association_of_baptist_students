Rails.application.routes.draw do
  get 'approvals/index'
  resources :prayer_requests
  resources :meeting_notes

  # TODO: update this with only the routes we need
  resources :links
    # Add this route for the approval page
  get 'approvals/index'
  # -=-=-=-=-
  # New routing
  root 'users#index'


  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  devise_scope :user do
    get 'users/sign_in', to: 'users/sessions#new', as: :new_user_session
    get 'users/sign_out', to: 'users/sessions#destroy', as: :destroy_user_session
  end


  resources :users do
    resources :meeting_notes
    member do
      patch 'approve'
      patch 'decline'
    end
  end

  resources :users
  get '/search', to: 'users#temp_search', as: :search_user
  get '/basic_search', to: 'users#basic_search', as: :basic_search_user

  resources :users do
    get '/profile', on: :member, to: 'users#profile'
  end

  resources :users do
    get '/privacy_settings', on: :member, to: 'users#privacy_settings'
  end

  resources :users
  get '/account_created', to: 'users#account_created'
  

end
