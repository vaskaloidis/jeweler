Rails.application.routes.draw do
  get 'main/home'
  root to: 'main#home'
end
