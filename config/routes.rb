Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :movies do
        resources :reviews,only: [:index,:create]
      end
    end
  end

  namespace :api do
    namespace :v1 do
      resources :movies do
        resources :movie_reviews
      end
    end
  end
  devise_for :users
  get 'home/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
   root "movies#index"
   resources :movies do
    resources :reviews
   end
end