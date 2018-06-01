Rails.application.routes.draw do

  # Ajax

  get '/install_github_webhook/:project_id', to: 'webhook#install_webhook', as: 'install_github_webhook'

  match '/new_charge_modal', to: 'charges#generate_modal', via: [:post], as: 'generate_charge_modal'

  get '/commit_codes_modal', to: 'projects#commit_codes_modal', as: 'commit_codes'

  # Payments
  get '/pay/:project_id', to: 'payments#unauthenticated_payment', as: 'pay'
  # get '/display_payments_panel/:project_id', to: 'payments#display_panel', as: 'display_payments_panel'
  get '/request_payment/:sprint_id' => 'projects#request_payment', as: 'request_payment'
  get '/cancel_request_payment/:sprint_id' => 'projects#cancel_request_payment', as: 'cancel_request_payment'
  get '/open_payment/:project_id', to: 'sprints#open_payment', as: 'open_payment'
  get '/open_sprint_payment/:sprint_id', to: 'sprints#open_sprint_payment', as: 'open_sprint_payment'
  # match '/make_payment', to: 'sprints#make_payment', via: [:post], as: 'make_payment'

  # Invitations
  get '/accept_invitation/:invitation_id', to: 'invitations#accept_invitation', as: 'accept_invitation'
  get '/decline_invitation/:invitation_id', to: 'invitations#decline_invitation', as: 'decline_invitation'

  # Customers
  get '/leave_project/:project_id/:user_id', to: 'project_customers#leave_project', as: 'leave_project'
  match '/create_customer_inline', to: 'project_customers#create_customer_inline', via: [:post], as: 'create_customer_inline'
  get '/remove_customer/:project_id/:user_id', to: 'project_customers#remove_customer_inline', as: 'remove_customer_inline'
  get '/remove_invitation/:invitation_id', to: 'invitations#remove_invitation_inline', as: 'remove_invitation_inline'

  # Invoices
  get '/print_invoice/:sprint_id/:estimate', to: 'invoices#print_invoice', as: 'print_invoice'
  get '/generate_invoice/:sprint_id/:estimate', to: 'invoices#generate_invoice', as: 'generate_invoice'
  match '/invoices', to: 'invoices#send_invoice', via: [:post], as: 'send_invoice'
  match '/invoices', to: 'invoices#review_customer_invoice', via: [:post], as: 'review_customer_invoice'
  get '/generate_customer_invoice/:sprint_id/:estimate', to: 'invoices#generate_customer_invoice', as: 'generate_customer_invoice'

  # Sprints
  get '/sprint/edit_description/:id', to: 'sprints#edit_description', as: 'edit_sprint_description'
  get '/sprint/render/:id', to: 'sprints#render_panel', as: 'render_sprint'
  get '/sprint/set_current_sprint/:id' => 'sprints#set_current_sprint', as: 'set_current_sprint'
  get '/sprint/open/:id' => 'sprints#open', as: 'open_sprint'
  get '/sprint/close/:id' => 'sprints#close', as: 'close_sprint'
  get '/sprint/set_current_task/:task_id' => 'sprints#set_current_task', as: 'set_current_task'

  # Notes
  get '/notes/timeline_query/:project_id/:sprint_query/:note_type', to: 'notes#note_query', as: 'note_query'
  get '/notes/delete_note_inline/:note_id' => 'notes#delete_note_inline', as: 'delete_note_inline'
  get '/notes/create_note_modal/:project_id', to: 'notes#create_note_modal', as: 'create_note_modal'

  # Discussions
  match '/create_chat_message', to: 'discussions#create_chat_message_inline', via: [:post], as: 'create_chat_message_inline'
  get '/fetch_discussion/:note_id' => 'discussions#fetch_discussion', as: 'fetch_discussion'

  # Tasks
  get '/complete_task/:id' => 'tasks#complete_task', as: 'complete_task'
  get '/uncomplete_task/:id' => 'tasks#uncomplete_task', as: 'uncomplete_task'
  get '/cancel_task_update/:sprint_id' => 'tasks#cancel_update', as: 'cancel_task_update'

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
  resources :tasks
  resources :sprints do
    resources :tasks
  end
  resources :projects do
    resources :notes do
      resources :discussions
    end
    resources :sprints do
      resources :tasks do
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
    get '/pay/:project_id', to: 'payments#unauthenticated_payment', via: 'pay'
  end
  authenticated do
    root :to => 'projects#index'
    get '/pay/:project_id', to: 'payments#index', via: 'pay'
  end

end
