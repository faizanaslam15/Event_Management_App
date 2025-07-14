Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post "/signup", to: "auth#signup"
      post "/login", to: "auth#login"

      resources :events do
        collection do
          get :upcoming
          get :past
        end
        post :rsvp, to: "rsvps#create"
      end
    end
  end
end
