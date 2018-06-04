Rails.application.routes.draw do

  # Ajax TODO: Convert any 'Inline' Actions to use Stock Controller Actions
  get '/install_github_webhook/:project_id', to: 'webhook#install_webhook', as: 'install_github_webhook'
  match '/new_charge_modal', to: 'charges#generate_modal', via: [:post], as: 'generate_charge_modal'
  get '/commit_codes_modal', to: 'projects#commit_codes_modal', as: 'commit_codes'

  # Payments
  get '/pay/:project_id', to: 'payments#unauthenticated_payment', as: 'pay'
  get '/request_payment/:sprint_id', to: 'projects#request_payment', as: 'request_payment'
  get '/cancel_payment_request/:sprint_id', to: 'projects#cancel_request_payment', as: 'cancel_request_payment'
  # match '/make_payment', to: 'sprints#make_payment', via: [:post], as: 'make_payment'

  # Invitations
  get '/invitation/:id/accept', to: 'invitations#accept', as: 'accept_invitation'
  get '/invitation/:id/decline', to: 'invitations#decline', as: 'decline_invitation'

  # Customers API Calls (TODO: re-implement these eventually)
  get '/project/:project_id/leave/:user_id', to: 'project_customers#leave', as: 'leave_project'
  delete '/project/:project_id/remove/:user_id', to: 'project_customers#remove', as: 'remove_customer'

  # Invoices
  get '/print_invoice/:sprint_id/:estimate', to: 'invoices#print_invoice', as: 'print_invoice'
  get '/generate_invoice/:sprint_id/:estimate', to: 'invoices#generate_invoice', as: 'generate_invoice'
  match '/invoices', to: 'invoices#send_invoice', via: [:post], as: 'send_invoice'
  match '/invoices', to: 'invoices#review_customer_invoice', via: [:post], as: 'review_customer_invoice'
  get '/generate_customer_invoice/:sprint_id/:estimate', to: 'invoices#generate_customer_invoice', as: 'generate_customer_invoice'

  # Sprints
  get '/sprint/:id/edit_description', to: 'sprints#edit_description', as: 'edit_sprint_description'
  get '/sprint/:id/render', to: 'sprints#render_panel', as: 'render_sprint'
  get '/sprint/:id/current', to: 'sprints#set_current', as: 'set_current_sprint'
  get '/sprint/:id/open', to: 'sprints#open', as: 'open_sprint'
  get '/sprint/:id/close', to: 'sprints#close', as: 'close_sprint'

  # Tasks
  get '/task/:id/complete' => 'tasks#complete', as: 'complete_task'
  get '/task/:id/uncomplete' => 'tasks#uncomplete', as: 'uncomplete_task'
  get '/task/cancel/:sprint_id' => 'tasks#cancel', as: 'cancel_task_update'
  get '/task/current/:id' => 'tasks#set_current', as: 'set_current_task'

  # Notes
  get '/notes/timeline_query/:project_id/:sprint_query/:note_type', to: 'notes#note_query', as: 'note_query'
  get '/notes/delete_note_inline/:note_id' => 'notes#delete_note_inline', as: 'delete_note_inline'
  get '/notes/create_note_modal/:project_id', to: 'notes#create_note_modal', as: 'create_note_modal'

  # Discussions
  match '/create_chat_message', to: 'discussions#create_chat_message_inline', via: [:post], as: 'create_chat_message_inline'
  get '/fetch_discussion/:note_id' => 'discussions#fetch_discussion', as: 'fetch_discussion'

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
    resources :invitations
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
