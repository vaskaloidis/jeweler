Rails.application.routes.draw do

  # Ajax
  get "/request_payment/:invoice_id"  => 'projects#request_payment', as: 'request_payment'
  get "/cancel_request_payment/:invoice_id"  => 'projects#cancel_request_payment', as: 'cancel_request_payment'

  get "/set_project/:id/current_task/:invoice_item_id" => 'projects#set_current_task', as: 'set_current_task'

  get "/delete_note_inline/:note_id" => 'notes#delete_note_inline', as: 'delete_note_inline'
  match '/create_note_modal', to: 'notes#create_note_modal', via: [:post], as: 'create_note_modal'
  match '/create_project_update_modal', to: 'notes#create_project_update_modal', via: [:post], as: 'create_project_update_modal'

  get "/fetch_discussion/:note_id" => 'discussions#fetch_discussion', as: 'fetch_discussion'

  get "/delete_task_inline/:invoice_item_id" => 'invoice_items#delete_task_inline', as: 'delete_task_inline'
  get "/create_task_inline/:invoice_id" => 'invoice_items#create_task_inline', as: 'create_task_inline'
  match 'save_task_inline', to: 'invoice_items#save_task_inline', via: [:post], as: 'save_task_inline'

  # Github Webhooks
  get '/oath', to: 'webhook#save_oath', as: 'oath_save'
  post '/hook', to: 'webhook#hook', as: 'webhook_execute'


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
