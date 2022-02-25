Rails.application.routes.draw do
  root to: 'api/orders#test', via: [:get, :post]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    resources :orders do
      get :test
    end
  end
end
