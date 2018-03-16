Rails.application.routes.draw do

  # Ajax
  get "/request_payment/:id"  => 'projects#request_payment', as: 'request_payment'
  get "/fetch_discussion/:id" => 'discussions#fetch_discussion', as: 'fetch_discussion'

  resources :payments
  resources :invoice_items
  resources :invoices
  resources :project_customers
  resources :notes
  resources :discussions

  resources :projects do
    resources :project_customers
    resources :notes do
      resources :discussions
    end
  end

  devise_for :users

  unauthenticated do
    root to: 'main#home'
  end

  authenticated do
    root :to => 'main#authenticated_home'
  end

end
