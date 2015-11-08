Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :merchants, only: [:index,:show] do
        resources :items, only: [:index], module: "merchants"
        resources :invoices, only: [:index], module: "merchants"

        member do
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
          get 'revenue', to: "merchants#total_revenue"
        end
      end

      resources :invoices, only: [:index,:show] do
        resources :items, only: [:index], module: "invoices"
        resources :transactions, only: [:index], module: "invoices"
        resources :invoice_items, only: [:index], module: "invoices"

        member do
          get :customer, to: "invoices/customers#show"
          get :merchant, to: "invoices/merchants#show"
        end

        collection do
          get 'find'
          get 'find_all'
          get 'random'
        end
      end

      resources :items, only: [:index,:show] do
        resources :invoice_items, only: [:index], module: "items"

        member do
          get :merchant, to: "items/merchants#show"
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
          get "invoice", to: "transactions/invoices#show"
        end

        collection do
          get 'find'
          get 'find_all'
          get 'random'
        end
      end

      resources :customers, only: [:index,:show] do
        resources :invoices, only: [:index], module: "customers"
        resources :transactions, only: [:index], module: "customers"

        member do
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
          get "invoice", to: "invoice_items/invoices#show"
          get "item", to: "invoice_items/items#show"
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