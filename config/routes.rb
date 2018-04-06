Rails.application.routes.draw do

  # Ajax
  get "/request_payment/:invoice_id"  => 'projects#request_payment', as: 'request_payment'
  get "/cancel_request_payment/:invoice_id"  => 'projects#cancel_request_payment', as: 'cancel_request_payment'

  get "/set_project/:id/current_task/:invoice_item_id" => 'projects#set_current_task', as: 'set_current_task'

  get "/open_sprint/:invoice_id" => 'invoices#open_sprint_inline', as: 'open_sprint'
  get "/close_sprint/:invoice_id" => 'invoices#close_sprint_inline', as: 'close_sprint'

  get "/edit_note_modal/:note_id" => 'notes#edit_note_modal', as: 'edit_note_modal'
  match '/update_note_modal' => 'notes#update_note_modal', via: [:post], as: 'update_note_modal'
  get "/delete_note_inline/:note_id" => 'notes#delete_note_inline', as: 'delete_note_inline'
  match '/create_note_modal', to: 'notes#create_note_modal', via: [:post], as: 'create_note_modal'
  match '/create_project_update_modal', to: 'notes#create_project_update_modal', via: [:post], as: 'create_project_update_modal'

  get "/fetch_discussion/:note_id" => 'discussions#fetch_discussion', as: 'fetch_discussion'

  get "/cancel_task_update/:invoice_id" => 'invoice_items#cancel_update', as: 'cancel_task_update'
  get "/edit_task_inline/:task_id" => 'invoice_items#edit_inline', as: 'edit_task_inline'
  match '/update_task_inline' => 'invoice_items#update_inline', via: [:post], as: 'update_task_inline'
  get "/delete_task_inline/:task_id" => 'invoice_items#delete_inline', as: 'delete_task_inline'
  get "/create_task_inline/:invoice_id" => 'invoice_items#create_inline', as: 'create_task_inline'
  match '/save_task_inline', to: 'invoice_items#save_inline', via: [:post], as: 'save_task_inline'

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
