Rails.application.routes.draw do

  # Ajax TODO: Convert any 'Inline' Actions to use Stock Controller Actions
  match '/new_charge_modal', to: 'charges#generate_modal', via: [:post], as: 'generate_charge_modal'
  get '/commit_codes_modal', to: 'projects#commit_codes_modal', as: 'commit_codes'

  # Payments
  get '/pay/:project_id', to: 'payments#unauthenticated_payment', as: 'customer_project_payment'
  get '/pay/sprint/:sprint_id', to: 'sprints#make_payment', via: [:post], as: 'customer_sprint_payment'

  # Invitations
  get '/invitation/:id/accept', to: 'invitations#accept', as: 'accept_invitation'
  get '/invitation/:id/decline', to: 'invitations#decline', as: 'decline_invitation'
  delete 'invitation/:id/destroy', to: 'invitations#destroy', as: 'destroy_invitation'

  # Customers
  get '/project/:project_id/leave/:user_id', to: 'project_customers#leave', as: 'leave_project'
  delete '/project/:project_id/remove/:user_id', to: 'project_customers#remove', as: 'remove_customer'

  # Invoices
  get '/invoice/:sprint_id/generate/:estimate', to: 'invoices#generate', as: 'generate_invoice'
  get '/invoice/:sprint_id/select_customer/:estimate/:goal', to: 'invoices#select_customer', as: 'select_invoice_customer'
  post '/invoice/review', to: 'invoices#review', as: 'review_customer_invoice'
  post '/invoice/print', to: 'invoices#print', as: 'print_invoice'
  # post '/invoice/send', to: 'invoices#send', as: 'send_invoice'

  # Sprints
  get '/sprint/:id/edit_description', to: 'sprints#edit_description', as: 'edit_sprint_description'
  get '/sprint/:id/render', to: 'sprints#render_panel', as: 'render_sprint'
  get '/sprint/:id/current', to: 'sprints#set_current', as: 'set_current_sprint'
  get '/sprint/:id/open', to: 'sprints#open', as: 'open_sprint'
  get '/sprint/:id/close', to: 'sprints#close', as: 'close_sprint'
  get '/sprint/:id/request_payment', to: 'sprints#request_payment', as: 'request_payment'
  get '/sprint/:id/cancel_payment_request', to: 'sprints#cancel_payment_request', as: 'cancel_payment_request'

  # Tasks
  get '/task/:id/complete' => 'tasks#complete', as: 'complete_task'
  get '/task/:id/uncomplete' => 'tasks#uncomplete', as: 'uncomplete_task'
  get '/task/cancel/:sprint_id' => 'tasks#cancel', as: 'cancel_task_update'
  get '/task/current/:id' => 'tasks#set_current', as: 'set_current_task'

  # Notes
  get '/notes/timeline_query/:project_id/:sprint_query/:note_type', to: 'notes#note_query', as: 'note_query'
  get '/notes/delete_note_inline/:note_id' => 'notes#delete_note_inline', as: 'delete_note_inline'
  get '/notes/create_note_modal/:project_id', to: 'notes#new_modal', as: 'create_note_modal'

  # Discussions
  post '/discussions/create_message', to: 'discussions#create_message', as: 'create_discussion_message'
  get '/discussions/fetch/:note_id', to: 'discussions#fetch', as: 'fetch_discussion'

  # Github Webhooks
  get '/github_oauth', to: 'github#save_oauth', as: 'github_oauth_save'
  post '/github_hook', to: 'github#hook', as: 'execute_github_webhook'
  get '/github_authorize', to: 'github#authorize_account', as: 'authorize_github'
  get '/github_install_webhook/:project_id', to: 'github#install_webhook', as: 'install_github_webhook'

  # Scaffolds TODO: Cleanup route resource scaffolds
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
