Rails.application.routes.draw do
<<<<<<< HEAD
=======
  
>>>>>>> add-post
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'welcome#index'
  resources :posts do 
    resources :comments, only: [:create]
  end
end
