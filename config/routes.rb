Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :merchants, only: [:index,:show] do
        member do
          get :items
          get :invoices
          get :revenue
          get :favorite_customer
          get :customers_with_pending_invoices
        end

        collection do
          get 'find'
          get 'find_all'
          get 'random'
          get 'most_revenue'
          get 'most_items'
          get 'revenue'
        end
      end

      resources :invoices, only: [:index,:show] do
        member do
          get :items
          get :transactions
          get :invoice_items
          get :customer
          get :merchant
        end

        collection do
          get 'find'
          get 'find_all'
          get 'random'
        end
      end

      resources :items, only: [:index,:show] do
        member do
          get :invoice_items
          get :merchant
          get :best_day
        end

        collection do
          get 'find'
          get 'find_all'
          get 'random'
          get 'most_revenue'
          get 'most_items'
        end
      end

      resources :transactions, only: [:index,:show] do
        member do
          get :invoice
        end

        collection do
          get 'find'
          get 'find_all'
          get 'random'
        end
      end

      resources :customers, only: [:index,:show] do
        member do
          get :invoices
          get :transactions
          get :favorite_merchant
        end

        collection do
          get 'find'
          get 'find_all'
          get 'random'
        end
      end

      resources :invoice_items, only: [:index,:show] do
        member do
          get :invoice
          get :item
        end

        collection do
          get 'find'
          get 'find_all'
          get 'random'
        end
      end
    end
  end
end