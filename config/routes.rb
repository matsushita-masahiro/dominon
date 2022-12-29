Rails.application.routes.draw do
  

  get 'admins' => 'admins#top' 
  
  resources :matches do
    post 'match_end' => 'matches#match_end'
    get 'select_member' => 'matches#select_member'
    get 'enter_point' => 'matches#enter_point'
    post 'enter_point' => 'matches#input_point'
    resources :entries
    resources :match_innings do 
      resources :match_results, only: [:create, :update]
    end
    resources :users, except: [:index, :show, :create, :update, :destroy] do 
      resources :match_results
    end
  end
  
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions',
    :passwords => 'users/passwords',
    :confirmations => 'users/confirmations',
    :unlocks => 'users/unlocks',
  }

  devise_scope :user do
    # root :to => "users/sessions#new"
    get "signup", :to => "users/registrations#new"
    get "verify", :to => "users/registrations#verify"
    get "login", :to => "users/sessions#new"
    get "logout", :to => "users/sessions#destroy"
  end
  
  resources :users, only: [:index, :show]
  
  root 'home#top'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
