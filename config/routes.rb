# config/routes.rb (ilustrativo / Rails-like)
Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :transactions, only: [:create]
      post "batches/:id/dispatch", to: "batches#dispatch"
    end
  end
end
