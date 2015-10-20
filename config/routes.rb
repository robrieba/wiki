Rails.application.routes.draw do

  root to: 'welcome#index'

  get 'wiki_entries/public' => 'wiki_entries#public'
  resources :wiki_entries
  resources :charges, only: [:new, :create]
  get 'downgrade/charge' => 'charges#downgrade'

  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    sign_up: 'signup',
    confirmation: 'verification',
    registration: 'register',
    edit: 'edit/profile'
  }

end
