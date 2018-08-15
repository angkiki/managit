Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations", sessions: "users/sessions" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#home'

  mount ActionCable.server, at: '/cable'

  # ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~
  #            home controller
  # ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~
  get 'dashboard', to: 'home#dashboard'
  get 'github/auth', to: 'home#github_auth', as: 'github_auth'
  get 'github/callback', to: 'home#callback', as: 'github_callback'

  # ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~
  #          projects controller
  # ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~
  resources :projects, only: [:new, :create, :show]
  get 'project/invite/:id', to: 'projects#invite_users', as: 'invite_users'
  post 'projects/invite', to: 'projects#invite_users_create', as: 'invite_users_create'
  get 'project/invite/accept/:proj_id', to: 'projects#accept_project_invitation', as: 'accept_project_invitation'
  get 'projects/:proj_id/new_issue', to: 'projects#new_issue', as: 'new_issue'
  post 'projects/:proj_id/create_issue', to: 'projects#create_issue', as: 'create_issue'

  # ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~
  #          features controller
  # ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~   ~ ~ ~
  get 'features/new/:proj_id', to: 'features#new', as: 'new_feature'
  post 'features', to: 'features#create', as: 'features'
  post 'features/:proj_id/completed/:feat_id', to: 'features#feature_completed', as: 'feature_completed'
end
