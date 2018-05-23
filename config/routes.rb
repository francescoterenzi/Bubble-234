Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount ActionCable.server => '/cable'

  root to: "cocktails#index"

  devise_for :users, :path_names => {:sign_in => 'login', :sign_out => 'logout'}, :controllers => { registrations: 'registrations', omniauth_callbacks: 'users/omniauth_callbacks'}

  get 'users/myprofile'
  get 'users/:id/profile', to: 'users#profile', as: 'profile'
  get 'users/favorites'
  get 'users/results'

  get 'cocktails/random', to: 'cocktails#random', as: 'random'

  resources :chat_rooms, only: [:new, :create, :show, :index]

  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :relationships, only: [:create, :destroy]

  resources :cocktails do

    put :favorite, on: :member

    resources :reviews do
      member do
        post 'like'
        delete 'dislike'
      end
    end

  end

end
