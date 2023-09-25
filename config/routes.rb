Rails.application.routes.draw do
  resources :prayer_requests
  resources :meeting_notes
  # -=-=-=-=-
  # New routing
  root 'alumnis#index'

  resources :alumnis do
    resources :meeting_notes
  end

  resources :alumnis
  get '/search', to: 'alumnis#temp_search', as: :search_alumni

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  devise_scope :user do
    get 'users/sign_in', to: 'users/sessions#new', as: :new_user_session
    get 'users/sign_out', to: 'users/sessions#destroy', as: :destroy_user_session
  end
end
