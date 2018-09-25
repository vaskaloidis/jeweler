Rails.application.routes.draw do

  shallow do
    resources :sprints do
      resources :tasks
    end
    resources :notes do
      resources :discussions
    end
    resources :projects do
      resources :notes
      resources :sprints
      resources :project_developers, only: %i[leave remove] #TODO: Remove or fix
      resources :project_customers, only: %i[leave remove] #TODO: Remove or fix
      resources :payments
      resources :invitations, only: %i[accept decline create]
    end
  end
  resources :invitations
  resources :tasks
  resources :charges

  # Projects
  get '/:id/settings', to: 'projects#settings', as: 'project_settings'

  # Shared TODO: Convert any 'Inline' Actions to use its 'Stock' Controller Actions
  match '/new_charge_modal', to: 'charges#generate_modal', via: [:post], as: 'generate_charge_modal'
  get '/commit_codes_modal', to: 'projects#commit_codes_modal', as: 'commit_codes'

  # Payments
  get '/pay/:project_id', to: 'payments#unauthenticated_payment', as: 'customer_project_payment'
  get '/pay/sprint/:sprint_id', to: 'sprints#make_payment', via: [:post], as: 'customer_sprint_payment'

  # Invitations
  get '/invitation/:id/accept', to: 'invitations#accept', as: 'accept_invitation'
  get '/invitation/:id/decline', to: 'invitations#decline', as: 'decline_invitation'
  delete 'invitation/:id/destroy', to: 'invitations#destroy', as: 'destroy_invitation'

  # Project Users: Customers and Developers
  get '/project/:id/users', to: 'projects#users', as: 'project_users'
  get '/developer_leave/:project_id/', to: 'project_developers#leave', as: 'developer_leave_project'
  delete '/project/:project_id/remove_developer/:user_id', to: 'project_developers#remove', as: 'remove_project_developer'
  get '/customer_leave/:project_id/', to: 'project_customers#leave', as: 'customer_leave_project'
  delete '/project/:project_id/remove_customer/:user_id', to: 'project_customers#remove', as: 'remove_project_customer'

  # Invoices
  get '/invoice/:sprint_id/generate/:estimate', to: 'invoices#generate', as: 'generate_invoice'
  get '/invoice/:sprint_id/select_customer/:estimate/:goal', to: 'invoices#select_customer', as: 'select_invoice_customer'
  post '/invoice/review', to: 'invoices#review', as: 'review_customer_invoice'
  post '/invoice/print', to: 'invoices#print', as: 'print_invoice'
  post '/invoice/send', to: 'invoices#send_invoice', as: 'send_invoice'

  # Sprints
  get '/sprint/:id/edit_description', to: 'sprints#edit_description', as: 'edit_sprint_description'
  get '/sprint/:id/render', to: 'sprints#render_panel', as: 'render_sprint'
  get '/sprint/:id/current', to: 'sprints#set_current', as: 'set_current_sprint'
  get '/sprint/:id/open', to: 'sprints#open', as: 'open_sprint'
  get '/sprint/:id/close', to: 'sprints#close', as: 'close_sprint'
  get '/sprint/:id/request_payment', to: 'sprints#request_payment', as: 'request_payment'
  get '/sprint/:id/cancel_payment_request', to: 'sprints#cancel_payment_request', as: 'cancel_payment_request'

  # Tasks
  get '/task/:id/current' => 'tasks#set_current', as: 'set_current_task'
  get '/task/:id/complete' => 'tasks#complete', as: 'complete_task'
  get '/task/:id/uncomplete' => 'tasks#uncomplete', as: 'uncomplete_task'
  get '/task/cancel/:sprint_id' => 'tasks#cancel', as: 'cancel_task_update'

  # Notes
  get '/notes/timeline_query/:project_id/:sprint_query/:note_type', to: 'notes#note_query', as: 'note_query'
  get '/notes/delete_note_inline/:note_id' => 'notes#delete_note_inline', as: 'delete_note_inline'
  get '/notes/create_note_modal/:project_id', to: 'notes#new_modal', as: 'create_note_modal'

  # Discussions
  post '/discussions/create_message', to: 'discussions#create_message', as: 'create_discussion_message'
  get '/discussions/fetch/:note_id', to: 'discussions#fetch', as: 'fetch_discussion'

  # Github Webhooks
  get '/github/oauth/(:project_id)', to: 'github#save_oauth', as: 'github_oauth_save'
  get '/github/authorize/(:project_id)', to: 'github#authorize_account', as: 'authorize_github'
  post '/github/hook/push', to: 'github#hook', as: 'github_push_hook'
  get '/github/install_webhook/:project_id', to: 'github#install_webhook', as: 'install_github_webhook'
  get '/github/sync_commits/project/:project_id/sync_commits', to: 'github#sync_commits', as: 'sync_github_commits'
  delete '/github/disconnect', to: 'github#delete_oauth', as: 'disconnect_github'

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
