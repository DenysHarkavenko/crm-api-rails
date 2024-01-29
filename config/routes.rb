Rails.application.routes.draw do
  devise_for :users
  namespace :api do
    resources :projects do
      resources :tasks
    end
    resource :sessions, only: [:create, :destroy]
  end
end
