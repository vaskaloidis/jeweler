Rails.application.routes.draw do
  resources :projects


  devise_for :users

  # devise_for :users, controllers: {
  #     sessions: 'users/sessions'
  # }


  get 'main/home'
  root to: 'main#home'
end
