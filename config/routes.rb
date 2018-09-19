Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  resources :tasks
  resources :states
  resources :users do
    resources :lists
    end
    
  resources :users
  get '/' => "front#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
