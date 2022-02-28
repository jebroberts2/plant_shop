Rails.application.routes.draw do
  root to: 'api/api#welcome', via: [:get, :post]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    resources :orders, only: [:create] do
      collection do
        get :retrieve_by_number
        get :retrieve_by_customer
      end
    end

    resources :plants, only: [:index]
  end
end
