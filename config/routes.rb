Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  resources :lists do
    resources :tasks
  end
  
  resources :states
  resources :users do
    resources :lists
    resources :tasks, only:[:create] do
      resources :states, only:[:create]
    end
  end
    
  resources :users
  get '/' => "front#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
