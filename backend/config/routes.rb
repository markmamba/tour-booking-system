Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    namespace :v1 do
      namespace :identities do
        post "login", controller: "auth", action: "login"
      end

      namespace :tours do
        get 'bookings', controller: "bookings", action: "index"
        post 'bookings', controller: "bookings", action: "create"
      end
    end
  end
end