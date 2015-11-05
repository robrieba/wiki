Rails.application.routes.draw do

  root to: 'welcome#index'

  get 'wiki_entries/public' => 'wiki_entries#public'
  resources :wiki_entries do
    resources :collaborators, only: [:index, :create, :destroy]
  end
  resources :charges, only: [:new, :create]

  get 'downgrade/charge' => 'charges#downgrade'

  devise_for :users, controllers: {registrations: 'devise/registrations' }

end
