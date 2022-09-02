Rails.application.routes.draw do
  authenticated :user, ->(user) { user.admin? } do
    get 'admin', to: "admin#index", as: "dashboard"
    get 'admin/show_user/:id', to: "admin#show_user", as: "show_user"
    get 'admin/new_user', to: "admin#new_user", as: "new_user"
    get 'admin/edit_user/:id', to: "admin#edit_user", as: "edit_user"

    post 'admin/', to: "admin#create_user", as: "create_user"

    patch 'admin/approve_user/:id', to: "admin#approve_user", as: "approve_user"
    
  end
  devise_for :users
  root "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get "/transactions/", to: "transactions#index"
  get "/transactions/new", to: "transactions#new", as: "new_transaction"
  post "/transactions", to: "transactions#create", as: "create_transaction"
  delete '/transactions/:id', to: 'transactions#delete', as: 'delete_transaction'

  get "pages/home", to: "pages#home", as: "pages_home"
  get "pages/about", to: "pages#about", as: "pages_about"
end
