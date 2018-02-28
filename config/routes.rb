Rails.application.routes.draw do
  resources :projects

  devise_for :users

  # get 'users/sign_out' => "devise/sessions#destroy"
  # devise_for :users, controllers: {
  #     sessions: 'users/sessions'
  # }

  # get 'main/home'
  #

  unauthenticated do
    root to: 'main#home'
  end

  authenticated do
    root :to => 'main#authenticated_home'
  end

end
