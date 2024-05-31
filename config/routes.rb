Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "payrolls#index"
  devise_for :users, path: 'auth'

  get '/terms_of_use_and_privacy_statement' => 'static_pages#terms_of_use_and_privacy_statement', as: 'terms_of_use_and_privacy_statement'
  get '/ada/:id' => 'payrolls#ada', as: 'ada'

  resources :payrolls
  resources :users
  resources :part_time_entries
  resources :cos_entries
end
