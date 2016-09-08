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


root to: "topics#index"
end
