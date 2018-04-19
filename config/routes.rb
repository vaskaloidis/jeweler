Rails.application.routes.draw do

  # Ajax

  get '/leave_project/:project_id/:user_id', to: 'project_customers#leave_project', as: 'leave_project'

  get '/accept_invitation/:invitation_id', to: 'invitations#accept_invitation', as: 'accept_invitation'
  get '/decline_invitation/:invitation_id', to: 'invitations#decline_invitation', as: 'decline_invitation'

  match '/create_chat_message', to: 'discussions#create_chat_message_inline', via: [:post], as: 'create_chat_message_inline'

  get '/open_payment/:project_id', to: 'invoices#open_payment', as: 'open_payment'
  get '/open_sprint_payment/:invoice_id', to: 'invoices#open_sprint_payment', as: 'open_sprint_payment'
  match '/make_payment', to: 'invoices#make_payment', via: [:post], as: 'make_payment'

  match '/create_customer_inline', to: 'project_customers#create_customer_inline', via: [:post], as: 'create_customer_inline'
  get '/remove_customer/:project_id/:user_id', to: 'project_customers#remove_customer_inline', as: 'remove_customer_inline'
  get '/remove_invitation/:invitation_id', to: 'invitations#remove_invitation_inline', as: 'remove_invitation_inline'

  get "/request_payment/:invoice_id"  => 'projects#request_payment', as: 'request_payment'
  get "/cancel_request_payment/:invoice_id"  => 'projects#cancel_request_payment', as: 'cancel_request_payment'

  get "/set_current_sprint/:invoice_id" => 'invoices#set_current_sprint', as: 'set_current_sprint'
  get "/set_current_task/:invoice_item_id" => 'invoices#set_current_task', as: 'set_current_task'

  get "/open_sprint/:invoice_id" => 'invoices#open_sprint_inline', as: 'open_sprint'
  get "/close_sprint/:invoice_id" => 'invoices#close_sprint_inline', as: 'close_sprint'


  get "/edit_note_modal/:note_id" => 'notes#edit_note_modal', as: 'edit_note_modal'
  match '/update_note_modal' => 'notes#update_note_modal', via: [:post], as: 'update_note_modal'
  get "/delete_note_inline/:note_id" => 'notes#delete_note_inline', as: 'delete_note_inline'
  match '/create_note_modal', to: 'notes#create_note_modal', via: [:post], as: 'create_note_modal'
  match '/create_project_update_modal', to: 'notes#create_project_update_modal', via: [:post], as: 'create_project_update_modal'

  get "/fetch_discussion/:note_id" => 'discussions#fetch_discussion', as: 'fetch_discussion'

  get "/complete_task/:invoice_item_id" => 'invoice_items#complete_task', as: 'complete_task'
  get "/uncomplete_task/:invoice_item_id" => 'invoice_items#uncomplete_task', as: 'uncomplete_task'

  get "/cancel_task_update/:invoice_id" => 'invoice_items#cancel_update', as: 'cancel_task_update'
  get "/edit_task_inline/:task_id" => 'invoice_items#edit_inline', as: 'edit_task_inline'
  match '/update_task_inline' => 'invoice_items#update_inline', via: [:post], as: 'update_task_inline'
  get "/delete_task_inline/:task_id" => 'invoice_items#delete_inline', as: 'delete_task_inline'
  get "/create_task_inline/:invoice_id" => 'invoice_items#create_inline', as: 'create_task_inline'
  match '/save_task_inline', to: 'invoice_items#save_inline', via: [:post], as: 'save_task_inline'

  get '/authorize_github', to: 'webhook#authorize_account', as: 'authorize_github'

  # Github Webhooks
  get '/oath', to: 'webhook#save_oath', as: 'oath_save'
  post '/hook', to: 'webhook#hook', as: 'webhook_execute'

  # Scaffolds
  resources :invitations
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
    resources :invoices
  end

  # Devise
  devise_for :users

  # Home Pages
  unauthenticated do
    root to: 'main#home'
  end
  authenticated do
    root :to => 'main#authenticated_home'
  end

end
