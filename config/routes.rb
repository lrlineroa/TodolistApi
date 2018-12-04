Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  resources :lists do
    resources :tasks
  end
  
  resources :states
  resources :users do
    resources :lists
  end
    
  resources :users
  post 'users/:user_id/tasks/:task_id/states/:state_id',to:'tasks#changeState'
  get '/' => "front#index"
  get 'users/sharing_list/:list_id',to:'users#getUsersForSharingList'
  post "users/:user_id/lists/:list_id/guest/:guest_id/:type/:value", to: 'lists#configShares'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
