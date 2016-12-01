Rails.application.routes.draw do
  namespace :api, path: '/', defaults: { format: :json } do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      resources :bucketlists, except: [:new, :edit]
    end
  end

  post 'signup', to: 'users#create'
  post 'auth/login', to: 'authentication#login'
  get 'auth/logout', to: 'authentication#logout'
end
