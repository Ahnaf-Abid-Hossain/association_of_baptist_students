Rails.application.routes.draw do
  get 'approvals/index'
  resources :prayer_requests
  resources :meeting_notes

  resources :links, :except => [:show] do
    member do
      patch 'up'
      patch 'down'
    end
  end
    
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
    member do
      patch 'approve'
      patch 'decline'
      patch 'approve_admin'
    end
    post 'approve/:id', action: :approve, on: :member
    post 'reject/:id', action: :reject, on: :member
  end

  

  resources :approvals do
    get 'show_users', on: :collection
    get 'show_rejected_users', on: :collection
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
