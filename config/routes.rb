Rails.application.routes.draw do
  post "/graphql", to: "graphql#execute"
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  namespace :api do
    namespace :v1 do
      resources :companies
      resources :jobs
      resources :applications, only: [:index, :create]
      resources :comments, only: [:create]
    end
  end

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
