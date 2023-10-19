Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show] do
        collection do
          get 'find', to: 'merchants#find'
          get 'find_all', to: 'merchants#find_all'
        end
        resources :items, only: [:index]
      end

      resources :items, except: [:new] do
        collection do
          get 'find', to: 'items#find'
          get 'find_all', to: 'items#find_all'
        end

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