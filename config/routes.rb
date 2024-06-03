Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "payslips#index"
  devise_for :users, path: 'auth'

  get '/terms_of_use_and_privacy_statement' => 'static_pages#terms_of_use_and_privacy_statement', as: 'terms_of_use_and_privacy_statement'
  get '/ada/:id' => 'payrolls#ada', as: 'ada'

  patch '/part_time_entries/approve/:id' => 'part_time_entries#approve', as: 'approve_part_time_entry'
  patch '/part_time_entries/reject/:id' => 'part_time_entries#reject', as: 'reject_part_time_entry'
  patch '/part_time_entries/calculate/:id' => 'part_time_entries#calculate', as: 'calculate_part_time_entry'
  # patch '/cos_entries/approve/:id' => 'cos_entries#approve', as: 'approve_cos_entry'
  # patch '/cos_entries/reject/:id' => 'cos_entries#reject', as: 'reject_cos_entry'
  # patch '/regular_entries/approve/:id' => 'regular_entries#approve', as: 'approve_regular_entry'
  # patch '/regular_entries/reject/:id' => 'regular_entries#reject', as: 'reject_regular_entry

  resources :payrolls
  resources :users
  resources :part_time_entries
  resources :cos_entries
  resources :regular_entries
  resources :profile, only: %i[index update]
  resources :payslips, only: %i[index show]
end
