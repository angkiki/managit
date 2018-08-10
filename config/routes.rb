Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations", sessions: "users/sessions" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#home'

  # ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~
  #            home controller
  # ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~
  get 'dashboard', to: 'home#dashboard'

  # ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~
  #          projects controller
  # ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~
  resources :projects, only: [:new, :create, :show]
end
