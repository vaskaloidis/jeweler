Rails.application.routes.draw do

  # Ajax

  match '/new_charge_modal', to: 'charges#generate_modal', via: [:post], as: 'generate_charge_modal'

  get '/commit_codes_modal', to: 'projects#commit_codes_modal', as: 'commit_codes'

  # get '/display_payments_panel/:project_id', to: 'payments#display_panel', as: 'display_payments_panel'
  get '/request_payment/:invoice_id' => 'projects#request_payment', as: 'request_payment'
  get '/cancel_request_payment/:invoice_id' => 'projects#cancel_request_payment', as: 'cancel_request_payment'
  get '/open_payment/:project_id', to: 'invoices#open_payment', as: 'open_payment'
  get '/open_sprint_payment/:invoice_id', to: 'invoices#open_sprint_payment', as: 'open_sprint_payment'
  # match '/make_payment', to: 'invoices#make_payment', via: [:post], as: 'make_payment'

  get '/accept_invitation/:invitation_id', to: 'invitations#accept_invitation', as: 'accept_invitation'
  get '/decline_invitation/:invitation_id', to: 'invitations#decline_invitation', as: 'decline_invitation'

  get '/leave_project/:project_id/:user_id', to: 'project_customers#leave_project', as: 'leave_project'
  match '/create_customer_inline', to: 'project_customers#create_customer_inline', via: [:post], as: 'create_customer_inline'
  get '/remove_customer/:project_id/:user_id', to: 'project_customers#remove_customer_inline', as: 'remove_customer_inline'
  get '/remove_invitation/:invitation_id', to: 'invitations#remove_invitation_inline', as: 'remove_invitation_inline'

  get '/send_invoice/:invoice_id/:estimate', to: 'invoices#send_invoice', as: 'send_invoice'
  get '/print_invoice/:invoice_id/:estimate', to: 'invoices#print_invoice', as: 'print_invoice'

  get '/edit_description/:invoice_id', to: 'invoices#edit_description', as: 'edit_invoice_description'
  get '/generate_invoice/:invoice_id/:estimate', to: 'invoices#generate_invoice', as: 'generate_invoice'
  get '/render_invoice/:invoice_id', to: 'invoices#render_panel', as: 'render_invoice_panel'
  get '/set_current_sprint/:invoice_id' => 'invoices#set_current_sprint', as: 'set_current_sprint'
  get '/open_sprint/:invoice_id' => 'invoices#open_sprint_inline', as: 'open_sprint'
  get '/close_sprint/:invoice_id' => 'invoices#close_sprint_inline', as: 'close_sprint'

  get '/timeline_query/:project_id/:sprint_query/:note_type', to: 'notes#note_query', as: 'note_query'
  get '/delete_note_inline/:note_id' => 'notes#delete_note_inline', as: 'delete_note_inline'
  get '/create_note_modal/:project_id', to: 'notes#create_note_modal', as: 'create_note_modal'
  get '/create_project_update_modal/:project_id', to: 'notes#create_project_update_modal', as: 'create_project_update_modal'

  match '/create_chat_message', to: 'discussions#create_chat_message_inline', via: [:post], as: 'create_chat_message_inline'
  get '/fetch_discussion/:note_id' => 'discussions#fetch_discussion', as: 'fetch_discussion'

  get '/set_current_task/:invoice_item_id' => 'invoices#set_current_task', as: 'set_current_task'
  get '/complete_task/:invoice_item_id' => 'invoice_items#complete_task', as: 'complete_task'
  get '/uncomplete_task/:invoice_item_id' => 'invoice_items#uncomplete_task', as: 'uncomplete_task'
  get '/cancel_task_update/:invoice_id' => 'invoice_items#cancel_update', as: 'cancel_task_update'
  get '/edit_task_inline/:task_id' => 'invoice_items#edit_inline', as: 'edit_task_inline'
  match '/update_task_inline' => 'invoice_items#update_inline', via: [:post], as: 'update_task_inline'
  get '/delete_task_inline/:task_id' => 'invoice_items#delete_inline', as: 'delete_task_inline'
  get '/create_task_inline/:invoice_id' => 'invoice_items#create_inline', as: 'create_task_inline'
  match '/save_task_inline', to: 'invoice_items#save_inline', via: [:post], as: 'save_task_inline'

  get '/authorize_github', to: 'webhook#authorize_account', as: 'authorize_github'

  # Github Webhooks
  get '/oath', to: 'webhook#save_oath', as: 'oath_save'
  post '/hook', to: 'webhook#hook', as: 'webhook_execute'

  # Scaffolds
  resources :project_customers
  resources :notes
  resources :discussions

  resources :invitations
  resources :payments

  resources :invoice_items
  resources :invoices do
    resources :invoice_items
  end

  resources :projects do
    resources :notes do
      resources :discussions
    end
    resources :invoices do
      resources :invoice_items do
        resources :payments
      end
    end
    resources :project_customers
    resources :payments
  end

  # Stripe
  resources :charges

  # Devise
  devise_for :users, :controllers => {:omniauth_callbacks => "omniauth_callbacks"}


  # Home Pages
  unauthenticated do
    root to: 'main#home'
  end
  authenticated do
    root :to => 'main#authenticated_home'
  end

end
