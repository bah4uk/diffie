Diffie::Application.routes.draw do
  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  match '/home/:action', controller: "home", as: "home"
  match 'dh_calculate' => 'home#dh_calculate'

  devise_for :users
  resources :users
end
