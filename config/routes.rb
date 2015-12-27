Rails.application.routes.draw do
  resources :users do
    get  :forgot_password,     on: :collection
    post :send_password_reset, on: :collection
    get  :password_reset,      on: :member
    post  :password_reset,      on: :member
  end

  resources :messages

  get  "/login"  => "sessions#new",           :as => "login"
  get  "/logout" => "sessions#destroy",       :as => "logout"
  resources :sessions

  root "dashboard#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
end
