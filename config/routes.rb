Rails.application.routes.draw do
  devise_for :users
  root "transactions#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get "/transactions/", to: "transactions#index"
  get "/transactions/new", to: "transactions#new", as: "new_transaction"
  post "/transactions", to: "transactions#create", as: "create_transaction"
  delete '/transactions/:id', to: 'transactions#delete', as: 'delete_transaction'

end
