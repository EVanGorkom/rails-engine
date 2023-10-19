Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show]
      resources :items
      # resources :transactions
      # resources :invoices
      # resources :invoice_items
      # resources :customers
    end
  end
end