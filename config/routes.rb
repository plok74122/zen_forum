Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :topics do
  	resources :comments
  	collection do
  		get :about
  		# get :profile
  	end
  	member do
  		post :keep
  	end

  end


 resources :users 
 
 namespace :admin do
  root to: "topics#index"
  resources :topics , :only => [:index]
  resources :categorys 
  resources :users 

end

root to: "topics#index"
end
