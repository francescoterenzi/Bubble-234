Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#index"

  devise_for :users, :path_names => {:sign_in => 'login', :sign_out => 'logout'}, :controllers => { registrations: 'registrations'}

  get 'users/myprofile'
  get 'users/:id/profile', to: 'users#profile', as: 'profile'
  get 'users/favorites'
  get 'users/results'


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
