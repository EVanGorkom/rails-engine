Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api do
    namespace :v1 do
      resources :transactions
      resources :merhcants
      resources :items
      resources :invoices
      resources :invoice_items
      resources :customers
    end
  end
end
