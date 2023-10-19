Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index]
      end
      resources :items, except: [:new] do
        member do
          get 'merchant', to: 'items#show_merchant'
        end
      end
      # resources :transactions
      # resources :invoices
      # resources :invoice_items
      # resources :customers
    end
  end
end